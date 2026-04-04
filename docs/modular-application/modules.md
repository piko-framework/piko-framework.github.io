---
layout: default
title: Modules
parent: Modular application
nav_order: 5
---

# Modules

A Piko modular application is made of one or more modules. A module groups the logic for a feature or area of the application and typically contains its own controllers, models, and views.

A module is a sub-application: the main application resolves the route, selects the module, and then delegates the request to that module.

Modules must extend [`\Piko\Module`](../../api/Module.md).

## Minimal module class

```php
<?php

namespace app\modules\site;

class Module extends \Piko\Module
{
}
```

Example module structure:

```text
modules/
  site/
    controllers/
    models/
    views/
    Module.php
```

## Registering modules

The application must know which modules are available. Declare them in the `modules` section of the application configuration.

The keys are module IDs and the values are either:

- a module class name
- a configuration array with a `class` key

Example:

```php
<?php

return [
    'modules' => [
        'site' => 'app\\modules\\site\\Module',
        'blog' => 'app\\modules\\blog\\Module',
        'admin' => 'app\\modules\\admin\\Module',
        'api' => [
            'class' => 'app\\modules\\api\\Module',
        ],
    ],
];
```

## Module configuration

A module can be configured like any other Piko object. Common properties include:

- `controllerMap`: override controller class resolution
- `modules`: register submodules
- `layoutPath`: override the layout directory used by controllers in the module

Note: controller layout rendering is controlled by the controller's `layout` property. The module-level `layout` property exists on `Piko\Module`, but controller rendering does not currently inherit it automatically.

## Bootstrapping modules

A module can participate in application bootstrap if it defines a `bootstrap()` method and is listed in the application's `bootstrap` array.

During `ModularApplication::run()`, each listed module is instantiated and its `bootstrap()` method is called when it exists.

Example:

```php
<?php

return [
    'modules' => [
        'site' => 'app\\modules\\site\\Module',
    ],
    'bootstrap' => [
        'site',
    ],
];
```

```php
<?php

namespace app\modules\site;

class Module extends \Piko\Module
{
    public function bootstrap(): void
    {
        $this->getApplication()->language = 'fr';
    }
}
```

## Overriding controllers

You can override the controller class used for a controller ID with `controllerMap`.

```php
<?php

return [
    'modules' => [
        'site' => [
            'class' => 'app\\modules\\site\\Module',
            'controllerMap' => [
                'default' => 'app\\modules\\shared\\controllers\\DefaultController',
            ],
        ],
    ],
];
```

## Submodules

Modules can contain submodules. Nesting is unlimited.

You can declare submodules in the application configuration:

```php
<?php

return [
    'modules' => [
        'site' => [
            'class' => 'app\\modules\\site\\Module',
            'modules' => [
                'admin' => 'app\\modules\\site\\admin\\Module',
            ],
        ],
    ],
];
```

Or directly in the parent module class:

```php
<?php

namespace app\modules\site;

class Module extends \Piko\Module
{
    public $modules = [
        'admin' => 'app\\modules\\site\\admin\\Module',
    ];
}
```

## Route format

Routes handled by a module are parsed into:

```text
{moduleId}[/<subModuleId>...]/<controllerId>/<actionId>
```

Examples:

- `site/default/index` → module `site`, controller `default`, action `index`
- `site/admin/user/list` → module `site/admin`, controller `user`, action `list`
- `site/default` → module `site`, controller `default`, no action specified

See also [Routing](routing.md).
