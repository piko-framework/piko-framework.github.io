---
layout: default
title: Application
parent: API
---



# \piko\Application

The Web application class








## Properties summary

| Name | Description |
|------|-------------|
| public [`$basePath`](#property_basePath) | The absolute base path of the application.  |
| public [`$bootstrap`](#property_bootstrap) | List of module IDs that should be run during the a... |
| public [`$charset`](#property_charset) | The charset encoding used in the application.  |
| public [`$config`](#property_config) | The configuration loaded on application instantiat... |
| public [`$defaultLayout`](#property_defaultLayout) | The default layout name without file extension.  |
| public [`$defaultLayoutPath`](#property_defaultLayoutPath) | The default layout path. An alias could be used.  |
| public [`$errorRoute`](#property_errorRoute) | The Error route to display exceptions in a friendl... |
| public [`$headers`](#property_headers) | The response headers.  |
| public [`$instance`](#property_instance) | Application Instance  |
| public [`$language`](#property_language) | The language that is meant to be used for end user... |
| public [`$modules`](#property_modules) | List of modules configurations. Should be either :... |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$behaviors`](Component.md#property_behaviors) | Behaviors container.  |
| public [`$on`](Component.md#property_on) | Event listeners container.  |
| public [`$when`](Component.md#property_when) | Static event listeners container.  |

## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |
| public [`dispatch`](#method_dispatch) | Dispatch a route and return the output result.  |
| public [`getInstance`](#method_getInstance) | Get the application instance  |
| public [`getModule`](#method_getModule) | Get a module instance  |
| public [`getRouter`](#method_getRouter) | Get the application router instance  |
| public [`getView`](#method_getView) | Get the application view instance  |
| public [`run`](#method_run) | Run the application.  |
| public [`setHeader`](#method_setHeader) | Set Response header  |

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


<a name="property_basePath"></a>
### public **$basePath** : string
The absolute base path of the application.






<a name="property_bootstrap"></a>
### public **$bootstrap** : string[]
List of module IDs that should be run during the application bootstrapping process.
Each module may be specified with a module ID as specified via [[modules]].

During the bootstrapping process, each module will be instantiated. If the module class
implements the bootstrap() method, this method will be also be called.





<a name="property_charset"></a>
### public **$charset** : string
The charset encoding used in the application.






<a name="property_config"></a>
### public **$config** : array
The configuration loaded on application instantiation.






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





<a name="property_headers"></a>
### public **$headers** : string[]
The response headers.






<a name="property_instance"></a>
### public **$instance** : \piko\Application
Application Instance






<a name="property_language"></a>
### public **$language** : string
The language that is meant to be used for end users.






<a name="property_modules"></a>
### public **$modules** : array
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



**see**  \piko\ModuleTo have more informations on module attributes


-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: void

```php
public  __construct(array  $config): void
```

Constructor



#### Parameters
**$config** :
The application configuration.






-----



<a name="method_dispatch"></a>
### public **dispatch()**: string

```php
public  dispatch(string  $route, string[]  $params = []): string
```

Dispatch a route and return the output result.



#### Parameters
**$route** :
The route to dispatch. The route format is one of the following :
```
'{moduleId}/{subModuleId}/.../{controllerId}/{actionId}'
'{moduleId}/{controllerId}/{actionId}'
'{moduleId}/{controllerId}'
'{moduleId}'
```

**$params**  (default: []):
Optional route parameters




**throws**  \RuntimeException



#### Return:
**string**
The output result.

-----



<a name="method_getInstance"></a>
### public **getInstance()**: \piko\Application

```php
public static  getInstance(): \piko\Application
```

Get the application instance








#### Return:
**\piko\Application**


-----



<a name="method_getModule"></a>
### public **getModule()**: \piko\Module

```php
public  getModule(string  $moduleId): \piko\Module
```

Get a module instance



#### Parameters
**$moduleId** :
The module identifier




**throws**  \RuntimeException



#### Return:
**\piko\Module**
instance

-----



<a name="method_getRouter"></a>
### public **getRouter()**: \piko\Router

```php
public  getRouter(): \piko\Router
```

Get the application router instance








#### Return:
**\piko\Router**
instance

-----



<a name="method_getView"></a>
### public **getView()**: \piko\View

```php
public  getView(): \piko\View
```

Get the application view instance








#### Return:
**\piko\View**
instance

-----



<a name="method_run"></a>
### public **run()**: void

```php
public  run(): void
```

Run the application.








-----



<a name="method_setHeader"></a>
### public **setHeader()**: void

```php
public  setHeader(string  $header, string  $value = ''): void
```

Set Response header



#### Parameters
**$header** :
The complete header (key:value) or just the header key

**$value**  (default: ''):
(optional) The header value






