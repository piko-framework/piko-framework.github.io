---
layout: default
title: Routing
parent: Modular application
nav_order: 1
---

# Routing

Routing in a [ModularApplication](../../api/ModularApplication.md) maps an incoming request path to a module, a controller, and an action.

A route usually resolves to a modular handler string in the form:

```text
<moduleId>[/<subModuleId>]/<controllerId>/<actionId>
```

The action name is the controller method name suffixed with `Action`.

Example:

- Request path: `/events/admin/add`
- Parsed route: `events/admin/add`
- Target method: `addAction()` in the `AdminController` class of the `events` module

## Route resolution

The router first tries static routes, then parameterized routes, then fully dynamic routes. If no route matches, the path itself is interpreted as a modular route and parsed directly.

This means that a path already shaped like a modular route does not need an explicit routing rule.

## Configuration

`Piko\Router` consumes an associative array where keys are request paths and values are their corresponding handlers.

Static routes do not contain placeholders:

```php
<?php
return [
    // ...
    'components' => [
        'Piko\Router' => [
            'construct' => [[
                'baseUri' => '/subdir',
                'routes' => [
                    '/' => 'site/default/index',
                    '/home' => 'site/default/index',
                ],
            ]],
        ],
        // ...
    ],
];
```

If the application is deployed in a subdirectory, set `baseUri`. The router removes it from incoming paths and prepends it when generating URLs.

## Path parameters

Use a leading colon (`:`) to define placeholders in a route path.

```php
'routes' => [
    '/user/:id' => 'user/default/view',
    '/portfolio/:alias/:category' => 'portfolio/default/view',
]
```

For example, `/user/10` matches `/user/:id` and exposes `id = 10` to the controller action.

Path parameters are injected into action methods by name. Query parameters are merged into the action argument set as well.

```php
namespace app\modules\user\controllers;

use Piko\Controller;

class DefaultController extends Controller
{
    public function viewAction(string $id): string
    {
        return "User #$id";
    }
}
```

With this configuration, a request to `/user/10` returns `User #10`.

## Dynamic handlers

A route handler can also contain placeholders. During resolution, the router replaces them with values captured from the request path.

```php
'routes' => [
    '/admin/:module/:action' => ':module/admin/:action',
]
```

With this rule, `/admin/shop/edit` resolves to the handler `shop/admin/edit`.

This is useful when several modules share the same routing pattern.

## Reverse routing

`Piko\Router` can also generate a URL from a handler with [`getUrl()`](../../api/Router.md#method_getUrl):

```php
<?php

/* Configuration
'routes' => [
    '/user/:id' => 'user/default/view',
]
*/

/* @var $router Piko\Router */

echo $router->getUrl('user/default/view', ['id' => 42]);
// Outputs: /user/42
```

If several routes point to the same handler, the router selects the best matching route for the parameters you provide.

Any remaining parameters that do not match a placeholder are appended as a query string.

You can also request an absolute URL:

```php
echo $router->getUrl('user/default/view', ['id' => 42], true);
// Outputs: http://127.0.0.1/user/42
```

The `host` and `protocol` properties are used when building absolute URLs.

## Using `getUrl()` in controllers and views

`Piko\Controller::getUrl()` proxies to `Piko\Router::getUrl()`.

In controllers:

```php
$url = $this->getUrl('user/default/view', ['id' => 42]);
```

When the default [`Piko\View`](../../api/View.md) component is used, the controller also exposes `getUrl()` to view scripts as a behavior, so you can call:

```php
<a href="<?= $this->getUrl('user/default/view', ['id' => 42]) ?>">Open profile</a>
```

## Notes

- Route parameters are case-sensitive.
- Route definitions should usually start with `/` for readability and consistency.
- The router supports static routes, parameterized routes, and fully dynamic routes such as `/:module/:controller/:action`.
