---
layout: default
title: FastApplication
parent: API
---



# \Piko\FastApplication

This class implements a fast and simple route handlers application








## Properties summary

| Name | Description |
|------|-------------|
| private [`$router`](#property_router) |   |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$basePath`](Application.md#property_basePath) | The absolute base path of the application.  |
| public [`$behaviors`](BehaviorTrait.md#property_behaviors) | Behaviors container.  |
| public [`$components`](Application.md#property_components) | The components container  |
| public [`$defaultLayout`](Application.md#property_defaultLayout) | The default layout name without file extension.  |
| public [`$defaultLayoutPath`](Application.md#property_defaultLayoutPath) | The default layout path. An alias could be used.  |
| public [`$errorRoute`](Application.md#property_errorRoute) | The Error route to display exceptions in a friendl... |
| public [`$language`](Application.md#property_language) | The language that is meant to be used for end user... |
| protected [`$aliases`](Application.md#property_aliases) | The aliases container.  |
| protected [`$errorHandler`](Application.md#property_errorHandler) |   |
| protected [`$eventDispatcher`](EventHandlerTrait.md#property_eventDispatcher) |   |
| protected [`$listenerProvider`](EventHandlerTrait.md#property_listenerProvider) |   |
| protected [`$pipeline`](Application.md#property_pipeline) |   |

## Methods summary

| Name | Description |
|------|-------------|
| public [`createResponse`](#method_createResponse) | Helper to create a response  |
| public [`getRouter`](#method_getRouter) | Return a router instance  |
| public [`listen`](#method_listen) | Register a route handler  |
| public [`run`](#method_run) | Run the application.  |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`__call`](/BehaviorTrait.md#method___call) | Magic method to call a behavior.  |
| public [`__construct`](/Application.md#method___construct) | Constructor |
| public [`attachBehavior`](/BehaviorTrait.md#method_attachBehavior) | Attach a behavior to the class instance.  |
| public [`detachBehavior`](/BehaviorTrait.md#method_detachBehavior) | Detach a behavior.  |
| public [`getComponent`](/Application.md#method_getComponent) | Retrieve a unique instance of a registered compone... |
| public [`handle`](/Application.md#method_handle) | {@inheritDoc}  |
| public [`on`](/EventHandlerTrait.md#method_on) |   |
| public [`pipe`](/Application.md#method_pipe) | Add a middleware in the application pipeline queue... |
| public [`run`](/Application.md#method_run) | Run the application.  |
| public [`trigger`](/EventHandlerTrait.md#method_trigger) | Trigger an event that may be listen by event liste... |

-----


## Properties


<a name="property_router"></a>
### private **$router** : \Piko\Router





-----

## Methods




<a name="method_createResponse"></a>
### public **createResponse()**: \HttpSoft\Message\Response

```php
public static  createResponse(string  $body = ''): \HttpSoft\Message\Response
```

Helper to create a response



#### Parameters
**$body**  (default: ''):
The response body






#### Return:
**\HttpSoft\Message\Response**


-----



<a name="method_getRouter"></a>
### public **getRouter()**: \Piko\Router

```php
public  getRouter(): \Piko\Router
```

Return a router instance








#### Return:
**\Piko\Router**


-----



<a name="method_listen"></a>
### public **listen()**: void

```php
public  listen(string|string[]  $requestMethod, string  $path, callable  $handler): void
```

Register a route handler



#### Parameters
**$requestMethod** :
The allowed request(s) method(s)

**$path** :
The route path

**$handler** :
A callable handler, which have the following signature:
```
function(Psr\Http\Message\ServerRequestInterface $request): string|Psr\Http\Message\ResponseInterface
```






-----



<a name="method_run"></a>
### public **run()**: void

```php
public  run(\Psr\Http\Message\ServerRequestInterface  $request = null, bool  $emitHeaders = true): void
```

Run the application.



#### Parameters
**$request**  (default: null):


**$emitHeaders**  (default: true):
Controls whether headers will be emmited (header() function called)






