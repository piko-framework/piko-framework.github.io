---
layout: default
title: Views
parent: Modular application
nav_order: 3
---

# Views

A view is the presentation layer of a Piko application. It is responsible for generating HTML from data passed by controllers.

View scripts are plain PHP files. Inside a view script, `$this` refers to the [`Piko\View`](../../api/View.md) instance, so you can call view methods directly.

By default, view files use the `.php` extension. You can change the extension in the `Piko\View` component configuration.

```php
<?php

return [
    'components' => [
        'Piko\View' => [
            'extension' => 'phtml',
        ],
    ],
];
```

`View::render()` renders a view file and is usually called by `Controller::render()`. See [`Controller::render()`](../../api/Controller.md#method_render).

## Layouts

Rendering is usually done in two steps:

1. the controller renders a view script
2. the result is injected into a layout as `$content`

Layouts are responsible for shared UI such as headers, footers, and scripts.

The layout used by a controller is resolved as follows:

- if the controller's `layout` property is `false`, layout rendering is disabled
- if the controller's `layout` property is `null`, the application's `defaultLayout` is used
- otherwise, the controller's `layout` value is used

The layout directory is resolved as follows:

- the controller's module `layoutPath`, if set
- otherwise the application's `defaultLayoutPath`

Example layout:

```php
<?php
/**
 * @var Piko\View $this
 * @var string $content
 */

// Piko is available as the global helper class.
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="<?= $this->charset ?>">
        <title><?= $this->escape($this->title) ?></title>
        <?= $this->head() ?>
        <link rel="stylesheet" href="<?= \Piko::getAlias('@web/css/site.css') ?>">
    </head>
    <body>
        <?= $content ?>
        <?= $this->endBody() ?>
    </body>
</html>
```

### Disabling layout rendering

Disable layout rendering in a controller action:

```php
<?php

namespace app\modules\site\controllers;

use Piko\Controller;

class DefaultController extends Controller
{
    public function helloAction(): string
    {
        $this->layout = false;

        return 'Hello';
    }
}
```

Disable layout rendering for all actions in a controller:

```php
<?php

namespace app\modules\site\controllers;

use Piko\Controller;

class DefaultController extends Controller
{
    public $layout = false;
}
```

Disable layout rendering for all controllers in the module:

```php
// config.php
// ...
'modules' => [
    'site' => [
        'class' => 'app\modules\site\Module',
        'layout' => false
    ]
]
// ...
```

## Accessing URLs from a view

`Piko\Controller::getUrl()` is attached to the default `Piko\View` instance as a behavior, so you can generate URLs directly from a view script.

```php
<a href="<?= $this->getUrl('user/default/view', ['id' => 42]) ?>">Open profile</a>
```

## Registering CSS and JavaScript

You can add assets from a view script and let the layout render them.

```php
<?php

$this->registerCSS('body { background-color: #ccc; }');
$this->registerCSSFile('/css/bootstrap.min.css');
$this->registerJs('window.onload = function () { alert("loaded!"); }');
$this->registerJsFile('/js/bootstrap.min.js');
```

- [`registerCSS()`](../../api/View.md#method_registerCSS) adds inline CSS to the `<head>`
- [`registerCSSFile()`](../../api/View.md#method_registerCSSFile) adds a stylesheet URL to the `<head>`
- [`registerJs()`](../../api/View.md#method_registerJs) adds inline JavaScript to the layout position you choose
- [`registerJsFile()`](../../api/View.md#method_registerJsFile) adds a script URL to the chosen layout position

## Events

The view triggers events during rendering and when building the layout sections.

Rendering events:

- [`BeforeRenderEvent`](../../api/BeforeRenderEvent.md)
- [`AfterRenderEvent`](../../api/AfterRenderEvent.md)

Layout events:

- `BeforeHeadEvent`
- `AfterHeadEvent`
- `BeforeEndBodyEvent`
- `AfterEndBodyEvent`

Example:

```php
use Piko\View\Event\BeforeRenderEvent;
use Piko\View\Event\AfterRenderEvent;

/** @var Piko\View $view */

$view->on(BeforeRenderEvent::class, function (BeforeRenderEvent $event) {
    $event->model['time'] = date('H:i:s');
});

$view->on(AfterRenderEvent::class, function (AfterRenderEvent $event) {
    $event->output .= '<!-- ' . time() . ' -->';
});
```

## View theming

By default, controller views are loaded from the module `views` directory.

You can override a view path with the `themeMap` configuration of `Piko\View`.

```php
<?php

return [
    'components' => [
        'Piko\View' => [
            'themeMap' => [
                '@app/modules/site/views' => '@app/themes/mytheme',
            ],
        ],
    ],
];
```

If a matching file exists in the theme directory, it is used instead of the original file.

You can also define multiple theme directories. They are checked in order until a matching file is found.

```php
<?php

return [
    'components' => [
        'Piko\View' => [
            'themeMap' => [
                '@app/modules/site/views' => [
                    '@app/themes/mychildtheme',
                    '@app/themes/myparenttheme',
                ],
            ],
        ],
    ],
];
```
