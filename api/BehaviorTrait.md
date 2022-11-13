---
layout: default
title: BehaviorTrait
parent: API
---



# \Piko\BehaviorTrait

An instance using this trait can attach dynamically custom methods to itself.








## Properties summary

| Name | Description |
|------|-------------|
| public [`$behaviors`](#property_behaviors) | Behaviors container.  |


## Methods summary

| Name | Description |
|------|-------------|
| public [`__call`](#method___call) | Magic method to call a behavior.  |
| public [`attachBehavior`](#method_attachBehavior) | Attach a behavior to the class instance.  |
| public [`detachBehavior`](#method_detachBehavior) | Detach a behavior.  |


-----


## Properties


<a name="property_behaviors"></a>
### public **$behaviors** : callable[]
Behaviors container.





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



<a name="method_attachBehavior"></a>
### public **attachBehavior()**: void

```php
public  attachBehavior(string  $name, callable  $callback): void
```

Attach a behavior to the class instance.



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






