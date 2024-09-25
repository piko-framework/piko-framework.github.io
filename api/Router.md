---
layout: default
title: Router
parent: API
---



# \Piko\Router

Router class.








## Properties summary

| Name | Description |
|------|-------------|
| public [`$baseUri`](#property_baseUri) | Base uri The base uri is the base part of the requ... |
| public [`$host`](#property_host) | Http host  |
| public [`$protocol`](#property_protocol) | Http protocol used (http/https)  |
| protected [`$cacheHandlers`](#property_cacheHandlers) | Internal cache for routes handlers  |
| protected [`$fullyDynamicRoutes`](#property_fullyDynamicRoutes) | Name-value pair route to handler correspondance. T... |
| protected [`$radix`](#property_radix) | The radix trie storage utility  |
| protected [`$routes`](#property_routes) | Name-value pair route to handler correspondance. E... |
| protected [`$staticRoutes`](#property_staticRoutes) | Name-value pair route to handler correspondance. T... |

## Inherited Properties

| Name | Description |
|------|-------------|
| protected [`$eventDispatcher`](EventHandlerTrait.md#property_eventDispatcher) |   |
| protected [`$listenerProvider`](EventHandlerTrait.md#property_listenerProvider) |   |

## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |
| public [`addRoute`](#method_addRoute) | Register a route path and its corresponding handle... |
| public [`getUrl`](#method_getUrl) | Convert an handler to its corresponding route url ... |
| public [`resolve`](#method_resolve) | Parse the route path and return a match instance.  |
| protected [`findFullyDynamicRoute`](#method_findFullyDynamicRoute) | Search for a fully parameterized route against the... |
| protected [`gethandlerRoutes`](#method_gethandlerRoutes) | Retrieve all routes attached to the handler  |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`on`](/EventHandlerTrait.md#method_on) | Registers an event listener.  |
| public [`trigger`](/EventHandlerTrait.md#method_trigger) | Trigger an event that may be listen by event liste... |

-----


## Properties


<a name="property_baseUri"></a>
### public **$baseUri** : string
Base uri
The base uri is the base part of the request uri which shouldn't be parsed.
Example for the uri /home/blog/page : if the $baseUri is /home, the router will parse /blog/page





<a name="property_host"></a>
### public **$host** : string
Http host






<a name="property_protocol"></a>
### public **$protocol** : string
Http protocol used (http/https)






<a name="property_cacheHandlers"></a>
### protected **$cacheHandlers** : array&lt;string,string[]&gt;
Internal cache for routes handlers






<a name="property_fullyDynamicRoutes"></a>
### protected **$fullyDynamicRoutes** : array&lt;string,mixed&gt;
Name-value pair route to handler correspondance.
This contains only routes composed with params. Ex:
`'/:controller/:action' => ':controller/:action'`





<a name="property_radix"></a>
### protected **$radix** : \Piko\Router\RadixTrie
The radix trie storage utility






<a name="property_routes"></a>
### protected **$routes** : array&lt;string,mixed&gt;
Name-value pair route to handler correspondance.
Each key corresponds to a route. Each value corresponds to a route handler.
Routes and handlers can contain parameters. Ex:
`'/user/:id' => 'usercontroller/viewAction'`





<a name="property_staticRoutes"></a>
### protected **$staticRoutes** : array&lt;string,mixed&gt;
Name-value pair route to handler correspondance.
This contains only routes with non params.




-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(array&lt;string,mixed&gt;  $config = []): mixed
```

Constructor
Example:

```php
$router = new Router([
     'baseUri' => '/subdir',
     'routes' => [
         '/' => 'home',
         '/user/:id' => 'userView',
         '/:module/:controller/:action' => ':module/:controller/:action',
     ]
 ]);

```


#### Parameters
**$config**  (default: []):
A configuration array to set public properties and routes






#### Return:
**mixed**


-----



<a name="method_addRoute"></a>
### public **addRoute()**: void

```php
public  addRoute(string  $path, mixed  $handler): void
```

Register a route path and its corresponding handler



#### Parameters
**$path** :


**$handler** :







-----



<a name="method_getUrl"></a>
### public **getUrl()**: string

```php
public  getUrl(string  $handler, string[]  $params = [], bool  $absolute = false): string
```

Convert an handler to its corresponding route url (reverse routing).



#### Parameters
**$handler** :


**$params**  (default: []):
Optional query parameters.

**$absolute**  (default: false):
Optional to get an absolute url.






#### Return:
**string**
The corresponding url.

-----



<a name="method_resolve"></a>
### public **resolve()**: \Piko\Router\Matcher

```php
public  resolve(string  $path): \Piko\Router\Matcher
```

Parse the route path and return a match instance.



#### Parameters
**$path** :
The route path






#### Return:
**\Piko\Router\Matcher**
The route match.

-----



<a name="method_findFullyDynamicRoute"></a>
### protected **findFullyDynamicRoute()**: \Piko\Router\Matcher

```php
protected  findFullyDynamicRoute(string  $path): \Piko\Router\Matcher
```

Search for a fully parameterized route against the route path.
Ex: /:controller/:action


#### Parameters
**$path** :
The route path






#### Return:
**\Piko\Router\Matcher**
The route match

-----



<a name="method_gethandlerRoutes"></a>
### protected **gethandlerRoutes()**: string[]

```php
protected  gethandlerRoutes(string  $handler): string[]
```

Retrieve all routes attached to the handler



#### Parameters
**$handler** :







#### Return:
**string[]**


