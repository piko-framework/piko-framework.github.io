---
layout: default
title: Model
parent: API
---



# \piko\Model

Base model class.








## Properties summary

| Name | Description |
|------|-------------|
| protected [`$errors`](#property_errors) | Errors hash container  |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$behaviors`](Component.md#property_behaviors) | Behaviors container.  |
| public [`$on`](Component.md#property_on) | Event listeners container.  |
| public [`$when`](Component.md#property_when) | Static event listeners container.  |

## Methods summary

| Name | Description |
|------|-------------|
| public [`bind`](#method_bind) | Bind directly the model data.  |
| public [`getErrors`](#method_getErrors) | Return the errors hash container  |
| public [`isValid`](#method_isValid) | Check if the model is valid  |
| public [`toArray`](#method_toArray) | Get the model data as an associative array.  |
| protected [`getAttributes`](#method_getAttributes) | Get the public properties reprenting the data mode... |
| protected [`validate`](#method_validate) | Validate this model (Should be extended)  |

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


<a name="property_errors"></a>
### protected **$errors** : string[]
Errors hash container





-----

## Methods




<a name="method_bind"></a>
### public **bind()**: void

```php
public  bind(array  $data): void
```

Bind directly the model data.



#### Parameters
**$data** :
An array of data (name-value pairs).






-----



<a name="method_getErrors"></a>
### public **getErrors()**: string[]

```php
public  getErrors(): string[]
```

Return the errors hash container








#### Return:
**string[]**


-----



<a name="method_isValid"></a>
### public **isValid()**: bool

```php
public  isValid(): bool
```

Check if the model is valid








#### Return:
**bool**


-----



<a name="method_toArray"></a>
### public **toArray()**: array

```php
public  toArray(): array
```

Get the model data as an associative array.








#### Return:
**array**


-----



<a name="method_getAttributes"></a>
### protected **getAttributes()**: array

```php
protected  getAttributes(): array
```

Get the public properties reprenting the data model








#### Return:
**array**


-----



<a name="method_validate"></a>
### protected **validate()**: void

```php
protected  validate(): void
```

Validate this model (Should be extended)








