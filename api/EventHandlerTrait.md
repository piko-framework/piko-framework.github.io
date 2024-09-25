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
| public [`on`](#method_on) | Registers an event listener.  |
| public [`trigger`](#method_trigger) | Trigger an event that may be listen by event liste... |


-----


## Properties


<a name="property_eventDispatcher"></a>
### protected **$eventDispatcher** : ?\Psr\EventDispatcher\EventDispatcherInterface






<a name="property_listenerProvider"></a>
### protected **$listenerProvider** : ?\Piko\ListenerProvider





-----

## Methods




<a name="method_on"></a>
### public **on()**: mixed

```php
public  on(string  $eventClassName, callable  $callback, int|null  $priority = null): mixed
```

Registers an event listener.



#### Parameters
**$eventClassName** :
The class name of the event to listen for.

**$callback** :
The callback to execute when the event is dispatched.

**$priority**  (default: null):
Optional priority for the listener (higher means earlier execution).






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

