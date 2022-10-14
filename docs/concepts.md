---
layout: default
title: Concepts
nav_order: 5
---

# Concepts

<a name="alias"></a>

## Alias

Alias are a convenient way to retrieve paths in the application. They are prefixed by the character `@`. By default, 
3 paths were created in the application initialization:
`@app` is the application root path, 
`@webroot` is the public directory root path and
`@web` is the uri base path.

Use [Piko::getAlias()](../api/Piko.md#method_getAlias) to retrieve a path or 
[piko::setAlias()](../api/Piko.md#method_setAlias) to register a path.

Example using getAlias() and setAlias(): 

```php
use piko\Piko;

echo Piko::getAlias('@app/modules/site'); // /usr/local/share/myapp/modules/site
echo Piko::getAlias('@webroot/documents'); // /var/www/documents
echo Piko::getAlias('@web/css/styles.css'); // /css/styles.css

Piko::setAlias('@lib', '/usr/local/share/lib');
echo Piko::getAlias('@lib/pdf/model.pdf'); // /usr/local/share/lib/pdf/model.pdf

```

<a name="container"></a>

## Container

[Piko::set()](../api/Piko.md#method_set) and [Piko::get()](../api/Piko.md#method_get) respectively store and retrieve mixed 
values in a global application registry.

Example using set() and get(): 

```php
use piko\Piko;

Piko::set('now', new \Datetime());
$now = Piko::get('now');
echo $now->format('Y-m-d');

```

<a name="component"></a>

## Component

Components are classes that inherited from [\piko\Component](../api/Component.md).

Components are instantiated with a key-value pair array where keys corresponds to its public properties. 
All Piko Framework classes are components.

Example of a component:

```php

class Connexion extends \piko\Component
{
    public $username = '';
    public $passord = '';
    
    public function connect()
    {
        echo $this->username . ' ' . $this->password;
    }
}

$con = new Connexion(['username' => 'adou', 'password' => 'zertez']);

$con->connect(); // adou zertez

```
<a name="events"></a>

### Events

Other interesting feature of components is they are event handlers. With components, It's possible to trigger 
and listen events. The [trigger](../api/Component#method_trigger) method is used to trigger an event and 
the [on](../api/Component#method_on) method to listen for some events. 


Example of event triggering in the Connexion component: 

```php
//...
    public function connect()
    {
        echo $this->username . ' ' . $this->password;
        $this->trigger('afterConnect');
    }
//...
```

Example of event listening with the Connexion component:

```php
$con = new Connexion(['username' => 'adou', 'password' => 'zertez']);

$con->on('afterConnect', function() {
    echo ' is connected!';
});

$con->connect(); // adou zertez is connected!

```

The [on](../api/Component#method_on) method listen events only for a single component instance.

The [when](../api/Component#method_when) static method can listen events for all component instances.

Example:

```php
Connexion::when('afterConnect', function() {
    echo ' is connected!';
});

$con = new Connexion(['username' => 'adou', 'password' => 'zertez']);

$con->connect(); // adou zertez is connected!

$con2 = new Connexion(['username' => 'yudo', 'password' => 'gsdg']);

$con2->connect(); // yudo gsdg is connected!

```

<a name="behaviors"></a>

### Behaviors

Another great component feature is that is possible to attach non-existing method during the code execution.
These methods are called behaviors.

To attach a behavior, use [attachBehavior](../api/Component#attachBehavior) method.

Example:

```php
$con = new Connexion(['username' => 'adou', 'password' => 'zertez']);

$con->attachBehavior('disconnect', function() {
    echo 'I am disconnected!';
});

$con->connect(); // adou zertez
$con->disconnect(); // I am disconnected!
```

### Components registered globally in application

Some components need to be retrieved globally in the application. They are application 
[singletons](https://en.wikipedia.org/wiki/Singleton_pattern).

These components are declared in the `components` section of the application [configuration](application.md#configuration).

Once declared, their instances can be accessed everywhere in the application using 
[Piko::get()](../api/Piko.md#method_get) method.

If the `components` section is empty in the configuration, the application will register by default two components : 
piko\View and piko\Router. To retrieve their instances, use `Piko::get('view')` and `Piko::get('router')`.

Note that these components are loaded lazily. They are instantiated the first time you access them by using 
[Piko::get()](../api/Piko.md#method_get) method.
 

