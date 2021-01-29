---
layout: default
title: Getting started
nav_order: 2
---

# Getting Started

To quickly test or start a new Piko based project, the recommended way is to use the [Piko project skeletton](https://github.com/piko-framework/piko-project).

## Piko project skeletton installation

If you don't have Composer installed on your system, you may install it by following the instructions
at [getcomposer.org](http://getcomposer.org/doc/00-intro.md#installation-nix).

Then install your project template using the following command:

```bash
composer create-project piko/project yourprojectname
```

### Run your app

Once the project installed (see above), you can run it using the PHP built-in web server :

```bash
cd yourprojectname && php -S localhost:8080 -t web
```

And you can see the result in your browser : [http://localhost:8080/](http://localhost:8080/)

## Hello world example

Once the project created (see above) create a new controller file in `modules/site/controllers` named `HelloController.php`.

and edit the file with this code :

```php
<?php
namespace app\modules\site\controllers;

class HelloController extends \piko\Controller
{
    public function worldAction()
    {
        return "Hello world!";
    }
}

```

Then open the URL : [http://localhost:8080/site/hello/world](http://localhost:8080/site/hello/world)

You should see `Hello world!' in your browser.

The URI /site/hello/world corresponds to the module `site`, the controller `hello` and the action `world`.

If you need to customize the URI edit the file config.php and add a new route :

```php
<?php
return [
    // ...
    'components' => [
        'router' => [
            'class' => 'piko\Router',
            'routes' => [
                //...
                '^/hello-world$' => 'site/hello/world',
                '^/(\w+)/(\w+)/(\w+)' => '$1/$2/$3'
            ],
        ],
        // ...
    ]
];
```

So you will obtain the same result than above with this URL : [http://localhost:8080/hello-world](http://localhost:8080/hello-world)

------

[How application works](application.md){: .btn .btn-orange }
