---
layout: default
title: Intro
nav_order: 0
---

<div style="text-align: center">
  <img src="logo.svg" alt="Piko Framework logo" style="width:355px">
  <h1 style="font-size: 50px">Piko Framework</h1>
  <h2 style="margin-bottom: 50px">
      A tiny PHP framework that keeps things simple, fast, and flexible
  </h2>
</div>

Piko is a lightweight and flexible PHP micro framework that aims to keep it simple. It is designed for developers who want the simplicity of plain PHP with the structure of a modern framework. Its implementation follows the KISS (Keep It Simple, Stupid) principle and focuses on a very small footprint, fast execution, and a straightforward, PSR‑compliant architecture.

With Piko, you start from a minimal core and then add only the features you need via small, focused Composer packages.

Piko is licensed under the LGPL v3.0 license.

## Why Piko?

- **Simple and focused** – Minimal abstractions, easy to understand, and close to native PHP.
- **Fast and lightweight** – Very small codebase (around 200 kB once installed) and low runtime overhead.
- **Modular by design** – Add features such as database access, internationalization, or user management only when you need them.
- **Standards‑based** – Uses PSR‑4 autoloading and interoperates with PSR‑7, PSR‑14, and PSR‑15 components.
- **Familiar concepts** – Inspired by the Yii 2 framework while remaining much smaller and easier to grasp.

## Fast and lightweight

Piko has been implemented with performance in mind. Requests are routed quickly using
[Piko Router](https://github.com/piko-framework/router), one of the fastest PHP routers, and the view rendering engine uses
PHP as its template engine (this is what PHP was originally made for).

Its code has a small footprint (around 200 kB once installed), which makes it suitable for small servers, containers, and microservices.

## When should you use Piko?

Piko is a good fit when you:

- Want to build **small to medium web applications or APIs**.
- Prefer a **microframework** over a large, full‑stack framework.
- Need **high performance** with minimal overhead.
- Value **explicitness and simplicity** over heavy abstractions.
- Plan to **compose your stack** from small libraries instead of relying on a monolithic solution.

For very large, highly integrated enterprise applications, a full‑stack framework such as Symfony or Laravel might be more appropriate. For everything else, Piko offers a lean and efficient alternative.

## Build applications that fit your needs

Choose the application style that matches your project:

- For a simple project: [FastApplication](fast-application.md) – define routes directly in code, ideal for small HTTP services.
- For a modular project: [ModularApplication](modular-application/index.md) – organize your code into modules with controllers, models, and views following the MVC pattern.

## Enable features via Composer packages

Start with the core, then add exactly what you need:

- Active Record component ([piko/db-record](https://packagist.org/packages/piko/db-record))
- Internationalization ([piko/i18n](https://packagist.org/packages/piko/i18n))
- User management for authentication and authorization ([piko/user](https://packagist.org/packages/piko/user))
- Asset management ([piko/asset-bundle](https://packagist.org/packages/piko/asset-bundle))

See [Concepts](concepts.md) for details about aliases, components, events, behaviors, and middleware.

## Installation via Composer

```bash
composer require piko/framework
```

## A minimal example

Below is a simple example that shows how to build a small HTTP application using `FastApplication`:

```php
<?php

use Piko\FastApplication;
use Psr\Http\Message\ServerRequestInterface;

require __DIR__ . '/vendor/autoload.php';

$app = new FastApplication();

// Define a route for the home page
$app->listen('GET', '/', function (ServerRequestInterface $request): string {
    return 'Hello, Piko!';
});

$app->run();
```

From here, you can add more routes, introduce middlewares, configure components, or move to a modular application structure as your project grows.

## Inspiration

The concepts used in Piko are inspired by the [Yii 2 framework](https://www.yiiframework.com/).

-----

[Getting started](docs/getting-started.md){: .btn .btn-orange }
