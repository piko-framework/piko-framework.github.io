---
layout: default
title: BeforeActionEvent
parent: API
---



# \Piko\Controller\Event\BeforeActionEvent

BeforeActionEvent is an event triggered before to call action method








## Properties summary

| Name | Description |
|------|-------------|
| public [`$actionId`](#property_actionId) | The action id  |
| public [`$controller`](#property_controller) |   |
| public [`$params`](#property_params) | The action parameters  |


## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |


-----


## Properties


<a name="property_actionId"></a>
### public **$actionId** : string
The action id






<a name="property_controller"></a>
### public **$controller** : \Piko\Controller






<a name="property_params"></a>
### public **$params** : array&lt;string,mixed&gt;
The action parameters





-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(\Piko\Controller  $controller, string  $actionId, array&lt;string,mixed&gt;  $params = []): mixed
```




#### Parameters
**$controller** :
A controller instance

**$actionId** :

**$params**  (default: []):
The action parameters






#### Return:
**mixed**


