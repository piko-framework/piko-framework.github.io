---
layout: default
title: ObjectFactory
parent: API
---



# \Piko\Di\ObjectFactory

Instantiate a class and resolve its constructor dependencies from a PSR-11 container
(autowiring). Dependencies typed with a class/interface are fetched from the container;
built-in typed parameters fall back to overrides, default values or null.










## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |
| public [`create`](#method_create) | Create an object and resolve its constructor depen... |


-----



## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(\Psr\Container\ContainerInterface  $container): mixed
```



#### Parameters
**$container** :






#### Return:
**mixed**


-----



<a name="method_create"></a>
### public **create()**: object

```php
public  create(string  $class, array  $overrides = []): object
```

Create an object and resolve its constructor dependencies.



#### Parameters
**$class** :
The class to instantiate.

**$overrides**  (default: []):
Constructor argument overrides indexed by parameter name.




**throws**  \RuntimeExceptionIf the class does not exist or a mandatory dependency
cannot be resolved.



#### Return:
**object**


