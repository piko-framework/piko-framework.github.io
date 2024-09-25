---
layout: default
title: Module
parent: API
---



# \Piko\Module

Module is the base class for classes containing module logic.








## Properties summary

| Name | Description |
|------|-------------|
| public [`$controllerMap`](#property_controllerMap) | Mapping from controller ID to controller class.  |
| public [`$controllerNamespace`](#property_controllerNamespace) | Base name space of module&#039;s controllers. Default t... |
| public [`$id`](#property_id) | The module identifier.  |
| public [`$layout`](#property_layout) | The name of the module&#039;s layout file or false
to d... |
| public [`$layoutPath`](#property_layoutPath) | The layout directory of the module.  |
| public [`$modules`](#property_modules) | Sub modules configuration  |
| protected [`$application`](#property_application) |   |
| private [`$basePath`](#property_basePath) | The root directory of the module.  |

## Inherited Properties

| Name | Description |
|------|-------------|
| protected [`$eventDispatcher`](EventHandlerTrait.md#property_eventDispatcher) |   |
| protected [`$listenerProvider`](EventHandlerTrait.md#property_listenerProvider) |   |

## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |
| public [`getApplication`](#method_getApplication) |   |
| public [`getBasePath`](#method_getBasePath) | Returns the root directory of the module.  |
| public [`getModule`](#method_getModule) | Get a sub module of this module  |
| public [`handle`](#method_handle) | {@inheritDoc}  |
| public [`setApplication`](#method_setApplication) |   |
| protected [`createController`](#method_createController) | Create a controller  |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`on`](/EventHandlerTrait.md#method_on) | Registers an event listener.  |
| public [`trigger`](/EventHandlerTrait.md#method_trigger) | Trigger an event that may be listen by event liste... |

-----


## Properties


<a name="property_controllerMap"></a>
### public **$controllerMap** : string[]
Mapping from controller ID to controller class.






<a name="property_controllerNamespace"></a>
### public **$controllerNamespace** : string
Base name space of module's controllers.
Default to \{baseModuleNameSpace}\\controllers





<a name="property_id"></a>
### public **$id** : string
The module identifier.






<a name="property_layout"></a>
### public **$layout** : string|false
The name of the module's layout file or false
to deactivate the layout rendering






<a name="property_layoutPath"></a>
### public **$layoutPath** : string|null
The layout directory of the module.






<a name="property_modules"></a>
### public **$modules** : (\Piko\Module|class-string|array&lt;class-string,mixed&gt;)[]
Sub modules configuration






<a name="property_application"></a>
### protected **$application** : \Piko\ModularApplication






<a name="property_basePath"></a>
### private **$basePath** : string
The root directory of the module.





-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(array&lt;string,mixed&gt;  $config = []): mixed
```




#### Parameters
**$config**  (default: []):







#### Return:
**mixed**


-----



<a name="method_getApplication"></a>
### public **getApplication()**: \Piko\ModularApplication

```php
public  getApplication(): \Piko\ModularApplication
```








#### Return:
**\Piko\ModularApplication**


-----



<a name="method_getBasePath"></a>
### public **getBasePath()**: string

```php
public  getBasePath(): string
```

Returns the root directory of the module.








#### Return:
**string**
the root directory of the module.

-----



<a name="method_getModule"></a>
### public **getModule()**: \Piko\Module

```php
public  getModule(string  $moduleId): \Piko\Module
```

Get a sub module of this module



#### Parameters
**$moduleId** :
The module identifier




**throws**  \RuntimeExceptionIf module not found



#### Return:
**\Piko\Module**


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



<a name="method_setApplication"></a>
### public **setApplication()**: void

```php
public  setApplication(\Piko\ModularApplication  $app): void
```



#### Parameters
**$app** :






-----



<a name="method_createController"></a>
### protected **createController()**: \Piko\Controller

```php
protected  createController(string  $controllerId): \Piko\Controller
```

Create a controller



#### Parameters
**$controllerId** :
A controller ID






#### Return:
**\Piko\Controller**


