---
layout: default
title: EventHandlerTrait
parent: API
---



# \Piko\EventHandlerTrait

An instance using this trait become an event handler :
it can dispatches events and listen to them.








## Properties summary

| Name | Description |
|------|-------------|
| protected [`$eventDispatcher`](#property_eventDispatcher) |   |
| protected [`$listenerProvider`](#property_listenerProvider) |   |


## Methods summary

| Name | Description |
|------|-------------|
| public [`on`](#method_on) |   |
| public [`trigger`](#method_trigger) | Trigger an event that may be listen by event liste... |


-----


## Properties


<a name="property_eventDispatcher"></a>
### protected **$eventDispatcher** : \Psr\EventDispatcher\EventDispatcherInterface






<a name="property_listenerProvider"></a>
### protected **$listenerProvider** : \Piko\ListenerProvider





-----

## Methods




<a name="method_on"></a>
### public **on()**: mixed

```php
public  on(mixed  $eventClassName, callable  $callback, ?int  $priority = null): mixed
```



#### Parameters
**$eventClassName** :

**$callback** :

**$priority**  (default: null):






#### Return:
**mixed**


-----



<a name="method_trigger"></a>
### public **trigger()**: object

```php
public  trigger(object  $event): object
```

Trigger an event that may be listen by event listeners.



#### Parameters
**$event** :
The event instance to dispatch.






#### Return:
**object**
The same event instance that may be altered by event listeners.

