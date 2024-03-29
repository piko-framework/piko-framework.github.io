---
layout: default
title: IdentityInterface
parent: API
---



# \Piko\User\IdentityInterface

User identity interface.







## Methods summary

| Name | Description |
|------|-------------|
| public [`findIdentity`](#method_findIdentity) | Finds an identity by the given ID.  |
| public [`getId`](#method_getId) | Returns an ID that can uniquely identify a user id... |

-----


## Methods




<a name="method_findIdentity"></a>
### public **findIdentity()**: \Piko\User\IdentityInterface|null

```php
public static  findIdentity(string|int  $id): \Piko\User\IdentityInterface|null
```

Finds an identity by the given ID.



#### Parameters
**$id** :
the ID to be looked for






#### Return:
**\Piko\User\IdentityInterface|null**
the identity object that matches the given ID.
null should be returned if such an identity cannot be found

-----



<a name="method_getId"></a>
### public **getId()**: string|int

```php
public  getId(): string|int
```

Returns an ID that can uniquely identify a user identity.








#### Return:
**string|int**
an ID that uniquely identifies a user identity.

