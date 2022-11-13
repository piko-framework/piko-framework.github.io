---
layout: default
title: User
nav_order: 8
---

# User

Piko Framework offers a lightweight user session manager to login/logout, check permissions and retrieve user 
identity between sessions.

This can be installed as a separate package in your project:

```bash
composer require piko/user
```

This package will install the [User](../api/User.md) [component](concepts.md#component).

## Configuration

The user component can be declared in the application [configuration](application.md#configuration).

```php
return [
    //...
    'components' => [
        'Piko\User' => [
            'identityClass' => 'app\modules\site\models\UserIdentity',
        ],
        //...
    ],
];

```

In order to use the user component, you have to declare an identity class which implements 
the [IdentityInterface](../api/IdentityInterface.md). In the above example, we use `app\modules\site\models\User` as
`identityClass`.

Example of `identityClass` implementation:

```php
<?php
namespace app\modules\site\models;

use Piko\IdentityInterface;
use Piko\ModelTrait

class UserIdentity implements IdentityInterface
{
    use ModelTrait;
    
    public $id;
    public $username;
    public $password;

    private static $users = [
        '1' => [
            'id' => '1',
            'username' => 'admin',
            'password' => 'yrztyz'
        ],
        '2' => [
            'id' => '2',
            'username' => 'user',
            'password' => 'jhgdhgj'
        ],
    ];

    public static function findByUsername($username)
    {
        foreach (self::$users as $user) {
            if ($user['username'] == $username) {
                return new static($user);
            }
        }

        return null;
    }

    public static function findIdentity($id)
    {
        return isset(self::$users[$id]) ? new static(self::$users[$id]) : null;
    }

    public function getId()
    {
        return $this->id;
    }
}

```


## Authentification

[User::login](../api/User.md#method_login) [User::logout](../api/User.md#method_logout) are methods 
that initialize and destroy user session.

Example:

```php
<?php
namespace app\modules\site\controllers;

use app\modules\site\models\UserIdentity;

class DefaultController extends \Piko\Controller
{
    //...

    public function loginAction()
    {
        $error = '';

        if ($this->request->GetMethod() == 'POST') {
            $post = $this->request->getParsedBody();

            $userIdentity = User::findByUsername($post['username']);

            if ($userIdentity instanceof UserIdentity) {
                if ($userIdentity->password == $post['password']) {
                    $app = $this->module->getApplication();
                    $user = $app->getComponent('Piko\User');
                    $user->login($userIdentity);
                    return $this->redirect($this->getUrl('site/default/index'));
                }

            }
        }

        return $this->render('login');
    }

    public function logoutAction()
    {
        $app = $this->module->getApplication();
        $user = $app->getComponent('Piko\User');
        $user->logout();
        $this->redirect($this->getUrl('site/default/index'));
    }
}
```

Other useful methods are:

- [User::getIdentity](../api/User.md#method_getIdentity) To retrieve the user identity
- [User::getId](../api/User.md#method_getId) To retrieve the user id
- [User::isGuest](../api/User.md#method_isGuest) To check if user is connected

```php
//...

$user = $app->getComponent('Piko\User');

if (!$user->isGuest()) {
    $identity = $user->getIdentity();
    $id = $user->getId();
    var_dump($identity);
    var_dump($id);
}

```

## Permissions

[User::can](../api/User.md#method_can) is used to check a user permission.

The control of the permission can be made by a `checkAccess` callback given in the User configuration.

The checkAccess callback must have this signature: 

```
checkAccess(int user_id, string permission): bool
```

Example to set checkAccess in the configuration:

```php
return [
    //...
    'components' => [
        'Piko\User' => [
            'identityClass' => 'app\modules\site\models\User',
            'checkAccess' => 'app\modules\site\models\UserIdentity::checkAccess'
        ],
        //...
    ],
];
```
