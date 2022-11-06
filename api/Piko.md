---
layout: default
title: Piko
parent: API
---



# \Piko

Piko is the helper class for the Piko framework.








## Properties summary

| Name | Description |
|------|-------------|
| protected [`$aliases`](#property_aliases) | The aliases container.  |


## Methods summary

| Name | Description |
|------|-------------|
| public [`configureObject`](#method_configureObject) | Configure public properties of an object.  |
| public [`createObject`](#method_createObject) | Generic factory method.  |
| public [`getAlias`](#method_getAlias) | Translates a path alias into an actual path.  |
| public [`reset`](#method_reset) | Reset aliases  |
| public [`setAlias`](#method_setAlias) | Registers a path alias. A path alias is a short na... |


-----


## Properties


<a name="property_aliases"></a>
### protected **$aliases** : string[]
The aliases container.





-----

## Methods




<a name="method_configureObject"></a>
### public **configureObject()**: void

```php
public static  configureObject(object  $object, array&lt;string,mixed&gt;  $data = []): void
```

Configure public properties of an object.



#### Parameters
**$object** :
The object instance.

**$data**  (default: []):
A key-value array corresponding to the public properties of an object.






-----



<a name="method_createObject"></a>
### public **createObject()**: object

```php
public static  createObject(class-string|array&lt;string,mixed&gt;  $type, array&lt;string,mixed&gt;  $properties = []): object
```

Generic factory method.



#### Parameters
**$type** :
The object type.
If it is a string, it should be the fully qualified name of the class.
If an array given, it must contain the key 'class' with the value corresponding
to the fully qualified name of the class. It should also contain the key 'construct' to give an array of
constuctor arguments

**$properties**  (default: []):
A key-value paired array corresponding to the object public properties.






#### Return:
**object**


-----



<a name="method_getAlias"></a>
### public **getAlias()**: string|bool

```php
public static  getAlias(string  $alias): string|bool
```

Translates a path alias into an actual path.



#### Parameters
**$alias** :
The alias to be translated.






#### Return:
**string|bool**
The path corresponding to the alias. False if the alias is not registered.

-----



<a name="method_reset"></a>
### public **reset()**: void

```php
public static  reset(): void
```

Reset aliases








-----



<a name="method_setAlias"></a>
### public **setAlias()**: void

```php
public static  setAlias(string  $alias, string  $path): void
```

Registers a path alias.
A path alias is a short name representing a long path (a file path, a URL, etc.)


#### Parameters
**$alias** :
The alias name (e.g. "@web"). It must start with a '@' character.

**$path** :
the path corresponding to the alias.




**throws**  \InvalidArgumentExceptionif $path is an invalid alias.

**see**  \Piko::getAlias()



