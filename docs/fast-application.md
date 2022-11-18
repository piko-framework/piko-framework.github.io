---
layout: default
title: Fast application
nav_order: 3
---

# Fast application

To build a simple Web application, it's possible to use the
[FastApplication](../api/FastApplication.md) class, which is a route handlers container.

[FastApplication::listen](../api/FastApplication.md#method_listen) is used to register a route handler.

This is a basic example of FastApplication:

```php
use Piko\FastApplication;
use Psr\Http\Message\ServerRequestInterface;

require 'vendor/autoload.php';

$app = new FastApplication();

$app->listen('GET', '/', function(ServerRequestInterface $request) {
	return 'App home';
});

$app->listen('GET', '/user/:name', function(ServerRequestInterface $request) {
	$name = $request->getAttribute('name');
	return "Hello $name";
});

$app->run();
```

## Customize the response

The request handler callback can return either a string or a
[Psr\Http\Message\ResponseInterface](https://www.php-fig.org/psr/psr-7/#33-psrhttpmessageresponseinterface)
object.

[FastApplication::createResponse](../api/FastApplication.md#method_createResponse)
is an helper to create the response object.

With the response object, it's possible, for instance, to inject headers:

```php
$app->listen(['GET', 'POST'], '/user/:name', function(ServerRequestInterface $request) {

    $user = [
        'name' => $request->getAttribute('name')
    ];

    $response = FastApplication::createResponse(json_encode($user));

    return $response->withHeader('Content-type', 'application/json');
});
```

## Custom error handler

By default, exceptions are thrown to the end user but it's
possible to handle these exception using a custom error handler :

```php
use Piko\FastApplication;
use Psr\Http\Server\RequestHandlerInterface;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;

require 'vendor/autoload.php';

class ErroHandler implements RequestHandlerInterface
{
    public function handle(ServerRequestInterface $request): ResponseInterface
    {
        $message = 'Page not Found';

        if (getenv('APP_ENV') == 'dev') {
            $exception = $request->getAttribute('exception');
            $message = $exception->getMessage();
        }

        return FastApplication::createResponse($message);
    }
}

$app = new FastApplication([
    'errorHandler' => new ErroHandler()
]);

// ...
```
