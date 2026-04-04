---
layout: default
title: Models
parent: Modular application
nav_order: 4
---

# Models

A model represents the data layer of a Piko application. It should focus on:

- storing and manipulating data
- validating input before persistence
- communicating with the database or other storage layers

> A model should not contain presentation logic or HTML output.

Piko provides [Piko\ModelTrait](../../api/ModelTrait.md) for lightweight data models, such as form objects or simple domain records. The trait exposes the public properties declared on the class as model attributes and provides helpers to:

- mass assign attributes with [bind](../../api/ModelTrait.md#method_bind)
- export attributes with [toArray](../../api/ModelTrait.md#method_toArray)
- validate the model with [isValid](../../api/ModelTrait.md#method_isValid)
- collect validation errors with [getErrors](../../api/ModelTrait.md#method_getErrors)

## How it works

### Model attributes

Model attributes are declared as public properties on the class using the trait.
Only public properties declared on the current class are treated as attributes.
Inherited public properties are ignored by the trait.

### Mass assignment

Use [bind](../../api/ModelTrait.md#method_bind) to populate a model from an array of name/value pairs.
Unknown keys are ignored.

When the target property already has a scalar value, `bind()` casts incoming data to the same scalar type using PHP casting rules:

- `int`
- `string`
- `bool`
- `float`

### Exporting data

Use [toArray](../../api/ModelTrait.md#method_toArray) to export the current attribute values as an associative array.

### Validation

To validate a model, override the protected [validate](../../api/ModelTrait.md#method_validate) method and register errors with [setError](../../api/ModelTrait.md#method_setError).

`isValid()` calls `validate()` and returns `true` only when the internal error list is empty.
The trait does not clear previous errors automatically, so a model instance that has already collected errors will remain invalid until you create a new instance.

## Basic usage

```php
<?php

namespace app\modules\site\models;

use Piko\ModelTrait;

class UserForm
{
    use ModelTrait;

    public string $firstName = '';
    public string $lastName = '';
}

$form = new UserForm();
$form->bind([
    'firstName' => 'John',
    'lastName' => 'Lennon',
    'role' => 'admin', // ignored because there is no matching public property
]);

$data = $form->toArray();
// [
//     'firstName' => 'John',
//     'lastName' => 'Lennon',
// ]
```

## Example: contact form model

A typical use case is a contact form model that receives user input, validates it, and exposes errors to the view.

Module structure:

```text
site
    controllers
        DefaultController.php
    models
        ContactForm.php
    views
        default
            contact.php
```

*ContactForm.php*:

```php
<?php

namespace app\modules\site\models;

use Piko\ModelTrait;

class ContactForm
{
    use ModelTrait;

    public string $email = '';
    public string $subject = '';
    public string $message = '';

    protected function validate(): void
    {
        if (!filter_var($this->email, FILTER_VALIDATE_EMAIL)) {
            $this->setError('email', 'Email is invalid');
        }

        if ($this->subject === '') {
            $this->setError('subject', 'Subject is required');
        }

        if ($this->message === '') {
            $this->setError('message', 'Message is required');
        }
    }
}
```

*DefaultController.php*:

```php
<?php

namespace app\modules\site\controllers;

use app\modules\site\models\ContactForm;

class DefaultController extends \Piko\Controller
{
    public function contactAction()
    {
        $form = new ContactForm();

        if ($this->request->getMethod() === 'POST') {
            $post = $this->request->getParsedBody();
            $form->bind(is_array($post) ? $post : []);

            if ($form->isValid()) {
                // Send an email, save the data in the database, etc.
            }
        }

        return $this->render('contact', [
            'form' => $form,
        ]);
    }
}
```

*contact.php*:

```php
<?php
/**
 * @var $this Piko\View
 * @var $form app\modules\site\models\ContactForm
 */

$errors = $form->getErrors();
?>

<?php if ($errors): ?>
    <ul>
        <?php foreach ($errors as $field => $error): ?>
            <li><?= $this->escape($field) ?>: <?= $this->escape($error) ?></li>
        <?php endforeach; ?>
    </ul>
<?php endif; ?>

<form action="" method="post">
    <p>
        <label for="email">Email</label><br>
        <input type="email"
               id="email"
               name="email"
               value="<?= $this->escape($form->email) ?>"
               placeholder="Email">
    </p>

    <p>
        <label for="subject">Subject</label><br>
        <input type="text"
               id="subject"
               name="subject"
               value="<?= $this->escape($form->subject) ?>"
               placeholder="Subject">
    </p>

    <p>
        <label for="message">Message</label><br>
        <textarea name="message" id="message" rows="5"><?= $this->escape($form->message) ?></textarea>
    </p>

    <p>
        <button type="submit">Submit</button>
    </p>
</form>
```

## Working with database persistence using Piko\DbRecord

When a model needs to represent and persist a database row, extend [Piko\DbRecord](../db-record.md) instead of using `ModelTrait` alone.
`DbRecord` is an Active Record implementation built on top of PDO. It handles table mapping, record loading, saving, and deletion.

`DbRecord` also uses `ModelTrait`, so you can still validate data with `isValid()` and expose validation errors with `getErrors()`.
However, `save()` does not validate automatically; validate the record first or hook into the `beforeSave` event if you need to enforce rules.

You can map a table either with PHP 8 attributes or with the protected `$tableName` and `$schema` properties; see the dedicated [DbRecord documentation](../db-record.md) for both approaches.

Below is a minimal record definition using PHP 8 attributes:

```php
<?php

namespace app\modules\site\models;

use Piko\DbRecord;
use Piko\DbRecord\Attribute\Table;
use Piko\DbRecord\Attribute\Column;

#[Table(name: 'contact')]
class Contact extends DbRecord
{
    #[Column(primaryKey: true)]
    public ?int $id = null;

    #[Column]
    public ?string $name = null;

    #[Column]
    public ?string $email = null;
}
```

Because `DbRecord` requires a `PDO` instance in its constructor, create it through the controller helper so dependencies are resolved automatically:

```php
<?php

namespace app\modules\site\controllers;

use app\modules\site\models\Contact;

class DefaultController extends \Piko\Controller
{
    public function displayAction(int $id)
    {
        /** @var Contact $contact */
        $contact = $this->create(Contact::class);
        $contact->load($id);

        return $this->render('display', [
            'contact' => $contact,
        ]);
    }
}
```

Common persistence operations are:

- `load($id)` to fetch a row by primary key. It throws a `RuntimeException` if the row cannot be found.
- `save()` to insert or update the record
- `delete()` to remove the record

See the dedicated [DbRecord documentation](../db-record.md) for installation, configuration, and event hooks.

---

## Practical notes

- Use public properties for all fields you want to bind and export.
- Keep validation rules in `validate()` and use `setError()` to attach field-specific messages.
- `toArray()` exports only public model attributes; validation errors are available separately through [getErrors](../../api/ModelTrait.md#method_getErrors).
- Escape model values in views before rendering them in HTML.
