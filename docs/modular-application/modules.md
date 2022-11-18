---
layout: default
title: Modules
parent: Modular application
nav_order: 5
---

# Modules

Piko framework applications can be seen as a collection of modules and, as we said in introduction, MVC logic
is packaged into modules.

A Module works like a sub-application.
The main application process asks to the module to run a controller action request and the module return the output.

Module encourage code reusability.

Module declarations inherit from [\Piko\Module](../../api/Module.md) class

Example of a minimal module declaration:

```php
namespace app\modules\site;

use Piko\Module

class Blog extends Module
{

}

```

An example of module structure:

```
blog
    controllers
    models
    views
    Module.php
```


### Application configuration

The application needs to know which modules are used.
This can be done in the `modules` section of the configuration array.

The `modules` section is a key pair array where keys are modules id and values the classes names or array of
module configuration.

*config.php* example:

```php
return [
    'modules' => [
        'site' => 'app\modules\site\Module'
        'blog' => 'app\modules\blog\Blog',
        'admin' => 'app\modules\admin\Module',
        'api' => [
            'class' => 'app\modules\api\Module',
            'layout' => false,
        ]
    ]
]
```

### Bootstrap application

Modules can participate to the application bootstrapping process.

For that, module has to implement a `bootstrap` method and needs to be declared explicitly in the `bootstrap` section of
the application configuration.

*config.php* example:

```php
return [
    //...
    'modules' => [
        'site' => 'app\modules\site\Module'
        //...
    ],
    'bootstrap' => [
        'site'
    ],
]
```

*Module.php* example:

```php
<?php
namespace app\modules\site;

use Piko\Application;

class Module extends \Piko\Module
{
    public function bootstrap()
    {
        $app = $this->getApplication();
        $app->language = 'fr';
    }

}

```

### Override controllers

If needed, module's controllers can be overriden in the configuration

*config.php* example:

```php
return [
    'modules' => [
        'site' => [
            'class' => 'app\modules\site\Module',
            'controllerMap' => [
                'default' => 'app\modules\othermodule\controllers\DefaultController'
            ]
         ]
    ]
]
```

### Sub modules

Module can be part of another module. There is no limit in nested modules level.

There is two ways to declare a sub-module.

In the configuration:

```php
return [
    'modules' => [
        'site' => [
            'class' => 'app\modules\site\Module',
            'modules' => [
                'admin' => 'app\modules\site\admin\Module'
            ]
         ]
    ]
]
```

In the parent module class:

```php
<?php
namespace app\modules\site;

use Piko\Application;

class Module extends \Piko\Module
{
    public $modules = [
        'admin' => 'app\modules\site\admin\Module'
    ];
}
```
