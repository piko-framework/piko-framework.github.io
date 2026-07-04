---
layout: default
title: Concepts
nav_order: 5
---

# Concepts

## Summary

- [Aliases](#aliases)
- [Components](#components)
- [Events](#events)
- [Behaviors](#behaviors)
- [Middleware](#middleware)
- [Dependency injection](#dependency-injection)

## Aliases

Aliases are a convenient way to work with filesystem paths and base URLs inside a Piko
application. An alias is a short name prefixed with `@` that represents a longer
path (directory, file path, URL, etc.).

During application initialisation, `Piko\Application` registers three aliases:

- `@app` – the application root path (`basePath` in the configuration)
- `@webroot` – the public web directory (defaults to `basePath . '/web'` unless
  `webroot` is provided in the configuration)
- `@web` – the base URI of the application (from the optional `baseUrl` setting)

Use [`Piko::getAlias()`](../api/Piko.md#method_getAlias) to resolve an alias
into its concrete value, and [`Piko::setAlias()`](../api/Piko.md#method_setAlias)
to register or override an alias.

- If the string passed to `getAlias()` does **not** start with `@`, it is
  returned unchanged.
- If the alias prefix is unknown, `getAlias()` returns `false`.

Example:

```php
// Built-in aliases
echo Piko::getAlias('@app/modules/site');
// /usr/local/share/myapp/modules/site

echo Piko::getAlias('@webroot/documents');
// /var/www/documents

echo Piko::getAlias('@web/css/styles.css');
// /css/styles.css

// Custom alias
Piko::setAlias('@lib', '/usr/local/share/lib');

echo Piko::getAlias('@lib/pdf/manual.pdf');
// /usr/local/share/lib/pdf/manual.pdf
```

## Components

Some objects must be shared across the whole application (database connections,
loggers, view renderers, user session managers, and so on). In Piko, these
application-wide singletons are called **components**.

Components are declared in the `components` section of the application
[configuration](application.md#configuration). The configuration is a
key–value array where **keys are usually the component class names** and values
can be one of the following:

- **Array of public properties** with an optional `construct` key specifying
  constructor arguments (lazy-loaded). The array key should be the fully
  qualified class name.
- **Array with a `class` key** plus optional `construct` and other public
  properties. This allows you to use a custom identifier as the array key.
- **Already instantiated object** (eagerly available).
- **Callable** that returns an instance (lazy-loaded factory).

Example component configuration:

```php
use Piko\View;
use Monolog\Logger;
use Monolog\Handler\StreamHandler;

return [
    // ...
    'components' => [
        // 1. View component configured via public properties
        View::class => [
            // Default charset is UTF-8
            'charset' => 'ISO-8859-1',
        ],

        // 2. Logger component created lazily via a factory
        Logger::class => function (): Logger {
            $logger = new Logger('app');
            $logger->pushHandler(
                new StreamHandler(__DIR__ . '/../var/log/app.log', Logger::DEBUG)
            );

            return $logger;
        },

        // 3. PDO configured using constructor arguments (lazy-loaded)
        PDO::class => [
            'construct' => [
                'mysql:dbname=' . getenv('MYSQL_DB') . ';host=' . getenv('MYSQL_HOST'),
                getenv('MYSQL_USER'),
                getenv('MYSQL_PASSWORD'),
            ],
        ],

        // 4. Alternative style: custom id with an explicit class
        'mailer' => [
            'class' => Nette\Mail\SmtpMailer::class,
            'construct' => [
                getenv('SMTP_HOST'),
                getenv('SMTP_USER'),
                getenv('SMTP_PASSWORD'),
                (int) getenv('SMTP_PORT'),
                getenv('SMTP_ENCRYPTION'),
            ],
        ],
    ],
];
```

Once declared, component instances are retrieved via
[`Application::getComponent()`](../api/Application.md#method_getComponent):

```php
/** @var PDO $db */
$db = $app->getComponent(PDO::class);
```

Array-based definitions are **lazy-loaded**: they are converted internally into
factories and instantiated the first time you call `getComponent()`. Objects and
callables that you provide directly are used as-is.

`Application::getComponent()` is also used by `Piko\Module` when creating
controllers and other services: any constructor parameter that has a
non-builtin class type-hint will be resolved from the components container
(using the class name as the key). This is how dependency injection is
implemented in Piko.

## Events

Piko supports dispatching and listening for events via the
[`Piko\EventHandlerTrait`](../api/EventHandlerTrait.md). Any class using this
trait becomes an **event handler**: it can register listeners and dispatch
events.

```php
class MyConnectEvent
{
    public string $username = '';

    public function __construct(string $username)
    {
        $this->username = $username;
    }
}

class MyClass
{
    use Piko\EventHandlerTrait;

    private string $username = '';

    public function connect(): void
    {
        // Dispatch the event and retrieve the (possibly modified) instance
        $event = $this->trigger(new MyConnectEvent($this->username));

        echo $event->username;
    }
}
```

Two methods are provided by the trait:

- [`on()`](../api/EventHandlerTrait.md#method_on)

  ```php
  $handler->on(string $eventClassName, callable $listener, ?int $priority = null);
  ```

  Registers a listener for the given event class. `priority` is optional; higher
  values are executed earlier.

- [`trigger()`](../api/EventHandlerTrait.md#method_trigger)

  ```php
  $event = $handler->trigger(object $event);
  ```

  Dispatches the event and returns the same instance after all listeners have
  run. Listeners can modify the event object in-place.

Example of registering and handling an event:

```php
$c = new MyClass();

$c->on(MyConnectEvent::class, function (MyConnectEvent $event): void {
    $event->username = 'Paul';
});

$c->connect(); // outputs "Paul"
```

Internally, `EventHandlerTrait` relies on the
[`piko/event-dispatcher`](https://packagist.org/packages/piko/event-dispatcher)
package, which is a [PSR-14](https://www.php-fig.org/psr/psr-14/) compliant
implementation.

## Behaviors

The [`Piko\BehaviorTrait`](../api/BehaviorTrait.md) can be used to inject
custom methods into an object instance at runtime. Methods added this way are
called **behaviors**.

To attach a behavior, use
[`attachBehavior()`](../api/BehaviorTrait.md#method_attachBehavior).

Example:

```php
class MyClass
{
    use Piko\BehaviorTrait;
}

$c = new MyClass();

// Attach a new "disconnect" behavior
$c->attachBehavior('disconnect', function (): void {
    echo 'I am disconnected!';
});

$c->disconnect(); // I am disconnected!
```

`BehaviorTrait` stores behaviors in the public `$behaviors` array and uses
`__call()` to intercept calls to undefined methods. If a method name matches a
registered behavior, the associated callback is executed. See the
[API reference](../api/BehaviorTrait.md) for details on
`detachBehavior()` and supported callback forms.

## Middleware

To produce a response, a Piko application sends an HTTP request through a
[FIFO](https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics)) queue of
middlewares.

A **middleware** is a component that sits between the web server and your
application. It can inspect and/or modify the incoming request and the outgoing
response, and either short-circuit the pipeline or delegate to the next
middleware.

Piko middlewares implement the PSR-15
[`Psr\Http\Server\MiddlewareInterface`](https://www.php-fig.org/psr/psr-15/#22-psrhttpservermiddlewareinterface),
while the application (`Piko\Application` and `Piko\ModularApplication`)
implements
[`Psr\Http\Server\RequestHandlerInterface`](https://www.php-fig.org/psr/psr-15/#23-psrhttpserverrequesthandlerinterface).

Conceptually, the pipeline looks like this:

```
App  --> request  --> MiddlewareA  --> request   --> MiddlewareB
App <-- response <--  MiddlewareA <--  response <--  MiddlewareB
```

The request is an instance of
[`Psr\Http\Message\ServerRequestInterface`](https://www.php-fig.org/psr/psr-7/#321-psrhttpmessageserverrequestinterface)
and the response an instance of
[`Psr\Http\Message\ResponseInterface`](https://www.php-fig.org/psr/psr-7/#33-psrhttpmessageresponseinterface).

### ModularApplication pipeline

`Piko\Application` maintains an internal FIFO queue of middlewares. You can add
a middleware with `Application::pipe()` **before** calling `run()`.

`Piko\ModularApplication` extends `Application` and defines the default
pipeline used by modular apps:

- On construction it installs an `ErrorHandler` as `$app->errorHandler`.
- When you call [`ModularApplication::run()`](../api/ModularApplication.md#method_run),
  it automatically enqueues a single
  [`RoutingMiddleware`](https://github.com/piko-framework/piko/blob/main/src/ModularApplication/RoutingMiddleware.php),
  which resolves the route, boots configured modules and dispatches the request
  to the appropriate controller.

Any custom middlewares you `pipe()` are executed **in the order they were
added**, before `RoutingMiddleware`.

### Example: CORS middleware

The following middleware injects an `Access-Control-Allow-Origin` header into
all responses:

```php
namespace app\lib;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

final class CorsMiddleware implements MiddlewareInterface
{
    public function process(
        ServerRequestInterface $request,
        RequestHandlerInterface $handler
    ): ResponseInterface {
        $response = $handler->handle($request);

        return $response->withHeader('Access-Control-Allow-Origin', '*');
    }
}
```

In the entry script:

```php
use Piko\ModularApplication;
use app\lib\CorsMiddleware;

require __DIR__ . '/../vendor/autoload.php';

$config = require __DIR__ . '/../config.php';

$app = new ModularApplication($config);
$app->pipe(new CorsMiddleware()); // executes before RoutingMiddleware
$app->run();
```
## Dependency injection

Piko resolves its dependencies through a [PSR-11](https://www.php-fig.org/psr/psr-11) container.
The [Application](../api/Application.md) **is not** the container itself: it *holds* one and delegates resolution to it.
Two collaborators are involved, both replaceable through configuration:

- a **container** (`Psr\Container\ContainerInterface`) that returns **shared** services by id,
- an **object factory** ([Piko\Di\ObjectFactoryInterface]({% link api/ObjectFactoryInterface.md %})) that creates **fresh** objects, resolving
  their constructor dependencies from the container (autowiring) with optional runtime overrides.

### Components (default container)

When no `container` is configured, [Application](../api/Application.md) builds a default [Piko\Di\ComponentContainer]({% link api/ComponentContainer.md %}) backed
by the `components` registry. Components are resolved lazily and memoized (lazy singletons): a component
is only instantiated the first time it is requested. A component may be declared as a ready-made object,
a factory closure, or an array definition (`class` / `construct`):

```php
<?php

declare(strict_types=1);

use Piko\ModularApplication;
use Piko\Router;
use Piko\View;

$app = new ModularApplication([
    'basePath' => __DIR__,
    'components' => [
        View::class => new View(),                      // ready-made instance
        Router::class => fn() => new Router(),          // lazy factory closure
        PDO::class => ['construct' => ['sqlite::memory:']], // array definition
    ],
    'modules' => [
        'site' => 'app\\modules\\site\\Module',
    ],
]);

// Retrieve a shared component:
$router = $app->getComponent(Router::class); // same instance on each call
```

### `get()` vs `create()`

These are two distinct operations, and Piko keeps them separate:

- **`get()`** (via [Application::getComponent()](../api/Application.md#method_getComponent) or [Application::getContainer()->get()](../api/Application.md#method_getContainer)) returns the **shared** instance
registered under an id.
- **`create()`** (via [Application::getObjectFactory()->create()](../api/Application.md#method_getObjectFactory), [Controller::create()](../api/Controller.md#method_create) or [Module::createObject()](../api/Module.md#method_createObject)) returns a **new** instance every
  time, autowiring its constructor dependencies from the container and accepting per-call overrides.

Inside a controller, use [create()](../api/Controller.md#method_create) for objects you want built fresh (models, commands, DTOs…):

```php
// MyModel needs a PDO instance in its constructor:
// class MyModel { public function __construct(PDO $db, int $id) {} }

$model = $this->create(MyModel::class, ['id' => 12]);
// -> PDO is injected from the container, `id` is provided as an override,
//    and a brand new MyModel is returned on every call.
```

### Using a third-party PSR-11 container (PHP-DI, League\Container…)

Provide the `container` configuration key with a container instance or a callable receiving the
application. Compose it with [ComponentContainer]({% link api/ComponentContainer.md %}) so the built-in components (Router, View…) stay
available as a fallback:

```php
<?php

declare(strict_types=1);

use DI\ContainerBuilder;
use Piko\Di\ComponentContainer;
use Piko\ModularApplication;
use Piko\Router;

$app = new ModularApplication([
    'basePath' => __DIR__,
    'container' => function (\Piko\Application $app) {
        $builder = new ContainerBuilder();
        $builder->addDefinitions([
            App\Service\UserService::class => DI\autowire(),
        ]);

        // Let the third-party container read Piko components when an entry is missing.
        $builder->wrapContainer(new ComponentContainer($app->components));

        return $builder->build();
    },
    'components' => [
        Router::class => fn() => new Router(),
    ],
    'modules' => [
        'site' => 'app\\modules\\site\\Module',
    ],
]);
```

With League\Container the composition uses delegation instead:

```php
$container = new League\Container\Container();
$container->add(App\Service\UserService::class)->setShared(true);
$container->delegate(new Piko\Di\ComponentContainer($app->components));
```

### Delegating autowiring to the container

[ObjectFactoryInterface::create()]({% link api/ObjectFactoryInterface.md %}#method_create) is the equivalent of PHP-DI's `make()`: a *fresh instance with
parameter overrides*, which is **not** part of PSR-11 (`get()` only returns shared entries). The default
[Piko\Di\ObjectFactory]({% link api/ObjectFactory.md %}) performs reflection-based autowiring on top of any PSR-11 container, so `create()`
works even with the default container. If you use a container that already autowires, plug your own
factory through the `objectFactory` configuration key to reuse its resolution:

```php
<?php

declare(strict_types=1);

use DI\FactoryInterface;
use Piko\Di\ObjectFactoryInterface;

final class PhpDiObjectFactory implements ObjectFactoryInterface
{
    public function __construct(private FactoryInterface $factory)
    {
    }

    public function create(string $class, array $overrides = []): object
    {
        return $this->factory->make($class, $overrides);
    }
}

$app = new ModularApplication([
    'container'     => fn() => /* build your PHP-DI container */,
    'objectFactory' => fn(\Piko\Application $app) => new PhpDiObjectFactory($app->getContainer()),
    // ...
]);
```
