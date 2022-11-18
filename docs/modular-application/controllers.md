---
layout: default
title: Controllers
parent: Modular application
nav_order: 2
---

# Controllers

Controllerd are parts of the application that manage the flow of data. It is the glue that binds the model and
the view together and should be responsible for the following:

- Communicating with the model
- Communicating with the view
- Handling user input
- Managing the flow of data

Controllers should never contain any HTML code neither any SQL code.

In a Piko application, controllers are classes derived from [Piko\Controller](../../api/Controller.md).
They are responsible for processing requests and generating responses.

Controllers are composed of *actions* methods that end users can address and request for execution.
A controller can have one or multiple actions.

End user address action throw [routes](routing.md).

Example:

```php
namespace app\modules\site\controllers;

class DefaultController extends \Piko\Controller
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

The [render method](../../api/Controller.md#method_render) processes a view script.
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

class DefaultController extends \Piko\Controller
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

There are methods [getUrl](../../api/Controller.md#method_getUrl), [forward](../../api/Controller.md#method_forward)
and [redirect](../../api/Controller.md#method_redirect).
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
[httpsoft/http-message](https://packagist.org/packages/httpsoft/http-message) and implements the
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
[httpsoft/http-message](https://packagist.org/packages/httpsoft/http-message) and implements the
[Psr\Http\Message\ResponseInterface](https://www.php-fig.org/psr/psr-7/#33-psrhttpmessageresponseinterface)

### AJAX

To deal with AJAX requests / responses, Piko\Controller offers two helper:
[isAjax](../../api/Controller.md#method_isAjax),
[jsonResponse](../../api/Controller.md#method_jsonResponse).

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
