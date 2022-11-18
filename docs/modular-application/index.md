---
layout: default
title: Modular application
has_children: true
nav_order: 3
---

# Modular application

This section explains how a modular application works.

With Piko, it's possible to organize your code following the
[Model-View-Controller (MVC)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) design pattern
and the MVC logic is packaged into modules that compose the application.

This design encourages code re-usability and modularity.

Example of application structure :

```
modules
  - moduleA
    - controllers
    - models
    - views
  - moduleB
    - controllers
    - models
    - views
public
  - css
  - js
  index.php
config.php
```

Piko uses [PSR-4](https://www.php-fig.org/psr/psr-4/) autoloading.

## Workflow overview

### 1 - Routing request

When a modular Piko application start, the first step is to translate the request uri into internal route, which
is explained in the [routing](routing.md) section of this guide.

### 2 - Dispatching request

The next step is to dispatch the route to the appropriate controller action. An action is a method in a controller
suffixed with `Action`. For the action id `hello`, the controller method should be named `helloAction`. See
[Controllers](controllers.md).

### 3 - Sending responce

Finally, the controller action returns to the application the response to display.


## Entry script

Entry script is the first step to bootstrap application. It generally named `index.php` and stored in the web
public directory.

This is an example of basic bootstrapping :

```php
use Piko\ModularApplication;
require '../vendor/autoload.php';

$config = require '../config.php';
(new ModularApplication($config))->run();
```

<a id="configuration"></a>

## Configuration

In the step above, we load a configuration array from a file and apply it to the application.
Here is the description of the parameters used:

```php
// config.php
return [
    'basePath' => __DIR__,
    'defaultLayoutPath' => '@app/layouts',
    'defaultLayout' => 'main',
    'errorRoute' => 'site/default/error',
    'language' => 'fr',
    'components' => [
      //...
    ],
    'modules' => [
      //...
    ],
    'bootstrap' => [
      //...
    ]
]
```

**basePath** : Base path of the application. It corresponds to the  `@app` [alias](../concepts.md#alias)
generated during the application instanciation. Default value: `''` (The entry script's directory).

**defaultLayoutPath** : Absolute path where view layouts are stored. An alias can be used. Default value: `@app/layouts`.

**defaultLayout** : The default layout name without file extension *php*. Default value: `main`.

**errorRoute** : The Error route to display exceptions in a friendly way. If empty,
Exceptions catched will be thrown and stop the script execution. Default value: `''`.

**language** : The language used in the application. Default value: `'en'`.

**components**: Array of components used in the application. (see [Component](../concepts.md#component))

**modules**: Array of modules used in the application. (see [Modules](modules.md))

**bootstrap**: Array of modules ids which participate to the application bootstrap process.
(see [Modules](modules.md))

## Read more on modular application:

- [Routing](routing.md)
- [Controllers](controllers.md)
- [Views](views.md)
- [Models](models.md)
- [Modules](modules.md)
