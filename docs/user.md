---
layout: default
title: User
nav_order: 8
---

# User

The Piko **User** component is a lightweight user/session manager. It lets you:

- persist a logged-in user across HTTP requests using PHP sessions
- authenticate users (login / logout)
- access the current user identity (ID and custom fields)
- check permissions through a configurable callback

Install it as a separate package:

```bash
composer require piko/user
```

This package provides the [`Piko\User`](../api/User.md) [component](concepts.md#component).


## Configuration

Register the User component in your application [configuration](modular-application/index.md#configuration):

```php
return [
    // ...
    'components' => [
        'Piko\\User' => [
            // FQCN of the identity class implementing Piko\User\IdentityInterface
            'identityClass' => 'app\\modules\\site\\models\\UserIdentity',

            // Optional: session timeout in seconds (see below)
            // 'authTimeout' => 3600,

            // Optional: permission check callback (see "Permissions" section)
            // 'checkAccess' => 'app\\modules\\site\\models\\UserIdentity::checkAccess',
        ],
        // ...
    ],
];
```

Configuration options:

- **`identityClass`** (required) – fully qualified class name of your user
  identity. The class **must implement**
  [`Piko\User\IdentityInterface`](../api/IdentityInterface.md).
- **`authTimeout`** (optional, `int`) – if set, `User` configures
  `session.gc_maxlifetime` to this value when the first session is started. The
  actual expiration still depends on PHP's session GC.
- **`checkAccess`** (optional, `callable`) – callback used by
  [`User::can()`](../api/User.md#method_can) to check permissions.

Once configured, you can retrieve the component from the application:

```php
/** @var Piko\User $user */
$user = $app->getComponent('Piko\\User');
```

In modular applications, `Piko\Module` and `Piko\Controller` can also receive
`Piko\User` via constructor injection (see the authentication example below).


## Identity class

To use the user component you must provide an **identity class** that
implements [`Piko\User\IdentityInterface`](../api/IdentityInterface.md).

A simplified example based on the default Piko project:

```php
<?php
namespace app\modules\site\models;

use Piko;                       // for Piko::configureObject
use Piko\User\IdentityInterface;

/**
 * Application user identity.
 */
class UserIdentity implements IdentityInterface
{
    public $id;
    public $username;
    public $password;

    /**
     * In a real application, this data would come from a database.
     */
    private static $users = [
        '1' => [
            'id'       => '1',
            'username' => 'admin',
            'password' => 'admin',
        ],
        '2' => [
            'id'       => '2',
            'username' => 'demo',
            'password' => 'demo',
        ],
    ];

    /**
     * Locate a user by username.
     *
     * @param string $username
     * @return static|null
     */
    public static function findByUsername($username)
    {
        foreach (self::$users as $user) {
            if ($user['username'] == $username) {
                $identity = new static();
                Piko::configureObject($identity, $user);

                return $identity;
            }
        }

        return null;
    }

    /**
     * Very basic password check used for the example.
     * In production, use proper password hashing.
     *
     * @param string $password
     * @return bool
     */
    public function validatePassword($password)
    {
        return $this->password == $password;
    }

    /**
     * Find an identity by its primary key.
     *
     * @param string|int $id
     * @return static|null
     */
    public static function findIdentity($id)
    {
        if (isset(self::$users[$id])) {
            $identity = new static();
            Piko::configureObject($identity, self::$users[$id]);

            return $identity;
        }

        return null;
    }

    /**
     * Return the unique identifier for this identity.
     *
     * @return string|int
     */
    public function getId()
    {
        return $this->id;
    }
}
```

`IdentityInterface` only requires two static/instance methods:

- `public static function findIdentity($id)` – must return an identity instance
  for the given ID or `null` if not found.
- `public function getId()` – must return the unique ID of the identity.

Additional helper methods such as `findByUsername()` and `validatePassword()`
are application-specific conveniences used by your controllers.


## Authentication

The main authentication entry points are:

- [`User::login()`](../api/User.md#method_login) – starts the session (if
  needed), sets the identity and stores its ID in `$_SESSION['_id']`. It also
  triggers `BeforeLoginEvent` and `AfterLoginEvent`.
- [`User::logout()`](../api/User.md#method_logout) – starts the session (if
  needed), triggers `BeforeLogoutEvent`, destroys the session, triggers
  `AfterLogoutEvent` and clears the in-memory identity and permission cache.

A typical controller implementation (again matching the default Piko project):

```php
<?php
namespace app\modules\site\controllers;

use Piko\User;
use app\modules\site\models\UserIdentity;

class DefaultController extends \Piko\Controller
{
    /**
     * The User component is injected automatically based on the
     * component definition in the application config.
     */
    public function __construct(private User $user)
    {
    }

    public function loginAction()
    {
        $error = '';

        if ($this->request->getMethod() === 'POST') {
            $post = $this->request->getParsedBody();

            $identity = UserIdentity::findByUsername($post['username'] ?? '');

            if ($identity instanceof UserIdentity
                && $identity->validatePassword($post['password'] ?? '')
            ) {
                $this->user->login($identity);

                return $this->redirect($this->getUrl('site/default/index'));
            }

            $error = 'Authentication failed';
        }

        return $this->render('login', [
            'error' => $error,
        ]);
    }

    public function logoutAction()
    {
        $this->user->logout();

        return $this->redirect($this->getUrl('site/default/index'));
    }
}
```

If you do not use constructor injection, you can retrieve the component from
the application explicitly:

```php
$app = $this->module->getApplication();
/** @var Piko\User $user */
$user = $app->getComponent('Piko\\User');

$user->login($identity);
```


## Working with the current user

Useful methods exposed by the `User` component are:

- [`User::getIdentity()`](../api/User.md#method_getIdentity) – returns the
  current identity instance or `null` if the user is not authenticated.
- [`User::getId()`](../api/User.md#method_getId) – returns the ID of the
  current identity (`string|int|null`).
- [`User::isGuest()`](../api/User.md#method_isGuest) – returns `true` if there
  is no current identity.

Example:

```php
/** @var Piko\User $user */
$user = $app->getComponent('Piko\\User');

if (!$user->isGuest()) {
    $identity = $user->getIdentity();   // instance of UserIdentity
    $id       = $user->getId();         // string|int

    var_dump($identity);
    var_dump($id);
}
```

When `User::getIdentity()` is called for the first time in a request, the
component:

1. Ensures the session is started.
2. Reads `$_SESSION['_id']` (if present).
3. Calls `YourIdentityClass::findIdentity($id)` to reconstruct the identity.

The identity is then cached in memory for the duration of the request.


## Permissions

[`User::can()`](../api/User.md#method_can) is used to check whether the current
user has a given permission:

```php
if ($user->can('editPost')) {
    // allow editing the post
}
```

`User::can()` delegates the decision to the **`checkAccess` callback**
configured on the User component. The callback receives two arguments:

```php
function checkAccess($userId, string $permission): bool
```

- `$userId` – result of `User::getId()` (typically `string|int|null`).
- `$permission` – permission name to check, as passed to `User::can()`.

The return value must be a boolean. `User::can()` caches the result per
permission name for the lifetime of the `User` instance.

Example configuration using a static method on the identity class:

```php
return [
    // ...
    'components' => [
        'Piko\\User' => [
            'identityClass' => 'app\\modules\\site\\models\\UserIdentity',
            'checkAccess'   => 'app\\modules\\site\\models\\UserIdentity::checkAccess',
        ],
        // ...
    ],
];
```

And a minimal implementation in `UserIdentity`:

```php
class UserIdentity implements IdentityInterface
{
    // ... existing code ...

    public static function checkAccess($userId, string $permission): bool
    {
        // Example: simple hard-coded permissions
        if ($userId === null) {
            return false; // guests have no permissions
        }

        if ($permission === 'adminOnly') {
            return $userId === '1'; // only user with ID 1
        }

        return true; // allow everything else
    }
}
```

You are free to implement any permission strategy you like (role-based access
control, per-resource ACL, etc.) as long as the callback matches the expected
signature and returns a boolean.


## Best practices

The examples above are intentionally simple to focus on how the `User`
component works. In real-world applications, consider the following
recommendations:

- **Use secure password storage**:
  - Never store plain-text passwords.
  - Use `password_hash()` and `password_verify()` (or a well-reviewed library)
    in your identity class instead of comparing raw strings.
- **Back identities with a persistent store**:
  - Replace the in-memory `$users` array with a proper persistence layer
    (database, external identity provider, etc.).
  - Implement `findIdentity()` and any `findBy*()` helpers using your model or
    repository layer.
- **Harden session handling**:
  - Configure secure session options (cookie flags, lifetime, HTTPS-only) at
    the PHP / web server level.
  - Call `session_regenerate_id(true)` on successful login if your application
    handles session management directly.
- **Define a clear permission model**:
  - Use `checkAccess` to centralize permission logic instead of scattering
    checks across controllers.
  - Start with simple role-based checks and evolve towards finer-grained
    permissions (per-resource ACL, ownership checks) as needed.
- **Avoid leaking identity details**:
  - Only expose the fields you actually need in views or APIs.
  - Be careful not to log or display sensitive attributes (password hashes,
    tokens, etc.).
