---
layout: default
title: ObjectFactoryInterface
parent: API
---



# \Piko\Di\ObjectFactoryInterface

Contract for a factory able to instantiate a class and resolve its
constructor dependencies (autowiring).







## Methods summary

| Name | Description |
|------|-------------|
| public [`create`](#method_create) | Create an object and resolve its constructor depen... |

-----


## Methods




<a name="method_create"></a>
### public **create()**: object

```php
public  create(class-string  $class, array&lt;string,mixed&gt;  $overrides = []): object
```

Create an object and resolve its constructor dependencies.



#### Parameters
**$class** :
The class to instantiate.

**$overrides**  (default: []):
Constructor argument overrides indexed by parameter name.






#### Return:
**object**


