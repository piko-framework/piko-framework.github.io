---
layout: default
title: BeforeRenderEvent
parent: API
---



# \Piko\View\Event\BeforeRenderEvent

BeforeRenderEvent is an event triggered before view script rendering








## Properties summary

| Name | Description |
|------|-------------|
| public [`$file`](#property_file) | The view script path  |
| public [`$model`](#property_model) | The view script model  |
| public [`$view`](#property_view) |   |


## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |


-----


## Properties


<a name="property_file"></a>
### public **$file** : string
The view script path






<a name="property_model"></a>
### public **$model** : array&lt;string,mixed&gt;
The view script model






<a name="property_view"></a>
### public **$view** : \Piko\View





-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(\Piko\View  $view, string  $file, array&lt;string,mixed&gt;  $model = []): mixed
```




#### Parameters
**$view** :
A view instance

**$file** :
A view script path

**$model**  (default: []):
The view script model






#### Return:
**mixed**


