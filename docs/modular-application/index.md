---
layout: default
title: Modular application
has_children: true
nav_order: 3
---

# Modular application

A modular application organizes a Piko project into modules. Each module groups its own controllers, models, and views, which makes the codebase easier to maintain and reuse.

Piko follows the [Model-View-Controller (MVC)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) pattern and uses [PSR-4](https://www.php-fig.org/psr/psr-4/) autoloading.

Example project structure:

```text
modules/
  moduleA/
    controllers/
    models/
    views/
  moduleB/
    controllers/
    models/
    views/
public/
  css/
  js/
  index.php
config.php
```

## Request lifecycle

### 1. Route the request

When a modular application receives a request, the incoming URI is translated into an internal route. See [Routing](routing.md).

### 2. Dispatch the route

The router forwards the route to the appropriate module, controller, and action. An action is a controller method whose name ends with `Action`. For example, the action ID `hello` maps to `helloAction()`. See [Controllers](controllers.md).

### 3. Return the response

The controller action returns the response body or a `ResponseInterface` instance. The application then emits the response.

## Entry script

The entry script is usually `public/index.php`.

```php
<?php

use Piko\ModularApplication;

require '../vendor/autoload.php';

$config = require '../config.php';
(new ModularApplication($config))->run();
```

## Configuration

A modular application is configured with an associative array passed to `ModularApplication`.

```php
<?php

return [
    'basePath' => __DIR__,
    'defaultLayoutPath' => '@app/layouts',
    'defaultLayout' => 'main',
    'errorRoute' => 'site/default/error',
    'language' => 'fr',
    'components' => [
        // ...
    ],
    'modules' => [
        // ...
    ],
    'bootstrap' => [
        // ...
    ],
];
```

### `basePath`

Base path of the application. It becomes the `@app` [alias](../concepts.md#alias).

Default: the entry script directory.

### `defaultLayoutPath`

Directory containing application layouts. An alias can be used.

Default: `@app/layouts`.

### `defaultLayout`

Default layout name without the `.php` extension.

Default: `main`.

### `errorRoute`

Route used to render uncaught exceptions in a friendly way.

If empty, exceptions are rethrown.

Default: `''`.

### `language`

Application language.

Default: `en`.

### `components`

List of application components. See [Component](../concepts.md#component).

### `modules`

List of modules used by the application. See [Modules](modules.md).

### `bootstrap`

List of module IDs that must be bootstrapped during application startup.

See [Modules](modules.md).

## Read more

- [Routing](routing.md)
- [Controllers](controllers.md)
- [Views](views.md)
- [Models](models.md)
- [Modules](modules.md)
