---
layout: default
title: Requests
nav_order: 4
---

# Requests

This section explains how to configure requests in the Piko framework.

## Definitions

A **request** corresponds to an URI and have to be dispatched to a controller action throw a route.

A **route** is an internal identifier corresponding to a module, a controller and an action (which is a controller method suffixed by `Action`. A route is always structured like this : `<moduleId>/<controllerId>/<actionId>`.

Exemple: The request URI `/hello` can correspond to the route `site/default/hello` which means that the application will dispatch the route to the method `helloAction` in the controller `DefaultController` in the module `site`.

## Configuration

Routes configuration consumed by [piko\Router](api/Router.md) consists only to an associative array where keys are URIs and values are corresponding routes. It works like preg_replace function: the URI is the regex pattern and the route, the replacement.

Example of configuration:

```php
<?php
return [
    // ...
    'components' => [
        'router' => [
            'class' => 'piko\Router',
            'routes' => [
                //...
                '^/hello$' => 'site/default/hello',
            ],
        ],
        // ...
    ]
];
```

## Request parameters

Piko offers the possibility to retrieve parameters from URI. In the configuration, you have to specify parameters in the right part of the route separed with the pipe character `|`. Use coma to separate parameters.

This example show how to extract an username parameter from the URI:

```php
'routes' => [
    //...
    '^/user/(\w+)' => 'user/default/view|username=$1',
]
```

Now the username can be retrieved from the superglobal $_GET var:

```php
namespace app\modules\user\controllers;

class DefaultController extends \piko\Controller
{
    public function viewAction()
    {
        $username = $_GET['username'];
        return "Hello $username";
    }
}

```

## Dynamic routes

As the correspondance between URIs and routes works like the preg_replace function, it's possible to generate routes.

This example show how to generate the entire route from the URI:

```php
'routes' => [
    //...
    '^/(\w+)/(\w+)/(\w+)' => '$1/$2/$3'
]
```

## Retrieve URL from route

[piko\Router](api/Router.md) offers the ability to reverse a route to its URI:

```php
// Configuration
'routes' => [
    //...
    '^/user/(\w+)' => 'user/default/view|username=$1',
]
//...

$router = \piko\Piko::get('router');

echo $router->getUrl('user/default/view', ['username' => 'johnny'];

// will output '/user/johnny'
```





