---
layout: default
title: Intro
nav_order: 1
---

# Piko Framework

Piko is a lightweight and flexible PHP micro framework that tries to Keep It Simple. The idea behind this framework is 
to have a very small footprint, easy to learn and easy to use.

Piko does not come with an ORM or database abstraction layer. You are free to choose any database abstraction layer 
or ORM you like.

Piko comes with a simple and lightweight template engine. You are free to use any template engine you like.

Actually, you may consider Piko as a kind of application microkernel that encourages the use of third-party 
packages to fit the needs.

Piko is licensed under the LGPL v3.0 license.

## Fast and Lightweight

Piko has been implemented with performances in mind. Requests are routed quickly using 
[Piko router](https://github.com/piko-framework/router), one of the fastest PHP router, and view rendering use 
PHP as template engine (This is what PHP was originally made for).

Its code has a small footprint (around 200kB once installed).

## Modular MVC application

Piko Modular application uses the well known [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) 
architectural pattern. Models manage data, Views display data and Controllers bind models to views.

MVC logic is packaged inside modules which compose the application.
This design encourages code re-usability and modularity.

## Enable features via composer packages:

- Modular MVC routing ([piko/framework](https://packagist.org/packages/piko/framework))
- Event handler, model helper, behaviors ([piko/core](https://packagist.org/packages/piko/core))
- A lightning fast router ([piko/router](https://packagist.org/packages/piko/router))
- An Active Record component ([piko/db-record](https://packagist.org/packages/piko/db-record))
- Internationalization ([piko/i18n](https://packagist.org/packages/piko/i18n))
- User management component for authentication and authorization ([piko/user](https://packagist.org/packages/piko/user))
- An assets management component ([piko/asset-bundle](https://packagist.org/packages/piko/asset-bundle))

## Installation via composer

```bash
composer require piko/framework
```

## Inspiration

Concepts used in Piko are inspired by [Yii2 framework](https://www.yiiframework.com/).

-----

[Getting started](getting-started.md){: .btn .btn-orange }
