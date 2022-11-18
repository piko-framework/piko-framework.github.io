---
layout: default
title: Views
parent: Modular application
nav_order: 3
---

## Views

The view is the part of the application that manages the presentation of data.
In a MVC application, the view is the HTML layer and should be responsible for the following:

- Presenting data
- Generating HTML

The view should never contain any logic for the data layer and never contain any SQL code.

View scripts are written in PHP. They have access to all methods of the [Piko\View](../../api/View.md) instance.
By default, view scripts extension is *.php*. This can be customized in the View configuration.

Changing view scripts extension in *config.php*:

```php
return [
    //...
    'components' => [
        'Piko\View' => [
            'extension' => 'phtml'
        ],
        //...
    ],
];
```

The [View::render](../../api/View#method_render) method is responsible of the view script rendering.
This method is automatically called by the [Controller::render](../../api/Controller.md#method_render) method as described above.

### Layout

In a Piko Framework application, view rendering can be divided into two steps. The first step is managed by a
controller action method as described above : a view script is rendered and the output is returned to the application
dispatching process.
The second step consists to inject this output (the `$content` variable) into a parent script (the layout).
The layout manage global ui elements like header and footer.

Layouts will be found depending to the `layouPath` and `layout` module properties.
By default, `defaultLayouPath` and `defaultLayout` application properties will be used (See [Configuration](index.md#configuration)).

Basic layout example:

```php
<?php
/**
 * @var $this Piko\View
 * @var $content string
 */
use Piko;
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="<?= $this->charset ?>">
    <title><?= $this->escape($this->title) ?></title>
    <!-- Output html tags in the head (stylesheets, scripts, ...) -->
    <?= $this->head() ?>
    <link href="<?= Piko::getAlias('@web/css/site.css') ?>" rel="stylesheet">
  </head>
<body>
  <!-- Action controller output (first step rendering) -->
  <?= $content ?>
  <!-- Output at the end of the body (scripts...) -->
  <?= $this->endBody() ?>
</body>
</html>
```

#### Turn off layout rendering

In a controller action method:

```php
namespace app\modules\site\controllers;
use Piko\Controller;

class DefaultController extends Controller
{
    public function helloAction()
    {
        $this->layout = false;

        return 'Hello';
    }
}
```
For all controller action methods:

```php
namespace app\modules\site\controllers;
use Piko\Controller;

class DefaultController extends Controller
{
    public $layout = false;
    // ...
}
```

For all controllers in the module:

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

### CSS injection

From a view script, it's possible to inject css to the layout using registerCSS and registerCSSFile methods :

```php
<?php
/**
 * @var $this Piko\View
 */

$this->registerCSS('body {background-color: #ccc;}');
$this->registerCSSFile('/css/bootstrap.min.css');
?>
```

### Scripts injection

Same as css injection, it's possible to inject scripts to the layout using registerJs and registerJsFile methods :

```php
<?php
/**
 * @var $this Piko\View
 */

$this->registerJs('window.onload = function() {alert("loaded!")}');
$this->registerJsFile('/js/bootstrap.min.js');
?>
```

### Events

Some events allow to customize the view rendering process.

[BeforeRenderEvent](../../api/BeforeRenderEvent.md) event is triggered before the view script processing.

[AfterRenderEvent](../../api/AfterRenderEvent.md) event is triggered after the view script was processed.


Example of listening beforeRender and afterRender events:

```php
use BeforeRenderEvent;
use AfterRenderEvent;

/**
 * @var $view Piko\View
 */

$view->on(BeforeRenderEvent::class, function(BeforeRenderEvent $event) {
    var_dump($event->file);
    $event->model['time'] = date('H:i:s'); // Inject $time variable in the view model
});

$view->on(AfterRenderEvent, function(AfterRenderEvent $event) {
    $event->output .= '<!--' . time() . '-->'; // Append time comment at the end of output
});

```

### View theming

By default, view rendering process inside controllers looks for view scripts located in the module `views` directory.

This can be overriden using a theme.

*config.php*:

```php
//...

'components' => [
    'Piko\View' => [
        'themeMap' => [
            '@app/modules/site/views' => '@app/themes/mytheme',
        ],
    ],
]

//...
```

In this example, if a view script is found in `@app/themes/mytheme` it will be used in the rendering process.
Otherwise, the rendering process falls back to the path `'@app/modules/site/views'` to locate the script.

Several theme paths can be used to locate the view script.

*config.php*:

```php
//...

'components' => [
    'Piko\View' => [
        'themeMap' => [
            '@app/modules/site/views' => [
                '@app/themes/mychildtheme',
                '@app/themes/myparenttheme',
            ],
        ],
    ],
]

//...
```
