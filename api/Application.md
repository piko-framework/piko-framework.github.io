---
layout: default
title: Application
parent: API
---



# \Piko\Application

The main application class








## Properties summary

| Name | Description |
|------|-------------|
| public [`$basePath`](#property_basePath) | The absolute base path of the application.  |
| public [`$components`](#property_components) | The components container  |
| public [`$defaultLayout`](#property_defaultLayout) | The default layout name without file extension.  |
| public [`$defaultLayoutPath`](#property_defaultLayoutPath) | The default layout path. An alias could be used.  |
| public [`$errorRoute`](#property_errorRoute) | The Error route to display exceptions in a friendl... |
| public [`$language`](#property_language) | The language that is meant to be used for end user... |
| protected [`$aliases`](#property_aliases) | The aliases container.  |
| protected [`$errorHandler`](#property_errorHandler) |   |
| protected [`$pipeline`](#property_pipeline) |   |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$behaviors`](BehaviorTrait.md#property_behaviors) | Behaviors container.  |
| protected [`$eventDispatcher`](EventHandlerTrait.md#property_eventDispatcher) |   |
| protected [`$listenerProvider`](EventHandlerTrait.md#property_listenerProvider) |   |

## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |
| public [`getComponent`](#method_getComponent) | Retrieve a unique instance of a registered compone... |
| public [`handle`](#method_handle) | {@inheritDoc}  |
| public [`pipe`](#method_pipe) | Add a middleware in the application pipeline queue... |
| public [`run`](#method_run) | Run the application.  |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`__call`](/BehaviorTrait.md#method___call) | Magic method to call a behavior.  |
| public [`attachBehavior`](/BehaviorTrait.md#method_attachBehavior) | Attach a behavior to the class instance.  |
| public [`detachBehavior`](/BehaviorTrait.md#method_detachBehavior) | Detach a behavior.  |
| public [`on`](/EventHandlerTrait.md#method_on) |   |
| public [`trigger`](/EventHandlerTrait.md#method_trigger) | Trigger an event that may be listen by event liste... |

-----


## Properties


<a name="property_basePath"></a>
### public **$basePath** : string
The absolute base path of the application.






<a name="property_components"></a>
### public **$components** : (object|callable)[]
The components container






<a name="property_defaultLayout"></a>
### public **$defaultLayout** : string
The default layout name without file extension.






<a name="property_defaultLayoutPath"></a>
### public **$defaultLayoutPath** : string
The default layout path. An alias could be used.






<a name="property_errorRoute"></a>
### public **$errorRoute** : string
The Error route to display exceptions in a friendly way.
If not set, Exceptions catched will be thrown and stop the script execution.





<a name="property_language"></a>
### public **$language** : string
The language that is meant to be used for end users.






<a name="property_aliases"></a>
### protected **$aliases** : array&lt;string,string&gt;
The aliases container.






<a name="property_errorHandler"></a>
### protected **$errorHandler** : \Psr\Http\Server\RequestHandlerInterface






<a name="property_pipeline"></a>
### protected **$pipeline** : \SplQueue&lt;\Psr\Http\Server\MiddlewareInterface&gt;





-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: void

```php
public  __construct(array&lt;string,string|array&lt;string,mixed&gt;&gt;  $config = []): void
```

Constructor



#### Parameters
**$config**  (default: []):
The application configuration.






-----



<a name="method_getComponent"></a>
### public **getComponent()**: object

```php
public  getComponent(string  $type): object
```

Retrieve a unique instance of a registered component



#### Parameters
**$type** :
The component class




**throws**  \RuntimeExceptionIf the component is not found



#### Return:
**object**


-----



<a name="method_handle"></a>
### public **handle()**: \Psr\Http\Message\ResponseInterface

```php
public  handle(\Psr\Http\Message\ServerRequestInterface  $request): \Psr\Http\Message\ResponseInterface
```

{@inheritDoc}



#### Parameters
**$request** :




**see**  \Psr\Http\Server\RequestHandlerInterface::handle()



#### Return:
**\Psr\Http\Message\ResponseInterface**


-----



<a name="method_pipe"></a>
### public **pipe()**: void

```php
public  pipe(\Psr\Http\Server\MiddlewareInterface  $middleware): void
```

Add a middleware in the application pipeline queue



#### Parameters
**$middleware** :





**see**  \Psr\Http\Server\MiddlewareInterface



-----



<a name="method_run"></a>
### public **run()**: void

```php
public  run(\Psr\Http\Message\ServerRequestInterface|null  $request = null, bool  $emitHeaders = true): void
```

Run the application.



#### Parameters
**$request**  (default: null):


**$emitHeaders**  (default: true):
Controls whether headers will be emmited (header() function called)






