---
layout: default
title: Component
parent: API
---



# \piko\Component

Component class offers events and behaviors features to inherited classes.
Public properties can be initialized with an array of configuration during instantiation.

Events offer the possibility to execute external code when they are triggered.
Behaviors offer the possibility to add custom methods without extending the class.







## Properties summary

| Name | Description |
|------|-------------|
| public [`$behaviors`](#property_behaviors) | Behaviors container.  |
| public [`$on`](#property_on) | Event listeners container.  |
| public [`$when`](#property_when) | Static event listeners container.  |


## Methods summary

| Name | Description |
|------|-------------|
| public [`__call`](#method___call) | Magic method to call a behavior.  |
| public [`__construct`](#method___construct) | Constructor |
| public [`attachBehavior`](#method_attachBehavior) | Attach a behavior to the component instance.  |
| public [`detachBehavior`](#method_detachBehavior) | Detach a behavior.  |
| public [`on`](#method_on) | Event registration.  |
| public [`trigger`](#method_trigger) | Trigger an event. Event listeners will be called i... |
| public [`when`](#method_when) | Static event registration.  |
| protected [`init`](#method_init) | Method called at the end of the constructor. This ... |


-----


## Properties


<a name="property_behaviors"></a>
### public **$behaviors** : callable[]
Behaviors container.






<a name="property_on"></a>
### public **$on** : callable[][]
Event listeners container.






<a name="property_when"></a>
### public **$when** : callable[][]
Static event listeners container.





-----

## Methods




<a name="method___call"></a>
### public **__call()**: mixed

```php
public  __call(string  $name, array&lt;int,mixed&gt;  $args): mixed
```

Magic method to call a behavior.



#### Parameters
**$name** :
The name of the behavior.

**$args** :
The behavior arguments.




**throws**  \RuntimeException



#### Return:
**mixed**


-----



<a name="method___construct"></a>
### public **__construct()**: void

```php
public  __construct(array&lt;string,array&gt;  $config = []): void
```

Constructor



#### Parameters
**$config**  (default: []):
A configuration array to set public properties of the class.






-----



<a name="method_attachBehavior"></a>
### public **attachBehavior()**: void

```php
public  attachBehavior(string  $name, callable  $callback): void
```

Attach a behavior to the component instance.



#### Parameters
**$name** :
The behavior name.

**$callback** :
The behavior implementation. Must be  one of the following:
- A Closure (function(){ ... })
- An object method ([$object, 'methodName'])
- A static class method ('MyClass::myMethod')
- A global function ('myFunction')
- An object implementing __invoke()






-----



<a name="method_detachBehavior"></a>
### public **detachBehavior()**: void

```php
public  detachBehavior(string  $name): void
```

Detach a behavior.



#### Parameters
**$name** :
The behavior name.






-----



<a name="method_on"></a>
### public **on()**: void

```php
public  on(string  $eventName, callable  $callback, string  $priority = 'after'): void
```

Event registration.



#### Parameters
**$eventName** :
The event name to listen.

**$callback** :
The event listener to register. Must be  one of the following:
- A Closure (function(){ ... })
- An object method ([$object, 'methodName'])
- A static class method ('MyClass::myMethod')
- A global function ('myFunction')
- An object implementing __invoke()

**$priority**  (default: 'after'):
The order priority in the events stack ('after' or 'before'). Default to 'after'.






-----



<a name="method_trigger"></a>
### public **trigger()**: array

```php
public  trigger(string  $eventName, array&lt;int,mixed&gt;  $args = []): array
```

Trigger an event.
Event listeners will be called in the order they are registered.


#### Parameters
**$eventName** :
The event name to trigger.

**$args**  (default: []):
The event arguments.






#### Return:
**array**


-----



<a name="method_when"></a>
### public **when()**: void

```php
public static  when(string  $eventName, callable  $callback, string  $priority = 'after'): void
```

Static event registration.



#### Parameters
**$eventName** :
The event name to listen.

**$callback** :
The event listener to register. Must be  one of the following:
- A Closure (function(){ ... })
- An object method ([$object, 'methodName'])
- A static class method ('MyClass::myMethod')
- A global function ('myFunction')
- An object implementing __invoke()

**$priority**  (default: 'after'):
The order priority in the events stack ('after' or 'before'). Default to 'after'.






-----



<a name="method_init"></a>
### protected **init()**: void

```php
protected  init(): void
```

Method called at the end of the constructor.
This could be overriden in inherited classes.







