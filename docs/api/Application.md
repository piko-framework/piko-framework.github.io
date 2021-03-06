---
layout: default
title: Application
parent: API
---



# \piko\Application

The Web application class








## Properties

| Name | Description |
|------|-------------|
| public [`$basePath`](#property_basePath) | The absolute base path of the application.  |
| public [`$bootstrap`](#property_bootstrap) | List of modules that should be run during the appl... |
| public [`$charset`](#property_charset) | The charset encoding used in the application.  |
| public [`$config`](#property_config) | The configuration loaded on application instantiat... |
| public [`$defaultLayout`](#property_defaultLayout) | The default layout name without file extension.  |
| public [`$defaultLayoutPath`](#property_defaultLayoutPath) | The default layout path. An alias could be used.  |
| public [`$errorRoute`](#property_errorRoute) | The Error route to display exceptions in a friendl... |
| public [`$language`](#property_language) | The language that is meant to be used for end user... |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$behaviors`](Component.md#property_behaviors) | Behaviors container.  |
| public [`$events`](Component.md#property_events) | Event handlers container.  |
| public [`$events2`](Component.md#property_events2) | Static event handlers container.  |

## Methods

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor  |
| public [`dispatch`](#method_dispatch) | Dispatch a route and return the output result.  |
| public [`redirect`](#method_redirect) | Redirect the application to another url.  |
| public [`run`](#method_run) | Run the application.  |

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


<a name="property_basePath"></a>
### public $basePath : string
The absolute base path of the application.






<a name="property_bootstrap"></a>
### public $bootstrap : array
List of modules that should be run during the application bootstrapping process.
Each module may be specified with a module ID as specified via [[modules]].

During the bootstrapping process, each module will be instantiated. If the module class
implements the bootstrap() method, this method will be also be called.





<a name="property_charset"></a>
### public $charset : string
The charset encoding used in the application.






<a name="property_config"></a>
### public $config : array
The configuration loaded on application instantiation.






<a name="property_defaultLayout"></a>
### public $defaultLayout : string
The default layout name without file extension.






<a name="property_defaultLayoutPath"></a>
### public $defaultLayoutPath : string
The default layout path. An alias could be used.






<a name="property_errorRoute"></a>
### public $errorRoute : string
The Error route to display exceptions in a friendly way.
If not set, Exceptions catched will be thrown and stop the script execution.





<a name="property_language"></a>
### public $language : string
The language that is meant to be used for end users.





-----

## Methods




<a name="method___construct"></a>
### public __construct(): void

```php
public  __construct(array  $config): void
```

Constructor



#### Parameters
**$config** :
The application configuration.






-----



<a name="method_dispatch"></a>
### public dispatch(): string

```php
public  dispatch(string  $route): string
```

Dispatch a route and return the output result.



#### Parameters
**$route** :
The route to dispatch. The route format is one of the following :
```
'{moduleId}/{controllerId}/{actionId}'
'{moduleId}/{controllerId}'
'{moduleId}'
```




**throws**  \RuntimeException



#### Return:
**string**
The output result.

-----



<a name="method_redirect"></a>
### public redirect(): void

```php
public  redirect(string  $url): void
```

Redirect the application to another url.



#### Parameters
**$url** :







-----



<a name="method_run"></a>
### public run(): void

```php
public  run(): void
```

Run the application.








