---
layout: default
title: Controller
parent: API
---



# \Piko\Controller

Controller is the base class for classes containing controller logic.








## Properties summary

| Name | Description |
|------|-------------|
| public [`$id`](#property_id) | The controller identifier.  |
| public [`$layout`](#property_layout) | The name of the layout to be applied to this contr... |
| public [`$module`](#property_module) | The module that this controller belongs to.  |
| public [`$viewPath`](#property_viewPath) | The root directory that contains view files for th... |
| protected [`$request`](#property_request) |   |
| protected [`$response`](#property_response) |   |
| protected [`$view`](#property_view) |   |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$behaviors`](BehaviorTrait.md#property_behaviors) | Behaviors container.  |
| protected [`$eventDispatcher`](EventHandlerTrait.md#property_eventDispatcher) |   |
| protected [`$listenerProvider`](EventHandlerTrait.md#property_listenerProvider) |   |

## Methods summary

| Name | Description |
|------|-------------|
| public [`getUrl`](#method_getUrl) | Converts a given modular route into its correspond... |
| public [`handle`](#method_handle) |   |
| protected [`create`](#method_create) | Create an object and resolve constructor dependenc... |
| protected [`forward`](#method_forward) | Forward the given route to another module  |
| protected [`getView`](#method_getView) | Returns the application View component  |
| protected [`getViewPath`](#method_getViewPath) | Returns the directory containing view files for th... |
| protected [`isAjax`](#method_isAjax) | Check if the request is AJAX  |
| protected [`jsonResponse`](#method_jsonResponse) | Convenient method to return a JSON response  |
| protected [`redirect`](#method_redirect) | Set a response redirection  |
| protected [`render`](#method_render) | Render a view.  |
| private [`getMethodArguments`](#method_getMethodArguments) |   |
| private [`runAction`](#method_runAction) | Runs an action within this controller with the spe... |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`__call`](/BehaviorTrait.md#method___call) | Magic method to call a behavior.  |
| public [`attachBehavior`](/BehaviorTrait.md#method_attachBehavior) | Attach a behavior to the class instance.  |
| public [`detachBehavior`](/BehaviorTrait.md#method_detachBehavior) | Detach a behavior.  |
| public [`on`](/EventHandlerTrait.md#method_on) | Registers an event listener.  |
| public [`trigger`](/EventHandlerTrait.md#method_trigger) | Trigger an event that may be listen by event liste... |

-----


## Properties


<a name="property_id"></a>
### public **$id** : string
The controller identifier.






<a name="property_layout"></a>
### public **$layout** : null|string|false
The name of the layout to be applied to this controller's views.
This property mainly affects the behavior of render().
Defaults to null, meaning the actual layout value should inherit that from module's layout value.
If false, no layout will be applied.





<a name="property_module"></a>
### public **$module** : \Piko\Module
The module that this controller belongs to.






<a name="property_viewPath"></a>
### public **$viewPath** : string
The root directory that contains view files for this controller.






<a name="property_request"></a>
### protected **$request** : \Psr\Http\Message\ServerRequestInterface






<a name="property_response"></a>
### protected **$response** : \Psr\Http\Message\ResponseInterface






<a name="property_view"></a>
### protected **$view** : \Piko\View\ViewInterface





-----

## Methods




<a name="method_getUrl"></a>
### public **getUrl()**: string

```php
public  getUrl(string  $route, string[]  $params = [], bool  $absolute = false): string
```

Converts a given modular route into its corresponding URL.
This method is useful for generating URLs dynamically, based on the specified
route and optional parameters. The route should follow the format:
{moduleId}/{ControllerId}/{ActionId}.


#### Parameters
**$route** :
The modular route in the format {moduleId}/{ControllerId}/{ActionId}.
This string determines which module, controller, and action to target.

**$params**  (default: []):
An optional associative array of query parameters to append
to the generated URL. Each key-value pair represents a parameter
name and its corresponding value.

**$absolute**  (default: false):
An optional boolean flag indicating whether the generated URL should be
absolute (including protocol and host) or relative. Defaults to false,
meaning a relative URL will be returned.






#### Return:
**string**
The resulting URL that corresponds to the provided route and parameters.

-----



<a name="method_handle"></a>
### public **handle()**: \Psr\Http\Message\ResponseInterface

```php
public  handle(\Psr\Http\Message\ServerRequestInterface  $request): \Psr\Http\Message\ResponseInterface
```



#### Parameters
**$request** :






#### Return:
**\Psr\Http\Message\ResponseInterface**


-----



<a name="method_create"></a>
### protected **create()**: object

```php
protected  create(class-string  $class, array&lt;string,mixed&gt;  $overrides = []): object
```

Create an object and resolve constructor dependencies from application components.



#### Parameters
**$class** :


**$overrides**  (default: []):
Constructor argument overrides indexed by parameter name.






#### Return:
**object**


-----



<a name="method_forward"></a>
### protected **forward()**: string

```php
protected  forward(string  $route, string[]  $params = []): string
```

Forward the given route to another module



#### Parameters
**$route** :
The route to forward

**$params**  (default: []):
An array of params (name-value pairs) associated to the route.






#### Return:
**string**


-----



<a name="method_getView"></a>
### protected **getView()**: \Piko\View\ViewInterface|null

```php
protected  getView(): \Piko\View\ViewInterface|null
```

Returns the application View component








#### Return:
**\Piko\View\ViewInterface|null**


-----



<a name="method_getViewPath"></a>
### protected **getViewPath()**: string

```php
protected  getViewPath(): string
```

Returns the directory containing view files for this controller.
The default implementation returns the directory named as controller id under the module's
viewPath directory.







#### Return:
**string**
the directory containing the view files for this controller.

-----



<a name="method_isAjax"></a>
### protected **isAjax()**: bool

```php
protected  isAjax(): bool
```

Check if the request is AJAX








#### Return:
**bool**


-----



<a name="method_jsonResponse"></a>
### protected **jsonResponse()**: \Psr\Http\Message\ResponseInterface

```php
protected  jsonResponse(mixed  $data): \Psr\Http\Message\ResponseInterface
```

Convenient method to return a JSON response



#### Parameters
**$data** :







#### Return:
**\Psr\Http\Message\ResponseInterface**


-----



<a name="method_redirect"></a>
### protected **redirect()**: \Psr\Http\Message\ResponseInterface

```php
protected  redirect(string  $url): \Psr\Http\Message\ResponseInterface
```

Set a response redirection



#### Parameters
**$url** :
The url to redirect






#### Return:
**\Psr\Http\Message\ResponseInterface**


-----



<a name="method_render"></a>
### protected **render()**: string

```php
protected  render(string  $viewName, array  $data = []): string
```

Render a view.



#### Parameters
**$viewName** :
The view file name.

**$data**  (default: []):
An array of data (name-value pairs) to transmit to the view.






#### Return:
**string**


-----



<a name="method_getMethodArguments"></a>
### private **getMethodArguments()**: array

```php
private  getMethodArguments(string  $methodName, array  $data = []): array
```




#### Parameters
**$methodName** :
The method to analyse

**$data**  (default: []):
A key-value paired array to bind into the method arguments.






#### Return:
**array**


-----



<a name="method_runAction"></a>
### private **runAction()**: \Psr\Http\Message\ResponseInterface

```php
private  runAction(string  $id, array  $params = []): \Psr\Http\Message\ResponseInterface
```

Runs an action within this controller with the specified action ID.



#### Parameters
**$id** :
the ID of the action to be executed.

**$params**  (default: []):
An array of request parameters.




**throws**  \RuntimeExceptionif the requested action ID cannot be resolved into an action successfully.



#### Return:
**\Psr\Http\Message\ResponseInterface**
the result of the action.

