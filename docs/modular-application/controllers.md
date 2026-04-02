---
layout: default
title: Controllers
parent: Modular application
nav_order: 2
---

# Controllers

Controllers manage application flow between models, views, and HTTP input/output.
In a Piko application, a controller is a class that extends [Piko\Controller](../../api/Controller.md).

A controller should be responsible for:

- Coordinating business logic with models/services
- Preparing data for views or API responses
- Handling user input and route/query parameters
- Returning an HTTP response (directly or through helper methods)

Controllers should not contain SQL queries or HTML markup directly.

Controllers expose one or more action methods.
Each action is reachable through routing.

Example:

```php
namespace app\modules\site\controllers;

class DefaultController extends \Piko\Controller
{
    /**
     * Route: site/default/hello
     */
    public function helloAction()
    {
        return "Hello world!";
    }
}
```

### Controller class naming

Controller classes use CamelCase.
The class name is based on the controller ID, suffixed by `Controller`.

Examples:

| controller id | class name |
|------------- |------------|
| article | ArticleController |
| article-manager | ArticleManagerController |

### Action method naming

Action methods use camelCase and end with `Action`.
The action ID maps to the method name.

Examples:

| action id | method name |
|------------- |------------|
| export | exportAction |
| export-article | exportArticleAction |

### Dependency injection

When a controller is instantiated by a module, constructor arguments are resolved automatically from application
components (configured in the app container).

```php
namespace app\modules\products\controllers;

use PDO;
use Piko\User;

class ProduitsController extends \Piko\Controller
{
    public function __construct(private User $user, private PDO $db)
    {
    }
}
```

### Creating objects from a controller

If you need to instantiate a model/service that also has dependencies, use the controller helper
`create()` instead of `new`.
This delegates to the module object factory and resolves constructor dependencies the same way as controllers.

```php
public function deleteAction(int $id)
{
    /** @var \app\modules\products\models\Produit $model */
    $model = $this->create(\app\modules\products\models\Produit::class);
    $model->load($id);

    // ...
}
```

You can also override specific constructor arguments:

```php
$service = $this->create(MyService::class, ['timeout' => 30]);
```

### View rendering

The [render method](../../api/Controller.md#method_render) processes a view script.
By default, view scripts are located in the `views` directory of the corresponding module.
The `views` directory contains one subdirectory per controller.

Example module structure for `site/default/users`:

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

class DefaultController extends \Piko\Controller
{
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

Useful helpers:

- [getUrl](../../api/Controller.md#method_getUrl): build a URL from a route.
- [redirect](../../api/Controller.md#method_redirect): return a redirect to an internal or external URL.
- [forward](../../api/Controller.md#method_forward): dispatch another route internally.

Use cases inside a controller:

```php
public function saveAction()
{
    return $this->redirect($this->getUrl('site/default/user', ['username' => 'Bill']));
}

public function validateAction()
{
    return $this->forward('site/default/user', ['username' => 'Bill']);
}
```

### Working with request parameters

Action parameters are mapped by name from route parameters and query parameters.
Basic scalar conversion is applied for `int`, `float`, and `bool`.

```php
public function showAction(int $id, bool $preview = false)
{
    // $id and $preview are mapped from request parameters
}
```

To access the full PSR-7 request, use `$this->request`:

```php
public function userAction()
{
    if ($this->request->getMethod() === 'POST') {
        $post = $this->request->getParsedBody();
    }
}
```

Request object comes from the package
[httpsoft/http-message](https://packagist.org/packages/httpsoft/http-message) and implements the
[Psr\Http\Message\ServerRequestInterface](https://www.php-fig.org/psr/psr-7/#321-psrhttpmessageserverrequestinterface)

### Interact with the response

In the same way as with the request, it's possible to interact with the HTTP response:

```php
public function rssAction()
{
    $this->response = $this->response->withHeader('Content-Type', 'text/xml');
    // ...
}
```

Response object comes from the package
[httpsoft/http-message](https://packagist.org/packages/httpsoft/http-message) and implements the
[Psr\Http\Message\ResponseInterface](https://www.php-fig.org/psr/psr-7/#33-psrhttpmessageresponseinterface)

### AJAX

To work with AJAX requests/responses, `Piko\Controller` provides:
[isAjax](../../api/Controller.md#method_isAjax),
[jsonResponse](../../api/Controller.md#method_jsonResponse).

```php
public function userSaveAction()
{
    if ($this->isAjax()) {
        $data = json_decode((string) $this->request->getBody(), true);
        return $this->jsonResponse($data);
    }

    return $this->jsonResponse(['error' => 'Bad request'])->withStatus(400);
}
```
