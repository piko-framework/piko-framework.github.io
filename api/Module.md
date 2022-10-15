---
layout: default
title: Module
parent: API
---



# \piko\Module

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
| private [`$basePath`](#property_basePath) | The root directory of the module.  |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$behaviors`](Component.md#property_behaviors) | Behaviors container.  |
| public [`$on`](Component.md#property_on) | Event listeners container.  |
| public [`$when`](Component.md#property_when) | Static event listeners container.  |

## Methods summary

| Name | Description |
|------|-------------|
| public [`getBasePath`](#method_getBasePath) | Returns the root directory of the module.  |
| public [`getModule`](#method_getModule) | Get a sub module of this module  |
| public [`run`](#method_run) | Run module controller action.  |
| protected [`init`](#method_init) | Method called at the end of the constructor.  |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`__call`](/Component.md#method___call) | Magic method to call a behavior.  |
| public [`__construct`](/Component.md#method___construct) | Constructor |
| public [`attachBehavior`](/Component.md#method_attachBehavior) | Attach a behavior to the component instance.  |
| public [`detachBehavior`](/Component.md#method_detachBehavior) | Detach a behavior.  |
| public [`on`](/Component.md#method_on) | Event registration.  |
| public [`trigger`](/Component.md#method_trigger) | Trigger an event. Event listeners will be called i... |
| public [`when`](/Component.md#method_when) | Static event registration.  |
| protected [`init`](/Component.md#method_init) | Method called at the end of the constructor. This ... |

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
### public **$layoutPath** : string
The layout directory of the module.






<a name="property_modules"></a>
### public **$modules** : array
Sub modules configuration






<a name="property_basePath"></a>
### private **$basePath** : string
The root directory of the module.





-----

## Methods




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
### public **getModule()**: \piko\Module

```php
public  getModule(string  $moduleId): \piko\Module
```

Get a sub module of this module



#### Parameters
**$moduleId** :
The module identifier




**throws**  \RuntimeExceptionIf module not found



#### Return:
**\piko\Module**


-----



<a name="method_run"></a>
### public **run()**: mixed

```php
public  run(string  $controllerId, string  $actionId, string[]  $params = []): mixed
```

Run module controller action.



#### Parameters
**$controllerId** :
The controller identifier.

**$actionId** :
The controller action identifier.

**$params**  (default: []):
Optional query parameters.






#### Return:
**mixed**
The module output.

-----



<a name="method_init"></a>
### protected **init()**: void

```php
protected  init(): void
```

Method called at the end of the constructor.






**see**  \piko\Component::init()



