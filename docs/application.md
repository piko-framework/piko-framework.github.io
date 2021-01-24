---
layout: default
title: Application
nav_order: 3
---

{{ page.path }}

# How application works

Piko applications are organized following the [Model-View-Controller (MVC)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) design pattern and the MVC logic is packaged into modules.

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
```

## Workflow

<a name="routing"></a>

### 1 - Routing

When application start, the first step is to convert request URI into internal route. The internal route is a string identifier which indicates to the application how to dispatch the request and follows this schema :

`ModuleId/ControllerId/ActionId`

Example : The request URI `/hello` may correspond to the internal route `site\default\hello` which means that the action `hello` in the controller `default` in the module `site` should be dispatched by the application.

[More information](requests.md)

### 2 - Dispatching

Once the application discovered the internal route (see above), the next step is to dispatch the request to the appropriate controller action.

An action is a method in a controller suffixed with `Action`. For the action id `hello`, the controller method should be named `helloAction`.

### 3 - Rendering

The controller action returns to the application the output to display :

Example for the action id `hello` :

```php
class DefaultController extends \piko\Controller
{
    public function helloAction()
    {
        return "Hello world!";
    }
}
```

## Entry script

Entry script is the first step to bootstrap application. It generally named `index.php` and stored in the web accessible directory.
This is an example of basic bootstrapping :

```php
use piko\Application;
require '../vendor/autoload.php';

$config = require '../config.php';
(new Application($config))->run();
```

Piko embed an useful utility to get environment variables from a file. It can be used in the entry script :

```php
use piko\Application;
use piko\Utils;
require '../vendor/autoload.php';

Utils::parseEnvFile('../.env');
$config = require '../config.php';
(new Application($config))->run();
```
The `.env` file could contains this variables :

```
PIKO_DEBUG        = 1
PIKO_ENV          = dev
APP_TIMEZONE      = Europe/Paris
APP_LANGUAGE      = fr
ADMIN_EMAIL       = youremail@yourhost.com
```

Now, after parsing this file with ```Utils::parseEnvFile('../.env')``` you can access this variables in all the application by calling the php native function [getenv](https://www.php.net/manual/en/function.getenv.php).

## Configuration

In the step above, we load a configuration array from a file and apply it to the application. In order to the application work, the minimal configuration is to declare a module and a route to access this module:

```php
[
    'components' => [
        'router' => [
            'class' => 'piko\Router',
            'routes' => [
                '^/$' => 'site/default/index',
            ],
        ]
    ],
    'modules' => [
        'site' => 'app\modules\site\Module'
    ]
]
```

To understand the routing mechanism, see [Requests](requests.md).

Also, other important parameters can be set in the configuration array:

```php
[
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

We will see in detail each of them:

**basePath** : Absolute base path of the application. It corresponds to the alias `@app` (see [Alias](concepts.md#alias))

**defaultLayoutPath** : Absolute path where view layouts are stored. An alias can be used (default : @app/layouts)

**defaultLayout** : The default layout name without file extension *php*. (default : main)

**errorRoute** : The Error route to display exceptions in a friendly way. If not set, Exceptions catched will be thrown and stop the script execution.

**language** : The language used in the application

**components**: Array of components used in the application. (see [Component](concepts.md#component))

**modules**: Array of modules used in the application. (see [Module](concepts.md#module))

**bootstrap**: Array of modules ids which participate to the application bootstrap process. (see [Module](concepts.md#module))

## Controllers

Controllers are classes derived from [\piko\Controller](api/Controller.md). They are part of [MVC](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) architecture and they are responsible for processing requests and generating responses.

Controllers are composed of *actions* methods that end users can address and request for execution. A controller can have one or multiple actions.
End user address action throw *routes* as [described above](#routing).

Example:

```php
namespace app\modules\site\controllers;

class DefaultController extends \piko\Controller
{
    /**
     * The corresponding route to access this action is site/default/hello
     */
    public function helloAction()
    {
        return "Hello world!";
    }
}
```

### Controller class naming

Controller class naming uses Camel Case convention. The first part of the name is the controler Id and the last part is the word `Controller`.

Exemples:

| ControllerId | class name |
|------------- |------------|
| article | ArticleController |
| article-manager | ArticleManagerController |

### Action method naming


## Models

## Views

## Modules
