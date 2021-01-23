---
layout: default
title: Controller
parent: API
---



# \piko\Controller

Controller is the base class for classes containing controller logic.








## Properties

| Name | Description |
|------|-------------|
| public [`$id`](#property_id) | The controller identifier.  |
| public [`$layout`](#property_layout) | The name of the layout to be applied to this contr... |
| public [`$module`](#property_module) | The module that this controller belongs to.  |
| public [`$viewPath`](#property_viewPath) | The root directory that contains view files for th... |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$behaviors`](Component.md#property_behaviors) | Behaviors container.  |
| public [`$events`](Component.md#property_events) | Event handlers container.  |
| public [`$events2`](Component.md#property_events2) | Static event handlers container.  |

## Methods

| Name | Description |
|------|-------------|
| public [`render`](#method_render) | Render a view.  |
| public [`runAction`](#method_runAction) | Runs an action within this controller with the spe... |
| protected [`getViewPath`](#method_getViewPath) | Returns the directory containing view files for th... |

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


<a name="property_id"></a>
### public $id : string
The controller identifier.






<a name="property_layout"></a>
### public $layout : null|string|false
The name of the layout to be applied to this controller's views.
This property mainly affects the behavior of render().
Defaults to null, meaning the actual layout value should inherit that from module's layout value.
If false, no layout will be applied.





<a name="property_module"></a>
### public $module : \piko\Module
The module that this controller belongs to.






<a name="property_viewPath"></a>
### public $viewPath : string
The root directory that contains view files for this controller.





-----

## Methods




<a name="method_render"></a>
### public render(): string

```php
public  render(string  $viewName, array  $data = []): string
```

Render a view.



#### Parameters
**$viewName** :
The view file name.

**$data**  (default: []):
An array of data (name-value pairs) to transmit to the view.






#### Return:
**string**
The view output.

-----



<a name="method_runAction"></a>
### public runAction(): mixed

```php
public  runAction(string  $id): mixed
```

Runs an action within this controller with the specified action ID.



#### Parameters
**$id** :
the ID of the action to be executed.




**throws**  \RuntimeExceptionif the requested action ID cannot be resolved into an action successfully.



#### Return:
**mixed**
the result of the action.

-----



<a name="method_getViewPath"></a>
### protected getViewPath(): string

```php
protected  getViewPath(): string
```

Returns the directory containing view files for this controller.
The default implementation returns the directory named as controller id under the module's
viewPath directory.







#### Return:
**string**
the directory containing the view files for this controller.

