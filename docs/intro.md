---
layout: default
title: Intro
nav_order: 1
---

# Piko Framework

Piko Framework is a PHP micro framework with a minimal and essential abstraction.
The idea behind this framework is to offer a light but powerfull foundation to build a Web application.

## Fast and Lightweight

Piko has been implemented with performances in mind. Requests are routed quickly using 
[Piko router](https://github.com/piko-framework/router), one of the fastest php router, and view rendering use 
pure PHP scripts.

It requires no dependencies and its code has a small footprint (under 200kB once installed).

## MVC

Piko uses the well known [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) 
architectural pattern. Models manage data, Views display data and Controllers bind models to views.

## Modular
MVC logic is packaged inside modules which compose the application. This design encourages code re-usability.

## Features:

- Modular MVC routing
- Event handler
- Database management (via PDO)
- Internationalization (i18n)
- User management (authentication, authorization)
- Assets management

## Installation via composer

```bash
composer require piko/framework
```

## Inspiration

Concepts used in Piko are inspired by [Yii2 framework](https://www.yiiframework.com/).

-----

[Getting started](getting-started.md){: .btn .btn-orange }
