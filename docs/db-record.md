---
layout: default
title: DbRecord
nav_order: 7
---

# DbRecord

[DbRecord](../api/DbRecord.md) is a lightweight [Active Record](https://en.wikipedia.org/wiki/Active_record_pattern)
implementation built on top of PDO.

An Active Record is an object that represents a row in a database table. It can be used to
create, update and delete entities without writing SQL for each operation.

The concrete class you create (e.g. `Contact`) represents a model entity. Instances of this class
can be used directly in controllers (see [Controllers](application.md#controllers)) and view scripts
(see [Views](application.md#views)).


## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Defining Models](#defining-models)
   - [Using PHP Attributes](#using-php-attributes)
   - [Using Schema Properties](#using-schema-properties)
4. [Usage Examples](#usage-examples)
   - [Creating and Saving Entities](#creating-and-saving-entities)
   - [Fetching Entities](#fetching-entities)
   - [Updating Entities](#updating-entities)
   - [Deleting Entities](#deleting-entities)
5. [DbRecord Events](#dbrecord-events)
   - [beforeSave Event](#beforesave-event)
   - [beforeDelete Event](#beforedelete-event)
   - [afterSave Event](#aftersave-event)
   - [afterDelete Event](#afterdelete-event)

## Installation

```bash
composer require piko/db-record
```

This command installs the [DbRecord](../api/DbRecord.md) component.

## Configuration

The component requires a [PDO](https://www.php.net/manual/en/book.pdo.php) connection.
When used inside a Piko application, ensure that a PDO component is registered in the
application [configuration](application.md#configuration).

Example of MySQL configuration in a Piko application:

```php
return [
    // ...
    'components' => [
        PDO::class => [
            'construct' => [
                'mysql:dbname=' . getenv('MYSQL_DB') . ';host=' . getenv('MYSQL_HOST'),
                getenv('MYSQL_USER'),
                getenv('MYSQL_PASSWORD'),
            ],
        ],
    ],
];
```

DbRecord can also be used independently, outside of a Piko application. In that case,
establish the PDO connection yourself and pass it to your record instances:

```php
$db = new PDO('mysql:host=localhost;dbname=yourdb', 'dbuser', 'dbpassword');
```

## Defining Models

Assume we have a table to store contacts:

```sql
CREATE TABLE contact (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  `order` INTEGER
);
```

To represent the `contact` table, declare a `Contact` class that extends
[`Piko\DbRecord`](../api/DbRecord.md).

DbRecord supports two ways of defining the mapping:

- Using PHP 8 attributes (recommended)
- Using the legacy `$tableName` and `$schema` properties

### Using PHP Attributes

Use the [`Piko\DbRecord\Attribute\Table`](../api/Table.md) and
[`Piko\DbRecord\Attribute\Column`](../api/Column.md) attributes to define your model.

```php
use PDO;
use Piko\DbRecord;
use Piko\DbRecord\Attribute\Table;
use Piko\DbRecord\Attribute\Column;

#[Table(name: 'contact')]
class Contact extends DbRecord
{
    #[Column(primaryKey: true)]
    public ?int $id = null;

    #[Column]
    public string $name;

    #[Column]
    public ?int $order = null;
}
```

Key points:

- `#[Table]` defines the database table name.
- Each property marked with `#[Column]` becomes a column in the schema.
- If `primaryKey: true` is set, that column is used as the primary key.
- The property PHP type (`int`, `string`, `bool`, `float`) is used to infer the PDO type.

> Note: When using attributes, the public properties hold the values directly.
> DbRecord still builds an internal schema from the attributes to correctly bind
> values to PDO statements.

You can also use a different column name than the property name:

```php
#[Table(name: 'contact')]
class Contact extends DbRecord
{
    #[Column(primaryKey: true)]
    public ?int $id = null;

    #[Column(name: 'full_name')]
    public string $name;
}
```

In this case, the `name` property maps to the `full_name` column in the database.

### Using Schema Properties

Alternatively, you can define the mapping via two protected properties: `$tableName`
and `$schema`.

```php
use PDO;
use Piko\DbRecord;

class Contact extends DbRecord
{
    protected string $tableName = 'contact';

    protected array $schema = [
        'id'    => self::TYPE_INT,
        'name'  => self::TYPE_STRING,
        'order' => self::TYPE_INT,
    ];

    // Optional: override the primary key name if it is not "id"
    // protected string $primaryKey = 'contact_id';
}
```

In this mode:

- `$tableName` is the database table name.
- `$schema` maps column names to PDO parameter types using the
  `DbRecord::TYPE_*` constants (`TYPE_INT`, `TYPE_STRING`, `TYPE_BOOL`).
- You **do not** declare public properties for the columns. Accessing `$contact->name`
  uses DbRecord's magic accessors, which validate and cast the values according
  to the schema.

## Usage Examples

Before instantiating a model, you need a PDO connection.

Inside a Piko application:

```php
/** @var Piko\Application $app */
$db = $app->getComponent(PDO::class);
```

Outside a Piko application:

```php
$db = new PDO('mysql:host=localhost;dbname=yourdb', 'dbuser', 'dbpassword');
```

### Creating and Saving Entities

```php
$contact = new Contact($db);
$contact->name = 'Joe';
$contact->order = 1;
$contact->save();

echo $contact->id; // Generated ID for Joe
```

When `save()` is called on a record with an empty primary key, DbRecord performs
an `INSERT` and then updates the primary key property with the last inserted ID.

### Fetching Entities

You can load a single entity by primary key using `load()`:

```php
$contact = new Contact($db);
$contact->load(1);

echo $contact->name;
```

For custom queries, use PDO directly and hydrate results into `Contact` instances:

```php
$st = $db->prepare('SELECT * FROM contact WHERE `order` > :minOrder');
$st->execute([':minOrder' => 0]);

// Returns an array of Contact instances
$rows = $st->fetchAll(PDO::FETCH_CLASS, Contact::class, [$db]);

print_r($rows);
```

DbRecord automatically quotes identifiers (table and column names) based on the
PDO driver (MySQL, SQLite, PostgreSQL, SQL Server, etc.).

### Updating Entities

```php
$contact = new Contact($db);
$contact->load(1); // Loads entity with id = 1

echo $contact->name; // Joe

$contact->name = 'John';
$contact->save(); // Executes an UPDATE

$reloaded = new Contact($db);
$reloaded->load(1);
echo $reloaded->name; // John
```

When `save()` is called on a record whose primary key is already set, DbRecord
performs an `UPDATE` instead of an `INSERT`.

### Deleting Entities

```php
$contact = new Contact($db);
$contact->load(1);
$contact->delete();
```

`delete()` will throw a `RuntimeException` if the primary key is empty (i.e. the
record has not been loaded or saved).

### Instantiating Models in Controllers

When your controller extends `Piko\Controller`, you can use the `create()` factory
method to instantiate DbRecord models. Constructor dependencies are resolved from
application components.

For a DbRecord subclass like `Contact` with a `__construct(PDO $db)` constructor,
and with `PDO::class` registered as a component, you can do:

```php
use PDO;
use Piko\Controller;
use Psr\Http\Message\ResponseInterface;
use App\Model\Contact; // Adjust the namespace to your application

class ContactController extends Controller
{
    public function createAction(): ResponseInterface
    {
        /** @var Contact $contact */
        $contact = $this->create(Contact::class);

        $contact->name = 'Joe';
        $contact->order = 1;
        $contact->save();

        return $this->redirect($this->getUrl('contact/index'));
    }
}
```

Here, `Controller::create()` delegates to `Module::createObject()`, which
inspects the constructor of `Contact` and injects the `PDO` instance from the
application components automatically.

## DbRecord Events

See the [concept of events](concepts.md#events) for general information about the
Piko event system.

DbRecord emits events around save and delete operations. You can customize
behavior either by overriding the corresponding `protected` methods or by
registering listeners with `on()`.

### beforeSave Event

Before saving an entity, DbRecord calls the
[`beforeSave`](../api/DbRecord.md#method_beforesave) method. This method also
triggers a [`BeforeSaveEvent`](../api/BeforeSaveEvent.md).

```php
protected function beforeSave(bool $insert): bool
```

- `$insert` is `true` when `save()` is about to perform an `INSERT`,
  and `false` for an `UPDATE`.
- Returning `false` from `beforeSave()` cancels the save operation.

You can customize this behavior by overriding the method:

```php
use Piko\DbRecord;

class Contact extends DbRecord
{
    protected function beforeSave(bool $insert): bool
    {
        if (!$this->name) {
            // Cancel save if name is empty
            return false;
        }

        return parent::beforeSave($insert);
    }
}
```

Or by using an event listener:

```php
use Piko\DbRecord\Event\BeforeSaveEvent;

$contact = new Contact($db);

$contact->on(BeforeSaveEvent::class, function (BeforeSaveEvent $event): void {
    if (!$event->record->name) {
        // Invalidate the event, which cancels the save
        $event->isValid = false;
    }
});
```

### beforeDelete Event

Before deleting an entity, DbRecord calls the
[`beforeDelete`](../api/DbRecord.md#method_beforedelete) method. This method
also triggers a [`BeforeDeleteEvent`](../api/BeforeDeleteEvent.md).

```php
protected function beforeDelete(): bool
```

- Returning `false` from `beforeDelete()` cancels the delete operation.

You can override the method:

```php
use Piko\DbRecord;

class Contact extends DbRecord
{
    protected function beforeDelete(): bool
    {
        // Prevent deletion of some protected records
        if ($this->id === 1) {
            return false;
        }

        return parent::beforeDelete();
    }
}
```

Or attach a listener:

```php
use Piko\DbRecord\Event\BeforeDeleteEvent;

$contact = new Contact($db);

$contact->on(BeforeDeleteEvent::class, function (BeforeDeleteEvent $event): void {
    if ($event->record->id === 1) {
        $event->isValid = false;
    }
});
```

### afterSave Event

After saving an entity, DbRecord calls the
[`afterSave`](../api/DbRecord.md#method_aftersave) method and triggers an
[`AfterSaveEvent`](../api/AfterSaveEvent.md).

```php
protected function afterSave(): void
```

Use this to perform side-effects such as logging, cache invalidation, etc.
Overriding `afterSave()` does **not** affect whether the save succeeds.

Override the method:

```php
use Piko\DbRecord;

class Contact extends DbRecord
{
    protected function afterSave(): void
    {
        // Custom logic after save
        // ...

        parent::afterSave();
    }
}
```

Or listen to the event:

```php
use Piko\DbRecord\Event\AfterSaveEvent;

$contact = new Contact($db);

$contact->on(AfterSaveEvent::class, function (AfterSaveEvent $event): void {
    // Custom logic after save
});
```

### afterDelete Event

After deleting an entity, DbRecord calls the
[`afterDelete`](../api/DbRecord.md#method_afterdelete) method and triggers an
[`AfterDeleteEvent`](../api/AfterDeleteEvent.md).

```php
protected function afterDelete(): void
```

Override the method or listen to the event in the same way as for `afterSave()`:

```php
use Piko\DbRecord;
use Piko\DbRecord\Event\AfterDeleteEvent;

class Contact extends DbRecord
{
    protected function afterDelete(): void
    {
        // Custom logic after delete
        // ...

        parent::afterDelete();
    }
}

$contact = new Contact($db);

$contact->on(AfterDeleteEvent::class, function (AfterDeleteEvent $event): void {
    // Custom logic after delete
});
```
----

## Summary

DbRecord provides a small, focused Active Record implementation on top of PDO:

- You define models by extending `Piko\DbRecord`, either via PHP attributes
  (`#[Table]`, `#[Column]`) or via the legacy `$tableName` / `$schema` mapping.
- Records are instantiated with a `PDO` instance, which can be injected
  manually or resolved automatically from application components when using
  `Controller::create()`.
- CRUD operations are exposed through a simple API: `load()`, `save()` and
  `delete()`, with automatic handling of INSERT vs UPDATE and primary key
  assignment.
- Around save and delete operations, DbRecord emits events and calls
  overridable hooks (`beforeSave`, `afterSave`, `beforeDelete`, `afterDelete`),
  allowing you to enforce validation rules, veto operations or run side effects
  such as logging or cache invalidation.

Together, these features make DbRecord a lightweight option when you need
structured, testable database access without the complexity of a full ORM.
