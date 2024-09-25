---
layout: default
title: AfterActionEvent
parent: API
---



# \Piko\Controller\Event\AfterActionEvent

AfterActionEvent is an event triggered after action method was called








## Properties summary

| Name | Description |
|------|-------------|
| public [`$actionId`](#property_actionId) | The action id  |
| public [`$controller`](#property_controller) |   |
| public [`$response`](#property_response) | The action method response  |


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






<a name="property_response"></a>
### public **$response** : \Psr\Http\Message\ResponseInterface
The action method response





-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(\Piko\Controller  $controller, string  $actionId, \Psr\Http\Message\ResponseInterface  $response): mixed
```




#### Parameters
**$controller** :
A controller instance

**$actionId** :

**$response** :
The action method response






#### Return:
**mixed**


