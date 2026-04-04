---
layout: default
title: Fast application
nav_order: 3
---

# Fast application

`\Piko\FastApplication` is a lightweight application class built on top of
[`\Piko\Application`](../api/Application.md) and
[`\Piko\Router`](../api/Router.md). It lets you build small HTTP
applications by registering route handlers directly in PHP code, without
creating controllers or modules.

See the full API reference:
[`FastApplication`](../api/FastApplication.md).

## Basic usage

The `listen()` method registers a handler for a route and one or more HTTP
methods. Each handler receives a PSR-7 `ServerRequestInterface` instance and
must return either a string or a PSR-7 `ResponseInterface`.

```php
use Piko\FastApplication;
use Psr\Http\Message\ServerRequestInterface;

require 'vendor/autoload.php';

$app = new FastApplication();

// Simple route
$app->listen('GET', '/', function (ServerRequestInterface $request) {
    return 'App home';
});

// Route with a parameter
$app->listen('GET', '/user/:name', function (ServerRequestInterface $request) {
    $name = $request->getAttribute('name');
    return "Hello $name";
});

$app->run();
```

### Registering route handlers

`FastApplication::listen()` has the following signature:

```php
public function listen(string|array $requestMethod, string $path, callable $handler): void
```

- **`$requestMethod`** – A single HTTP method (e.g. `'GET'`) or an array of
  methods (e.g. `['GET', 'POST']`). Matching is case-insensitive.
- **`$path`** – A route pattern understood by `\Piko\Router`. Path segments
  starting with `:` define parameters (for example `/user/:name`).
- **`$handler`** – A callable with one of these common forms:
  - `function (ServerRequestInterface $request): string|ResponseInterface`
  - `function (ServerRequestInterface $request, array $params): string|ResponseInterface`

At runtime, Piko always calls the handler with **two arguments**:

1. the `ServerRequestInterface` instance
2. an array of route parameters (same values that are added as request
   attributes)

If your handler only declares one parameter, PHP ignores the second
argument, so both forms are valid.

Example with multiple methods and explicit `$params` argument:

```php
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;

$app->listen(['GET', 'POST'], '/article/:id',
    function (ServerRequestInterface $request, array $params): ResponseInterface {
        $id = (int) $params['id'];

        // ... load the article ...

        return FastApplication::createResponse("Article #$id");
    }
);
```

### Working with route parameters

For a route like `/user/:name`, the router extracts the `name` segment and Piko
makes it available in two ways:

- As a request attribute: `$request->getAttribute('name')`
- In the second `$params` argument passed to your handler

Example with multiple parameters:

```php
$app->listen('GET', '/blog/:year/:slug', function (ServerRequestInterface $request) {
    $year = (int) $request->getAttribute('year');
    $slug = $request->getAttribute('slug');

    return "Post $slug from $year";
});
```

If the path (or method) does not match any registered route, a 404
`HttpException` is thrown. If no error handler is configured, this exception is
propagated to the caller (typically the end user).

## Customizing the response

A route handler can return:

- a **string** – which Piko converts into a PSR-7 response with that string as
  the body
- a **`ResponseInterface` instance** – which is sent as-is

`FastApplication::createResponse()` is a helper to create responses using the
framework's default implementation (`HttpSoft\Message\Response`).

```php
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;

$app->listen(['GET', 'POST'], '/user/:name',
    function (ServerRequestInterface $request): ResponseInterface {
        $user = [
            'name' => $request->getAttribute('name'),
        ];

        $response = FastApplication::createResponse(json_encode($user));

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }
);
```

You can also build more advanced responses (custom status codes, additional
headers, different body streams) by starting from `createResponse()` and using
standard PSR-7 methods (`withHeader()`, `withStatus()`, `withBody()`, etc.).

## Custom error handler

By default, if a handler (or the routing process) throws an exception and no
error handler is configured, `Application::run()` rethrows the exception. This
usually results in the default PHP error output being shown to the end user.

To provide a user-friendly error page, configure an **error handler**. The
error handler must implement `Psr\Http\Server\RequestHandlerInterface` and is
assigned to the `errorHandler` property when constructing the application.

The error handler receives the same `ServerRequestInterface` as the main
pipeline, with the thrown exception attached under the `exception` attribute.

```php
use Piko\FastApplication;
use Psr\Http\Server\RequestHandlerInterface;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;

require 'vendor/autoload.php';

class ErrorHandler implements RequestHandlerInterface
{
    public function handle(ServerRequestInterface $request): ResponseInterface
    {
        $message = 'Page not found';
        $statusCode = 500;

        $exception = $request->getAttribute('exception');

        if ($exception instanceof \Throwable) {
            // Use a different message in production if desired
            if (getenv('APP_ENV') === 'dev') {
                $message = $exception->getMessage();
            }

            // Use the exception code if it looks like a valid HTTP status
            if (is_int($exception->getCode()) && $exception->getCode() >= 400) {
                $statusCode = $exception->getCode();
            }
        }

        return FastApplication::createResponse($message)
            ->withStatus($statusCode);
    }
}

$app = new FastApplication([
    'errorHandler' => new ErrorHandler(),
]);

// ... register routes ...

$app->run();
```

With this setup, any uncaught exception in your route handlers (or within the
framework itself) is converted into a regular HTTP response, while still giving
access to the original `Throwable` for logging or debugging.
