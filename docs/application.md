---
layout: default
title: Modular application
nav_order: 3
---

# How a modular application works

Summary:

- [Introduction](application.md#intro)
- [Workflow overview](application.md#workflow)
- [Entry script](application.md#entry-script)
- [Configuration](application.md#configuration)
- [Application](application.md#application)
- [Controllers](application.md#controllers)
- [Views](application.md#views)
- [Models](application.md#models)
- [Modules](application.md#modules)

<hr>

<a name="intro"></a>

With Piko, it's possible to organize your code following the 
[Model-View-Controller (MVC)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) design pattern 
and the MVC logic is packaged into modules.

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

<a name="workflow"></a>

## Workflow overview

### 1 - Routing request

When a modular Piko application start, the first step is to translate the request uri into internal route, which
is explained in the [routing](routing.md) section of this guide.

### 2 - Dispatching request

The next step is to dispatch the route to the appropriate controller action. An action is a method in a controller 
suffixed with `Action`. For the action id `hello`, the controller method should be named `helloAction`. See
[Controllers](application.md#controllers).

### 3 - Sending responce

Finally, the controller action returns to the application the response to display.


<a name="entry-script"></a>

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

<a name="configuration"></a>

## Configuration

In the step above, we load a configuration array from a file and apply it to the application. 
Here is the description of the parameters used:

```php
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

**basePath** : Base path of the application. It corresponds to the  `@app` [alias](concepts.md#alias) 
generated during the application instanciation. Default value: `''` (The entry script's directory).

**defaultLayoutPath** : Absolute path where view layouts are stored. An alias can be used. Default value: `@app/layouts`.

**defaultLayout** : The default layout name without file extension *php*. Default value: `main`.

**errorRoute** : The Error route to display exceptions in a friendly way. If empty, 
Exceptions catched will be thrown and stop the script execution. Default value: `''`.

**language** : The language used in the application. Default value: `'en'`.

**components**: Array of components used in the application. (see [Component](concepts.md#component))

**modules**: Array of modules used in the application. (see [Modules](application.md#modules))

**bootstrap**: Array of modules ids which participate to the application bootstrap process.
(see [Modules](application.md#modules))

<a name="controllers"></a>

## Controllers

Controllerd are parts of the application that manage the flow of data. It is the glue that binds the model and 
the view together and should be responsible for the following:

- Communicating with the model
- Communicating with the view
- Handling user input
- Managing the flow of data 
 
Controllers should never contain any HTML code neither any SQL code.

In a Piko application, controllers are classes derived from [\piko\Controller](api/Controller.md). 
They are responsible for processing requests and generating responses.

Controllers are composed of *actions* methods that end users can address and request for execution. 
A controller can have one or multiple actions.

End user address action throw [routes](requests.md#routing).

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

Controller class naming uses Camel Case convention.
The first part of the name is the controler id and the last part is the word `Controller`.

Exemples:

| controller id | class name |
|------------- |------------|
| article | ArticleController |
| article-manager | ArticleManagerController |

### Action method naming

Action method naming also usesCamel Case convention but the first part of the name is the action Id in lower case 
and the last part is the word `Action`.

Exemples:

| ControllerId | class name |
|------------- |------------|
| export | exportAction |
| export-article | exportArticleAction |

### View rendering

The [render method](../api/Controller.md#method_render) processes a view script.
By default, view scripts are located in the `views` directory of the corresponding module. 
The `views` directory contains subdirectories, named as their corresponding controller, which contain 
scripts that can be rendered in controller's action methods.

Example of module structure to display a list of users in the default controller of the `site` module:

```
site
    controllers
        DefaultController.php
    views
        default
            userlist.php

```

*DefaultController.php*:


```php
<?php
namespace app\modules\site\controllers;

class DefaultController extends \piko\Controller
{
    //...
    public function usersAction()
    {
        $users = [
            ['firstname' => 'John', 'lastname' => 'Douglas'],
            ['firstname' => 'Robert', 'lastname' => 'Johnson']
        ];

        return $this->render('userlist', ['users' => $users]);
    }
}
```

*userlist.php*:

```php
<ul>
<?php foreach ($users as $user): ?>
    <li>
        <?php echo $user['firstname']?>
        <?php echo $user['lastname']?>
    </li>
<?php endforeach ?>
</ul>
```

### Forward and redirect

There are methods [getUrl](../api/Controller.md#method_getUrl), [forward](../api/Controller.md#method_forward) 
and [redirect](../api/Controller.md#method_redirect).
`getUrl` creates an URL from a route, applying rules given in the router configuration. `redirect` 
indicates to the app to redirect to another internal or external URL. `forward` tells the application 
to dispatch another route (it can be, for instance, another action in another controller in another module).

Use cases inside a controller:

```php
//...
    public function saveAction()
    {
        $this->redirect($this->getUrl('site/default/user', ['username' => 'Bill']));
    }

    public function validateAction()
    {
        $this->forward('site/default/user', ['username' => 'Bill']);
    }
//...
```

### Interact with the request

To interact with HTTP request, you can use the controller's request property:

```php
//...
    public function userAction()
    {
       if ($this->request->getMethod() == 'POST') {
            $post = $this->request->getParsedBody();
       }
    }
//...
```

Request object comes from the package
[httpsoft/http-server-request](https://packagist.org/packages/httpsoft/http-server-request) and implements the 
[Psr\Http\Message\ServerRequestInterface](https://www.php-fig.org/psr/psr-7/#321-psrhttpmessageserverrequestinterface)

### Interact with the response

In the same way as with the request, it's possible to interact with the HTTP response:

```php
//...
    public function rssAction()
    {
       $this->response = $this->response->withHeader('Content-Type', 'text/xml')
       // ...
    }
//...
```

Response object comes from the package
[httpsoft/http-server-request](https://packagist.org/packages/httpsoft/http-server-request) and implements the 
[Psr\Http\Message\ResponseInterface](https://www.php-fig.org/psr/psr-7/#33-psrhttpmessageresponseinterface)

### AJAX

To deal with AJAX requests / responses, Piko\Controller offers two helper:
[isAjax](../api/Controller.md#method_isAjax),
[jsonResponse](../api/Controller.md#method_jsonResponse).

```php
//...
    public function userSaveAction()
    {
        if ($this->isAjax())
            $data = json_decode($this->request->getBody())
            return $this->jsonResponse($data);
        }
    }
//...
```

<a name="views"></a>

## Views

The view is the part of the application that manages the presentation of data.
In a MVC application, the view is the HTML layer and should be responsible for the following: 

- Presenting data
- Generating HTML

The view should never contain any logic for the data layer and never contain any SQL code. 

View scripts are written in PHP. They have access to all methods of the [Piko\View](../api/View.md) instance.
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

The [View::render](../api/View#method_render) method is responsible of the view script rendering. 
This method is automatically called by the [Controller::render](../api/Controller.md#method_render) method as described above.

### Layout

In a Piko Framework application, view rendering can be divided into two steps. The first step is managed by a 
controller action method as described above : a view script is rendered and the output is returned to the application 
dispatching process.
The second step consists to inject this output (the `$content` variable) into a parent script (the layout). 
The layout manage global ui elements like header and footer.

Layouts will be found depending to the `layouPath` and `layout` module properties. 
By default, `defaultLayouPath` and `defaultLayout` application properties will be used (See [Configuration](#configuration)).

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

[BeforeRenderEvent](../api/BeforeRenderEvent.md) event is triggered before the view script processing.

[AfterRenderEvent](../api/AfterRenderEvent.md) event is triggered after the view script was processed.


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

<a name="models"></a>

## Models

The model is the part of the application that manages the data. It is the data layer. 
In a MVC application, the model should be responsible for the following:

- Managing the data
- Ensuring that data is valid before it is saved
- Communicating with the database The model should never contain any logic for the presentation layer. 
 
The model should never contain any HTML code.

The [Piko\ModelTrait](../api/ModelTrait.md) can be used to represent a data structure (model's attributes)
that need to be validated and mass assigned. A typical usage is to represent form data inputs.

Model's attributes are declared as public properties in the inherited class.

Model's attributes can be mass assigned using [bind](../api/ModelTrait.md#method_bind) method.

Model's attributes can be exported as array using [toArray](../api/ModelTrait.md#method_toArray) method.

To check model validity, we can use the [isValid](../api/ModelTrait.md#method_isValid) public method.
This method symply check if the `errors` model's property is empty.
The class using this trait has to implement the protected [validate](../api/ModelTrait.md#method_validate) method 
to fill the `errors` model's property in case of error.

Use case example of [\piko\ModelTrait](../api/ModelTrait.md) to represent a contact form:

Module structure:

```
site
    controllers
        DefaultController.php
    models
        ContactForm.php
    views
        default
            contact.php

```

*ContactForm.php*:

```php
<?php
namespace app\modules\site\models;

use Piko\ModelTrait;

class ContactForm
{
    use ModelTrait;

    public $email = '';
    public $subject = '';
    public $message = '';

    protected function validate(): void
    {
        if (!filter_var($this->email, FILTER_VALIDATE_EMAIL)) {
            $this->setError('email', 'Email is invalid');
        }

        if (empty($this->subject)) {
            $this->setError('subject', 'Subject is required');
        }

        if (empty($this->message)) {
            $this->setError('message', 'Message is required');
        }
    }
}
```

*DefaultController.php*:

```php
namespace app\modules\site\controllers;

use app\modules\site\models\ContactForm;

class DefaultController extends \piko\Controller
{
    public function contactAction()
    {
        $form = new ContactForm();
        
        if ($this->request->getMethod() == 'POST') {
        
            $post = $this->request->getParsedBody();
            $form->bind($post);
        
            if ($form->isValid()) {
                // Send an email, Save in database, etc.
            }
        }
        
        return $this->render('contact', [
            'form' => $form
        ]);
    }
}
```

*contact.php*:

```php
<?php
/** 
 * @var $this Piko\View
 * @var $form app\modules\site\models\ContactForm
 */

$errors = $form->getErrors();
?>

<?php if ($errors): ?>
<p><?= implode('<br>', $errors) ?></p>
<?php endif ?>

<form action="" method="post">
  <p>
    <input type="email"
           name="email"
           value="<?= $form->email ?>"
           placeholder="Email">
  </p>
  <p>
    <input type="text"
           name="subject"
           value="<?= $form->subject ?>"
           placeholder="Subject">
  </p>
  <p>
    <label for="message">Message</label><br>
    <textarea  name="message" id="message" rows="5">
    <?= $form->message ?>
    </textarea>
  </p>
  <p>
    <button type="submit" >Submit</button>
  </p>
</form>
```

<a name="modules"></a>

## Modules

Piko framework applications can be seen as a collection of modules and, as we said in introduction, MVC logic 
is packaged into modules.

A Module works like a sub-application. 
The main application process asks to the module to run a controller action request and the module return the output.

Module encourage code reusability.

Module declarations inherit from [\piko\Module](../api/Module.md) class

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

use piko\Application;

class Module extends \piko\Module
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

use piko\Application;

class Module extends \piko\Module
{
    public $modules = [
        'admin' => 'app\modules\site\admin\Module'
    ];
}
```
