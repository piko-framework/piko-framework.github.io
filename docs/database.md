---
layout: default
title: Database
nav_order: 7
---

# Database management

Piko Framework offers a lightweight solution to work with sql databases.
This can be installed as a separate package in your project:

```bash
composer require piko/db
```

This package will install the [Db](../api/Db.md) and the [DbRecord](../api/DbRecord.md) [components](concepts.md#component).

The [Db](../api/Db.md) component is a proxy to [PDO](https://www.php.net/manual/fr/book.pdo.php). 
The main difference resides in its constructor which uses an array of configuration.

The db component can be declared in the application [configuration](application.md#configuration).

Example of sqlite configuration:

```php
return [
    //...
    'components' => [
        'db' => [
            'class' => 'piko\Db',
            'dsn' => 'sqlite:' . __DIR__ . '/mydb.sqlite',
        ],
    ],
];

```

Example of mysql configuration:

```php
return [
    //...
    'components' => [
        'db' => [
            'class' => 'piko\Db',
            'dsn' => 'mysql:host=' . $_ENV['DB_HOST'] .';dbname=' . $_ENV['DB_NAME'],
            'username' => $_ENV['DB_USERNAME'],
            'password' => $_ENV['DB_PASSWORD'],
        ],
    ],
];

```

Once the db component installed an well configured, it can be used as a PDO instance in the application:

```php
use piko\Piko;

$db = Piko::get('db');
$db->exec("INSERT INTO customers SET name = 'Joe'");

```

## DbRecord

[DbRecord](../api/DbRecord.md) is an implementation of the
[active record pattern](https://en.wikipedia.org/wiki/Active_record_pattern).

It can be used to create / update / delete entities in db tables without writing sql requests. 
Moreover, inherited class represents a model entity where instance of it can be consumed in a controller 
(See [Controllers](application.md#controllers)) or in a view script (See [Views](application.md#views)).

Suppose we have a table in our database created with :

```sql
CREATE TABLE contact (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  `order` INTEGER
)
```

To represent the model entity of the contact table, we have to declare a class `Contact` that inherit from 
[DbRecord](../api/DbRecord.md).
In this declaration, we have to set two properties: `$tableName` which is the entity's table name and `$schema` which 
is the entity's schema as declared above:

```php
use piko\DbRecord;

class Contact extends DbRecord
{
    protected $tableName = 'contact';

    protected $schema = [
        'id'        => self::TYPE_INT,
        'name'      => self::TYPE_STRING,
        'order'     => self::TYPE_INT
    ];
}
```

Contact class usage:

```php
use piko\Piko;

// Create entity
$contact = new Contact();
$contact->name = 'Joe';
$contact->order = 1;
$contact->save();

echo $contact->id; // 1

$db = Piko::get('db');
$st = $db->prepare('SELECT * FROM contact');
$st->execute();

// Returns an array of Contact instances
$rows = $st->fetchAll(PDO::FETCH_CLASS, 'Contact'); 

print_r($rows);

// Update entity
$contact = new Contact(1); // Loads entity with id = 1
echo $contact->name; // Joe
$contact->name = 'John';
$contact->save();

$contact = new Contact(1);
echo $contact->name; // John

// Delete entity
$contact->delete();

print_r($st->fetchAll());
```

## DbRecord events

### beforeSave

Before saving an entity in the database, dbRecord check if the operation is possible by invoking the 
[beforeSave](../api/Db.md#method_beforeSave) method. This method also trigger a 'beforeSave' [event](concepts.md#events).

It is possible to customize this behavior in two ways:

Override beforeSave method in the inherited class:

```php
use piko\DbRecord;

class Contact extends DbRecord
{
    //...

    protected function beforeSave(): bool
    {
        if (!$this->name) {
            return false;
        }

        return parent::beforeSave();
    }
}

```

Using a callback listening the event:

```php
$contact = new Contact();
$contact->on('beforeSave', function($contact) {
    if (!$contact->name) {
        return false;
    }
});
```

### beforeDelete

It's possible to interact with the `beforeDelete` event in the same way than the `beforeSave` event.
See [beforeDelete](../api/Db.md#method_beforeDelete) method.


### afterSave

After saving an entity in the database, dbRecord invokes the [afterSave](../api/Db.md#method_afterSave) method. 
This method also trigger a 'afterSave' [event](concepts.md#events).

It is possible to customize this behavior in two ways:

Override afterSave method in the inherited class:

```php
use piko\DbRecord;

class Contact extends DbRecord
{
    //...

    protected function afterSave(): void
    {
        // Do something particular
        return parent::afterSave();
    }
}

```

Using a callback listening the event:

```php
$contact = new Contact();
$contact->on('afterSave', function($contact) {
    // Do something particular
});
```

### afterDelete

It's possible to interact with the `afterDelete` event in the same way than the `afterSave` event.
See [afterDelete](../api/Db.md#method_afterDelete) method.

