---
layout: default
title: BeforeTranslateEvent
parent: API
---



# \Piko\I18n\Event\BeforeTranslateEvent

Event emitted before to translate a text








## Properties summary

| Name | Description |
|------|-------------|
| public [`$domain`](#property_domain) | The translation domain.  |
| public [`$params`](#property_params) | The translation parameters used to substitute tran... |
| public [`$text`](#property_text) | The text to translate.  |


## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |


-----


## Properties


<a name="property_domain"></a>
### public **$domain** : string
The translation domain.






<a name="property_params"></a>
### public **$params** : array&lt;string,string&gt;
The translation parameters used to substitute translation variables.






<a name="property_text"></a>
### public **$text** : string|null
The text to translate.





-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(string  $domain, string|null  $text, array&lt;string,string&gt;  $params): mixed
```




#### Parameters
**$domain** :
The translation domain

**$text** :
The text to translate

**$params** :
The translation parameters used to substitute translation variables






#### Return:
**mixed**


