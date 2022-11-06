---
layout: default
title: BeforeSaveEvent
parent: API
---



# \Piko\DbRecord\Event\BeforeSaveEvent

Event emitted before db save operation (INSERT / UPDATE)








## Properties summary

| Name | Description |
|------|-------------|
| public [`$insert`](#property_insert) | Flag to see if db save operation is INSERT. If fal... |
| public [`$isValid`](#property_isValid) | Indicates if the event is valid for further valida... |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$record`](AlterEvent.md#property_record) |   |

## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`__construct`](/AlterEvent.md#method___construct) | Constructor |

-----


## Properties


<a name="property_insert"></a>
### public **$insert** : bool
Flag to see if db save operation is INSERT.
If false, indicates that is an UPDATE operation.





<a name="property_isValid"></a>
### public **$isValid** : bool
Indicates if the event is valid for further validation.





-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(bool  $insert, \Piko\DbRecord  $record): mixed
```




#### Parameters
**$insert** :
Indicates if the operation is INSERT

**$record** :







#### Return:
**mixed**


