---
layout: default
title: ModelTrait
parent: API
---



# \Piko\ModelTrait

Base model trait.








## Properties summary

| Name | Description |
|------|-------------|
| protected [`$errors`](#property_errors) | Errors hash container  |


## Methods summary

| Name | Description |
|------|-------------|
| public [`bind`](#method_bind) | Bind the data to the model attribubes.  |
| public [`getErrors`](#method_getErrors) | Return the errors hash container  |
| public [`isValid`](#method_isValid) | Check if the model is valid  |
| public [`toArray`](#method_toArray) | Get the model data as an associative array.  |
| protected [`getAttributes`](#method_getAttributes) | Get the public properties reprenting the data mode... |
| protected [`setError`](#method_setError) | Set an error that will be appended to the errors c... |
| protected [`validate`](#method_validate) | Validate this model (Should be extended). Inherite... |


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

Bind the data to the model attribubes.



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



<a name="method_setError"></a>
### protected **setError()**: void

```php
protected  setError(string  $errorName, string  $errorMsg): void
```

Set an error that will be appended to the errors container



#### Parameters
**$errorName** :


**$errorMsg** :





**see**  \Piko\ModelTrait::$errors



-----



<a name="method_validate"></a>
### protected **validate()**: void

```php
protected  validate(): void
```

Validate this model (Should be extended).
Inherited method should fill the errors array using the setError method if the model is not valid.





**see**  \Piko\ModelTrait::setError()

**see**  \Piko\ModelTrait::isValid()

**codeCoverageIgnore**  



