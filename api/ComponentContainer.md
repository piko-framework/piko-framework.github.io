---
layout: default
title: ComponentContainer
parent: API
---



# \Piko\Di\ComponentContainer

PSR-11 container backed by the application component registry.
Components may be registered as ready-made objects or as lazy factories
(callables). A callable is invoked on first access, then its result is
memoized so that subsequent calls return the same instance (lazy singleton).

The registry is shared by reference with its owner (Piko\Application::$components)
so that memoization and external mutations of the registry stay in sync.









## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |
| public [`get`](#method_get) | {@inheritDoc}  |
| public [`has`](#method_has) | {@inheritDoc}  |


-----



## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct((object|callable)[] &amp; $components): mixed
```




#### Parameters
**$components** :
The component registry, passed by reference.






#### Return:
**mixed**


-----



<a name="method_get"></a>
### public **get()**: mixed

```php
public  get(string  $id): mixed
```

{@inheritDoc}



#### Parameters
**$id** :




**throws**  \Piko\Di\Exception\NotFoundExceptionIf no component is registered under the given id.

**throws**  \Piko\Di\Exception\ContainerExceptionIf a lazy factory does not resolve to an object.



#### Return:
**mixed**


-----



<a name="method_has"></a>
### public **has()**: bool

```php
public  has(string  $id): bool
```

{@inheritDoc}



#### Parameters
**$id** :






#### Return:
**bool**


