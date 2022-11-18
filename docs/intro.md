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

Piko comes with a simple and lightweight template engine but you are free to use any template engine you like.

Piko is licensed under the LGPL v3.0 license.

## Fast and Lightweight

Piko has been implemented with performances in mind. Requests are routed quickly using
[Piko router](https://github.com/piko-framework/router), one of the fastest PHP router, and the view rendering engine use
PHP as template engine (This is what PHP was originally made for).

Its code has a small footprint (around 200kB once installed).

## Build application that fits your needs

- For a simple project : [FastApplication](fast-application.md)
- For a complex project : [ModularApplication](modular-application/index.md)

## Enable features via composer packages:
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
