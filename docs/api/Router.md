---
layout: default
title: Router
parent: API
---



# \piko\Router

Base application router.








## Properties

| Name | Description |
|------|-------------|
| public [`$routes`](#property_routes) | Name-value pair uri to routes correspondance. Each... |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$behaviors`](Component.md#property_behaviors) | Behaviors container.  |
| public [`$events`](Component.md#property_events) | Event handlers container.  |
| public [`$events2`](Component.md#property_events2) | Static event handlers container.  |

## Methods

| Name | Description |
|------|-------------|
| public [`getUrl`](#method_getUrl) | Convert a route to an url.  |
| public [`resolve`](#method_resolve) | Resolve the application route corresponding to the... |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`__call`](Component.md#method___call) | Magic method to call a behavior.  |
| public [`__construct`](Component.md#method___construct) | Constructor  |
| public [`attachBehavior`](Component.md#method_attachBehavior) | Attach a behavior to the component instance.  |
| public [`detachBehavior`](Component.md#method_detachBehavior) | Detach a behavior.  |
| public [`on`](Component.md#method_on) | Event registration.  |
| public [`trigger`](Component.md#method_trigger) | Trigger an event. Event handlers corresponding to ... |
| public [`when`](Component.md#method_when) | Static event registration.  |
| protected [`init`](Component.md#method_init) | Method called at the end of the constructor.  |

-----


## Properties


<a name="property_routes"></a>
### public $routes : array
Name-value pair uri to routes correspondance.
Each name corresponds to a regular expression of the request uri.
Each value corresponds to a route replacement.

eg. `'^/about$' => 'site/default/about'` means all requests corresponding to
'/about' will be treated in 'about' action in the 'defaut' controller of 'site' module.

eg. `'^/(\w+)/(\w+)/(\w+)' => '$1/$2/$3'` means uri part 1 is the module id,
part 2, the controller id and part 3 the action id.

Also route parameters could be given using pipe character after route.

eg. `'^/user/(\d+)' => 'site/user/view|id=$1'` The router will populate `$_GET`
with 'id' = The user id in the uri.



**see**  \piko\preg_replace()


-----

## Methods




<a name="method_getUrl"></a>
### public getUrl(): string

```php
public  getUrl(string  $route, array  $params = []): string
```

Convert a route to an url.



#### Parameters
**$route** :
The route given as '{moduleId}/{controllerId}/{ationId}'.

**$params**  (default: []):
Optional query parameters.






#### Return:
**string**
The url.

-----



<a name="method_resolve"></a>
### public resolve(): string

```php
public  resolve(): string
```

Resolve the application route corresponding to the request uri.
The expected route scheme is : '{moduleId}/{controllerId}/{ationId}'







#### Return:
**string**
The route.

