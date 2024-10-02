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


## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Defining Models](#defining-models)
4. [Usage Examples](#usage-examples)
5. [DbRecord Events](#dbrecord-events)
   - [beforeSave Event](#beforesave-event)
   - [beforeDelete Event](#beforedelete-event)
   - [afterSave Event](#aftersave-event)
   - [afterDelete Event](#afterdelete-event)

## installation

```bash
composer require piko/db-record
```

This command will install the [DbRecord](../api/DbRecord.md) components.

## Configuration

The component requires a [PDO](https://www.php.net/manual/fr/book.pdo.php) connection.
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

Nonetheless, the component can function independently outside of a Piko application.
In such cases, you can establish a PDO connection as follows:

```php
$db = new PDO('mysql:host=localhost;dbname=yourdb', 'dbpassword', 'dbuser');
```

## Defining Models

Suppose we have a table to store contacts in our database created with :

```sql
CREATE TABLE contact (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  `order` INTEGER
)
```

To represent the model entity of the contact table, declare a class `Contact` that inherits from
[Piko\DbRecord](../api/DbRecord.md).


Use the, [Piko\DbRecord\Attribute\Table](../api/Table.md),
and [Piko\DbRecord\Attribute\Column](../api/Column.md) classes to define your model:

### Using Attributes

```php
use Piko\DbRecord;
use Piko\DbRecord\Attribute\Table;
use Piko\DbRecord\Attribute\Column;

#[Table(name:'contact')]
class Contact extends DbRecord
{
    #[Column(primaryKey: true)]
    public ?int $id = null;

    #[Column]
    public $name = null;

    #[Column]
    public ?int $order = null;
}
```
### Using Properties

Alternatively set two properties `$tableName` and `$schema`:

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

## Usage Examples

Get a PDO connexion before to instanciate models.

Inside a Piko application:

```php
$db = $app->getComponent(PDO::class);
```

Outside a Piko application:

```php
$db = new PDO('mysql:host=localhost;dbname=yourdb', 'dbpassword', 'dbuser');
```

### Creating and Saving Entities

```php
$contact = new Contact($db);
$contact->name = 'Joe';
$contact->order = 1;
$contact->save();

echo $contact->id; // Outputs the generated ID for Joe
```

### Fetching Entities

```php
$st = $db->prepare('SELECT * FROM contact');
$st->execute();

// Returns an array of Contact instances
$rows = $st->fetchAll(PDO::FETCH_CLASS, 'Contact', [$db]);

print_r($rows);
```

### Updating Entities

```php
$contact = new Contact($db);
$contact->load(1); // Loads entity with id = 1
echo $contact->name; // Joe
$contact->name = 'John';
$contact->save();

$contact = new Contact($db);
$contact->load(1);
echo $contact->name; // John
```

### Deleting entities

```php
$contact = new Contact($db);
$contact->load(1);
$contact->delete();
```

## DbRecord Events

[Concept of events](concepts.md#events)

### beforeSave Event

Before saving an entity in the database, dbRecord check if the operation is possible by invoking the
[beforeSave](../api/DbRecord.md#method_beforeSave) method. This method also trigger a
[BeforeSaveEvent](../api/BeforeSaveEvent.md).

You can customize this behavior by overriding the `beforeSave` method or using an event listener:

#### Overriding beforeSave Method

```php
use Piko\DbRecord;

class Contact extends DbRecord
{
    protected function beforeSave(): bool
    {
        if (!$this->name) {
            return false;
        }

        return parent::beforeSave();
    }
}

```

#### Using an event listener

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

### beforeDelete Event

Interact with the `beforeDelete` event similarly to `beforeSave` event.
See [beforeDelete](../api/DbRecord.md#method_beforeDelete) method. This method also trigger a
[BeforeDeleteEvent](../api/BeforeDeleteEvent.md).


### afterSave Event

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

### afterDelete Event

Interact with `afterDelete` event similarly to `afterSave` event.
See [afterDelete](../api/DbRecord.md#method_afterDelete) method. This method also trigger an
[AfterDeleteEvent](../api/AfterDeleteEvent.md)..

