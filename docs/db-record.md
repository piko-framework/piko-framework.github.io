---
layout: default
title: DbRecord
nav_order: 7
---

# DbRecord

[DbRecord](../api/DbRecord.md) is a lightweight [active record](https://en.wikipedia.org/wiki/Active_record_pattern) 
implementation built on top of PDO.

An active record is an object that represents a database record. It can be used to create / update / delete entities 
in db tables without writing any sql requests.

Moreover, inherited class represents a model entity where instance of it can be used in a controller 
(See [Controllers](application.md#controllers)) or in a view script (See [Views](application.md#views)).

## installation

```bash
composer require piko/db-record
```

This command will install the [DbRecord](../api/DbRecord.md) components.

The component needs a [PDO](https://www.php.net/manual/fr/book.pdo.php) connexion. 
Ensure that a PDO component is registered in the application [configuration](application.md#configuration).

Example of Mysql configuration:

```php
return [
    //...
    'components' => [
        PDO::class => [
            'construct' => [
                'mysql:dbname=' . getenv('MYSQL_DB') . ';host=' . getenv('MYSQL_HOST'),
                getenv('MYSQL_USER'),
                getenv('MYSQL_PASSWORD'),
            ]
        ],
    ],
];

```

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
use Piko\DbRecord;

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
$db = $app->getComponent(PDO::class);

// Create entity
$contact = new Contact($db);
$contact->name = 'Joe';
$contact->order = 1;
$contact->save();

echo $contact->id; // 1

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

[Concept of events](concepts.md#events)

### beforeSave

Before saving an entity in the database, dbRecord check if the operation is possible by invoking the 
[beforeSave](../api/DbRecord.md#method_beforeSave) method. This method also trigger a 
[BeforeSaveEvent](../api/BeforeSaveEvent.md).

It is possible to customize this behavior in two ways:

Override beforeSave method in the inherited class:

```php
use Piko\DbRecord;

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

Using an event listener:

```php
use Piko\DbRecord\Event\BeforeSaveEvent;
//...
$contact = new Contact($db);
$contact->on(BeforeSaveEvent::class, function(BeforeSaveEvent $event) {
    if (!$event->record->name) {
        return false;
    }
});
```

### beforeDelete

It's possible to interact with the `beforeDelete` event in the same way than the `beforeSave` event.
See [beforeDelete](../api/DbRecord.md#method_beforeDelete) method. This method also trigger a 
[BeforeDeleteEvent](../api/BeforeDeleteEvent.md).


### afterSave

After saving an entity in the database, dbRecord invokes the [afterSave](../api/DbRecord.md#method_afterSave) method. 
This method also trigger an [AfterSaveEvent](../api/AfterSaveEvent.md)..

It is possible to customize this behavior in two ways:

Override afterSave method in the inherited class:

```php
use Piko\DbRecord;

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
use Piko\DbRecord\Event\AfterSaveEvent;
// ...
$contact = new Contact($db);
$contact->on(AfterSaveEvent::class, function(AfterSaveEvent $event) {
    // Do something particular
});
```

### afterDelete

It's possible to interact with the `afterDelete` event in the same way than the `afterSave` event.
See [afterDelete](../api/DbRecord.md#method_afterDelete) method. This method also trigger an 
[AfterDeleteEvent](../api/AfterDeleteEvent.md)..

