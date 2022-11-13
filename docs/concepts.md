---
layout: default
title: Concepts
nav_order: 5
---

# Concepts

<a name="alias"></a>

## Alias

Alias are a convenient way to retrieve paths in the application. They are prefixed by the character `@`. By default, 
3 paths were created in the application initialization:
`@app` is the application root path, 
`@webroot` is the public directory root path and
`@web` is the uri base path.

Use [Piko::getAlias()](../api/Piko.md#method_getAlias) to retrieve a path or 
[Piko::setAlias()](../api/Piko.md#method_setAlias) to register a path.

Example using getAlias() and setAlias(): 

```php
echo Piko::getAlias('@app/modules/site'); // /usr/local/share/myapp/modules/site
echo Piko::getAlias('@webroot/documents'); // /var/www/documents
echo Piko::getAlias('@web/css/styles.css'); // /css/styles.css

Piko::setAlias('@lib', '/usr/local/share/lib');
echo Piko::getAlias('@lib/pdf/model.pdf'); // /usr/local/share/lib/pdf/model.pdf

```

<a name="component"></a>

## Component

Some objects need to be retrieved globally in the application. They are application 
[singletons](https://en.wikipedia.org/wiki/Singleton_pattern).
In a Piko application, these objects are called "Components"

Common components are db connexion (PDO), logger, view rendering engine, user session manager, ...

These components are declared in the `components` section of the application [configuration](application.md#configuration) 
using a key-value paired array where keys are components class name and values could be either:

- an array of public properties to configure, with an optional array of constructor parameters (using the key `construct')
- an already instantiated object
- a function that returns an instantiated object for lazy loading.

Example of components configuration:

```php
use Piko\View;
use Monolog\Logger;
use Monolog\StreamHandler;

//...
'components' => [
    View::class => [
        // set a public property
        'charset' => 'ISO-8859-1' // (Default charset is UTF-8)
    ],
    Logger::class => function() {
        $logger = new Logger('app');
        $logger->pushHandler(new StreamHandler( __DIR__ . '/../var/log/app.log', Logger::DEBUG));

        return $logger;
    },
    PDO::class => [
        'construct' => [
            'mysql:dbname=' . getenv('MYSQL_DB') . ';host=' . getenv('MYSQL_HOST'),
            getenv('MYSQL_USER'),
            getenv('MYSQL_PASSWORD'),
        ]
    ],
],
// ...
```

Once declared, their instances can be accessed throw the application using 
[Application::getComponent()](../api/Application.md#method_getComponent) method.
Therefore, the application can act like a container and it is possible to apply 
the Dependencies Injection pattern through this mechanism.

Note that these components are loaded lazily if they are declared as an array in the configuraton. 
They are instantiated the first time you access them by using 
[Application::getComponent()](../api/Application.md#method_getComponent) method.

<a name="events"></a>

## Events

Within Piko, its possible to dispatch and listen for events.
This feature can be activated using the trait [EventHandlerTrait](../api/EventHandlerTrait.md):

```php
class MyClass
{
    use Piko\EventHandlerTrait;
}
```

The [trigger](../api/EventHandlerTrait#method_trigger) method is used to trigger an event and 
the [on](../api/EventHandlerTrait#method_on) method is used to listen for that event. 


Example of event triggering in MyClass: 

```php
class MyConnectEvent
{
    public $username = '';
    
    public function __construct($username)
    {
        $this->username = $username;
    }
}

class MyClass
{
    use Piko\EventHandlerTrait;
    
    private $username = '';
    
    public function connect()
    {
        $event = $this->trigger(new MyConnectEvent($this->username));

        echo $event->username;
    }
}
```

Example of listening event of MyClass:

```php
$c = new MyClass();

$c->on(MyConnectEvent::class, function(MyConnectEvent $event) {
    $event->username = 'Paul';
});

$c->connect(); // Paul

```

At a lower level, the eventHandlerTrait uses the package
[piko/event-dispatcher](https://packagist.org/packages/piko/event-dispatcher), which is a
[PSR-14](https://www.php-fig.org/psr/psr-14/) implementation.

<a name="behaviors"></a>

## Behaviors

The [BehaviorTrait](../api/BehaviorTrait.md) may be used to inject dynamically a non-existing method into an object 

To attach a behavior, use [attachBehavior](../api/BehaviorTrait#attachBehavior) method.

Example:

```php
class MyClass
{
    use Piko\BehaviorTrait;
}

$c = new MyClass(]);

$c->attachBehavior('disconnect', function() {
    echo 'I am disconnected!';
});

$con->disconnect(); // I am disconnected!
```

<a name="middleware"></a>

## Middleware

In order to obtain a response, a Piko based application sends a request to 
a [FIFO](https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics)) queue of Middlewares.

A middleware is a kind of sub-application that sits between the web server and the 
web application, intercepting requests and responses to perform some action.

Middlewares in Piko implements the standard PSR-15 
[Psr\Http\Server\MiddlewareInterface](https://www.php-fig.org/psr/psr-15/#22-psrhttpservermiddlewareinterface)

Here is an illustration of how middleware works in a Piko application:

```
App  --> request  --> MiddlewareA  --> request   --> MiddlewareB
App <-- response <--  MiddlewareA <--  response <--  MiddlewareB

```

The request is an instance of 
[Psr\Http\Message\ServerRequestInterface](https://www.php-fig.org/psr/psr-7/#321-psrhttpmessageserverrequestinterface)
and the response an instance of
[Psr\Http\Message\ResponseInterface](https://www.php-fig.org/psr/psr-7/#33-psrhttpmessageresponseinterface)

Actually, the Piko ModularApplication is a queue of two middlewares : 
[BootstrapMiddleware](https://github.com/piko-framework/piko/blob/main/src/ModularApplication/BootstrapMiddleware.php)
and
[RoutingMiddleware](https://github.com/piko-framework/piko/blob/main/src/ModularApplication/RoutingMiddleware.php)

Before the application start, it's possible to pipe a custom middleware.

For instance, to inject the *Access-Control-Allow-Origin* header in the application response:

```php
namespace app\lib;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

final class CorsMiddleware implements MiddlewareInterface
{
    /**
     * {@inheritDoc}
     * @see \Psr\Http\Server\MiddlewareInterface::process()
     */
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        $response = $handler->handle($request);

        return $response->withHeader('Access-Control-Allow-Origin', '*');
    }
}
```

In the entry script:

```php
use Piko\ModularApplication;
use app\lib\CorsMiddleware;

require '../vendor/autoload.php';

$config = require '../config.php';
$app = new ModularApplication($config);
$app->pipe(new CorsMiddleware());
$app->run();

```




