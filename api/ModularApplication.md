---
layout: default
title: ModularApplication
parent: API
---



# \Piko\ModularApplication

This class implements a modular application








## Properties summary

| Name | Description |
|------|-------------|
| public [`$bootstrap`](#property_bootstrap) | List of module IDs that should be run during the a... |
| public [`$modules`](#property_modules) | List of modules configurations. Should be either :... |

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
| public [`__construct`](#method___construct) | Constructor |
| public [`getModule`](#method_getModule) | Get a module instance  |
| public [`parseRoute`](#method_parseRoute) | Parse a route and return an array containing the m... |
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


<a name="property_bootstrap"></a>
### public **$bootstrap** : string[]
List of module IDs that should be run during the application bootstrapping process.
Each module may be specified with a module ID as specified via [[modules]].

During the bootstrapping process, each module will be instantiated. If the module class
implements the bootstrap() method, this method will be also be called.





<a name="property_modules"></a>
### public **$modules** : array&lt;string,string|array&lt;string,mixed&gt;|callable|\Piko\Module&gt;
List of modules configurations.
Should be either :

```php
[
  'moduleId' => 'moduleClassName'
]
```

Or :

```php
[
  'moduleId' => [
    'class' => 'moduleClassName',
    'layoutPath' => '/some/path'
    // ...
  ]
]
```



**see**  \Piko\ModuleTo have more informations on module attributes


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



<a name="method_getModule"></a>
### public **getModule()**: \Piko\Module

```php
public  getModule(string  $moduleId): \Piko\Module
```

Get a module instance



#### Parameters
**$moduleId** :
The module identifier




**throws**  \RuntimeException



#### Return:
**\Piko\Module**
instance

-----



<a name="method_parseRoute"></a>
### public **parseRoute()**: (string|null)[]

```php
public static  parseRoute(string  $route): (string|null)[]
```

Parse a route and return an array containing the module's id, the controller's id and the action's id.



#### Parameters
**$route** :
The route to parse. The route format is one of the following :

```
'{moduleId}/{subModuleId}/.../{controllerId}/{actionId}'
'{moduleId}/{controllerId}/{actionId}'
'{moduleId}/{controllerId}'
'{moduleId}'
```






#### Return:
**(string|null)[]**


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




**see**  \Piko\Application::run()



