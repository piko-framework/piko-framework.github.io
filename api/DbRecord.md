---
layout: default
title: DbRecord
parent: API
---



# \Piko\DbRecord

DbRecord represents a database table's row and implements
the Active Record pattern.







## Constants summary

| Name | Description |
|------|-------------|
| public [`TYPE_BOOL`](#constant_TYPE_BOOL) |   |
| public [`TYPE_INT`](#constant_TYPE_INT) |   |
| public [`TYPE_STRING`](#constant_TYPE_STRING) |   |

## Properties summary

| Name | Description |
|------|-------------|
| protected [`$data`](#property_data) |   |
| protected [`$db`](#property_db) | The database instance.  |
| protected [`$primaryKey`](#property_primaryKey) | The name of the primary key. Default to &#039;id&#039;.  |
| protected [`$schema`](#property_schema) | A name-value pair that describes the structure of ... |
| protected [`$tableName`](#property_tableName) | The name of the table.  |

## Inherited Properties

| Name | Description |
|------|-------------|
| protected [`$errors`](ModelTrait.md#property_errors) | Errors hash container  |
| protected [`$eventDispatcher`](EventHandlerTrait.md#property_eventDispatcher) |   |
| protected [`$listenerProvider`](EventHandlerTrait.md#property_listenerProvider) |   |

## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |
| public [`__get`](#method___get) | Magick method to access rows&#039;s data as class attri... |
| public [`__isset`](#method___isset) | Magick method to check if attribute is defined in ... |
| public [`__set`](#method___set) | Magick method to set row&#039;s data as class attribute... |
| public [`__unset`](#method___unset) | Magick method to unset attribute in row&#039;s data.  |
| public [`bind`](#method_bind) | Override ModelTrait::bind()  |
| public [`delete`](#method_delete) | Delete this record.  |
| public [`load`](#method_load) | Load row data.  |
| public [`save`](#method_save) | Save this record into the table.  |
| public [`toArray`](#method_toArray) | Override ModelTrait::toArray()  |
| protected [`afterDelete`](#method_afterDelete) | Method called after a delete action.  |
| protected [`afterSave`](#method_afterSave) | Method called after a save action.  |
| protected [`beforeDelete`](#method_beforeDelete) | Method called before a delete action.  |
| protected [`beforeSave`](#method_beforeSave) | Method called before a save action.  |
| protected [`checkColumn`](#method_checkColumn) | Check if column name is defined in the table schem... |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`bind`](/ModelTrait.md#method_bind) | Bind the data to the model attribubes.  |
| public [`getErrors`](/ModelTrait.md#method_getErrors) | Return the errors hash container  |
| public [`isValid`](/ModelTrait.md#method_isValid) | Check if the model is valid  |
| public [`on`](/EventHandlerTrait.md#method_on) |   |
| public [`toArray`](/ModelTrait.md#method_toArray) | Get the model data as an associative array.  |
| public [`trigger`](/EventHandlerTrait.md#method_trigger) | Trigger an event that may be listen by event liste... |
| protected [`getAttributes`](/ModelTrait.md#method_getAttributes) | Get the public properties reprenting the data mode... |
| protected [`setError`](/ModelTrait.md#method_setError) | Set an error that will be appended to the errors c... |
| protected [`validate`](/ModelTrait.md#method_validate) | Validate this model (Should be extended). Inherite... |

-----

<a name="constant_TYPE_BOOL"></a>
### public **$TYPE_BOOL**




<a name="constant_TYPE_INT"></a>
### public **$TYPE_INT**




<a name="constant_TYPE_STRING"></a>
### public **$TYPE_STRING**




-----

## Properties


<a name="property_data"></a>
### protected **$data** : array&lt;string,string|int|bool&gt;






<a name="property_db"></a>
### protected **$db** : \PDO
The database instance.






<a name="property_primaryKey"></a>
### protected **$primaryKey** : string
The name of the primary key. Default to 'id'.






<a name="property_schema"></a>
### protected **$schema** : int[]
A name-value pair that describes the structure of the table.
eg.`['id' => self::TYPE_INT, 'name' => 'id' => self::TYPE_STRING]`





<a name="property_tableName"></a>
### protected **$tableName** : string
The name of the table.





-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(\PDO  $db): mixed
```

Constructor



#### Parameters
**$db** :
A PDO instance






#### Return:
**mixed**


-----



<a name="method___get"></a>
### public **__get()**: mixed

```php
public  __get(string  $attribute): mixed
```

Magick method to access rows's data as class attribute.



#### Parameters
**$attribute** :
The attribute's name.






#### Return:
**mixed**
The attribute's value.

-----



<a name="method___isset"></a>
### public **__isset()**: mixed

```php
public  __isset(string  $attribute): mixed
```

Magick method to check if attribute is defined in row's data.



#### Parameters
**$attribute** :
The attribute's name.






#### Return:
**mixed**


-----



<a name="method___set"></a>
### public **__set()**: void

```php
public  __set(string  $attribute, string|int|bool  $value): void
```

Magick method to set row's data as class attribute.



#### Parameters
**$attribute** :
The attribute's name.

**$value** :
The attribute's value.






-----



<a name="method___unset"></a>
### public **__unset()**: mixed

```php
public  __unset(string  $attribute): mixed
```

Magick method to unset attribute in row's data.



#### Parameters
**$attribute** :
The attribute's name.






#### Return:
**mixed**


-----



<a name="method_bind"></a>
### public **bind()**: void

```php
public  bind(array&lt;string,string|int|bool&gt;  $data): void
```

Override ModelTrait::bind()



#### Parameters
**$data** :







-----



<a name="method_delete"></a>
### public **delete()**: bool

```php
public  delete(): bool
```

Delete this record.






**throws**  \RuntimeException



#### Return:
**bool**


-----



<a name="method_load"></a>
### public **load()**: static

```php
public  load(\Piko\number  $id): static
```

Load row data.



#### Parameters
**$id** :
The value of the row primary key.




**throws**  \RuntimeException



#### Return:
**static**


-----



<a name="method_save"></a>
### public **save()**: bool

```php
public  save(): bool
```

Save this record into the table.






**throws**  \RuntimeException



#### Return:
**bool**


-----



<a name="method_toArray"></a>
### public **toArray()**: array

```php
public  toArray(): array
```

Override ModelTrait::toArray()








#### Return:
**array**


-----



<a name="method_afterDelete"></a>
### protected **afterDelete()**: void

```php
protected  afterDelete(): void
```

Method called after a delete action.








-----



<a name="method_afterSave"></a>
### protected **afterSave()**: void

```php
protected  afterSave(): void
```

Method called after a save action.








-----



<a name="method_beforeDelete"></a>
### protected **beforeDelete()**: bool

```php
protected  beforeDelete(): bool
```

Method called before a delete action.








#### Return:
**bool**


-----



<a name="method_beforeSave"></a>
### protected **beforeSave()**: bool

```php
protected  beforeSave(bool  $insert): bool
```

Method called before a save action.



#### Parameters
**$insert** :
If the row is a new record, the value will be true, otherwise, false.






#### Return:
**bool**


-----



<a name="method_checkColumn"></a>
### protected **checkColumn()**: void

```php
protected  checkColumn(string  $name): void
```

Check if column name is defined in the table schema.



#### Parameters
**$name** :





**throws**  \RuntimeException

**see**  \Piko\DbRecord::$schema



