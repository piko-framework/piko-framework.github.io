---
layout: default
title: Models
parent: Modular application
nav_order: 4
---

# Models

The model is the part of the application that manages the data. It is the data layer.
In a MVC application, the model should be responsible for the following:

- Managing the data
- Ensuring that data is valid before it is saved
- Communicating with the database The model should never contain any logic for the presentation layer.

The model should never contain any HTML code.

The [Piko\ModelTrait](../../api/ModelTrait.md) can be used to represent a data structure (model's attributes)
that need to be validated and mass assigned. A typical usage is to represent form data inputs.

Model's attributes are declared as public properties in the inherited class.

Model's attributes can be mass assigned using [bind](../../api/ModelTrait.md#method_bind) method.

Model's attributes can be exported as array using [toArray](../../api/ModelTrait.md#method_toArray) method.

To check model validity, we can use the [isValid](../../api/ModelTrait.md#method_isValid) public method.
This method symply check if the `errors` model's property is empty.
The class using this trait has to implement the protected [validate](../../api/ModelTrait.md#method_validate) method
to fill the `errors` model's property in case of error.

Use case example of [\Piko\ModelTrait](../../api/ModelTrait.md) to represent a contact form:

Module structure:

```
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

    public $email = '';
    public $subject = '';
    public $message = '';

    protected function validate(): void
    {
        if (!filter_var($this->email, FILTER_VALIDATE_EMAIL)) {
            $this->setError('email', 'Email is invalid');
        }

        if (empty($this->subject)) {
            $this->setError('subject', 'Subject is required');
        }

        if (empty($this->message)) {
            $this->setError('message', 'Message is required');
        }
    }
}
```

*DefaultController.php*:

```php
namespace app\modules\site\controllers;

use app\modules\site\models\ContactForm;

class DefaultController extends \Piko\Controller
{
    public function contactAction()
    {
        $form = new ContactForm();

        if ($this->request->getMethod() == 'POST') {

            $post = $this->request->getParsedBody();
            $form->bind($post);

            if ($form->isValid()) {
                // Send an email, Save in database, etc.
            }
        }

        return $this->render('contact', [
            'form' => $form
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
<p><?= implode('<br>', $errors) ?></p>
<?php endif ?>

<form action="" method="post">
  <p>
    <input type="email"
           name="email"
           value="<?= $form->email ?>"
           placeholder="Email">
  </p>
  <p>
    <input type="text"
           name="subject"
           value="<?= $form->subject ?>"
           placeholder="Subject">
  </p>
  <p>
    <label for="message">Message</label><br>
    <textarea  name="message" id="message" rows="5">
    <?= $form->message ?>
    </textarea>
  </p>
  <p>
    <button type="submit" >Submit</button>
  </p>
</form>
```
