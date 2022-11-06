---
layout: default
title: User
parent: API
---



# \Piko\User

Application User base class.








## Properties summary

| Name | Description |
|------|-------------|
| public [`$authTimeout`](#property_authTimeout) | The number of seconds in which the user will be lo... |
| public [`$checkAccess`](#property_checkAccess) | Callback to check user permission The callback sig... |
| public [`$identityClass`](#property_identityClass) | The class name of the identity object.  |
| protected [`$access`](#property_access) | Internal cache of access permissions.  |
| protected [`$identity`](#property_identity) | The identity instance.  |

## Inherited Properties

| Name | Description |
|------|-------------|
| protected [`$eventDispatcher`](EventHandlerTrait.md#property_eventDispatcher) |   |
| protected [`$listenerProvider`](EventHandlerTrait.md#property_listenerProvider) |   |

## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |
| public [`can`](#method_can) | Check if the user can do an action.  |
| public [`getId`](#method_getId) | Get user identifier.  |
| public [`getIdentity`](#method_getIdentity) | Get user identity  |
| public [`isGuest`](#method_isGuest) | Returns a value indicating whether the user is a g... |
| public [`login`](#method_login) | Start the session and set user identity.  |
| public [`logout`](#method_logout) | Destroy the session and remove user identity.  |
| public [`setIdentity`](#method_setIdentity) | Set user identity.  |
| protected [`startSession`](#method_startSession) |   |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`on`](/EventHandlerTrait.md#method_on) |   |
| public [`trigger`](/EventHandlerTrait.md#method_trigger) | Trigger an event that may be listen by event liste... |

-----


## Properties


<a name="property_authTimeout"></a>
### public **$authTimeout** : int
The number of seconds in which the user will be logged out automatically if he remains inactive.






<a name="property_checkAccess"></a>
### public **$checkAccess** : callable
Callback to check user permission
The callback signature must be : function(int $userId, string $permission): bool





<a name="property_identityClass"></a>
### public **$identityClass** : string
The class name of the identity object.






<a name="property_access"></a>
### protected **$access** : bool[]
Internal cache of access permissions.






<a name="property_identity"></a>
### protected **$identity** : \Piko\User\IdentityInterface|null
The identity instance.





-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(array&lt;string,mixed&gt;  $config = []): mixed
```




#### Parameters
**$config**  (default: []):







#### Return:
**mixed**


-----



<a name="method_can"></a>
### public **can()**: bool

```php
public  can(string  $permission): bool
```

Check if the user can do an action.



#### Parameters
**$permission** :
The permission name.






#### Return:
**bool**


-----



<a name="method_getId"></a>
### public **getId()**: string|int|null

```php
public  getId(): string|int|null
```

Get user identifier.








#### Return:
**string|int|null**


-----



<a name="method_getIdentity"></a>
### public **getIdentity()**: \Piko\User\IdentityInterface|null

```php
public  getIdentity(): \Piko\User\IdentityInterface|null
```

Get user identity








#### Return:
**\Piko\User\IdentityInterface|null**
The user identity or null if no identity is found.

-----



<a name="method_isGuest"></a>
### public **isGuest()**: bool

```php
public  isGuest(): bool
```

Returns a value indicating whether the user is a guest (not authenticated).








#### Return:
**bool**
whether the current user is a guest.

-----



<a name="method_login"></a>
### public **login()**: void

```php
public  login(\Piko\User\IdentityInterface  $identity): void
```

Start the session and set user identity.



#### Parameters
**$identity** :
The user identity.






-----



<a name="method_logout"></a>
### public **logout()**: void

```php
public  logout(): void
```

Destroy the session and remove user identity.








-----



<a name="method_setIdentity"></a>
### public **setIdentity()**: void

```php
public  setIdentity(\Piko\User\IdentityInterface  $identity): void
```

Set user identity.



#### Parameters
**$identity** :
The user identity.




**throws**  \RuntimeExceptionIf identiy doesn't implement IdentityInterface.



-----



<a name="method_startSession"></a>
### protected **startSession()**: void

```php
protected  startSession(): void
```








