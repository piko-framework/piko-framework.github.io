---
layout: default
title: Home
nav_order: 0
---

# Piko Framework

**A PHP micro Framework to build Web applications with a minimalist and essential implementation.**

## MVC

Piko uses the well known [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) architectural pattern. Models manage data, Views display data and Controllers bind models to views.

## Fast and Lightweight

Piko has been implemented with performances in mind. Requests are routed quickly and views use pure PHP. It requires no dependencies and its code has a small footprint (under 100kB once installed).

## Modular
MVC logic is packaged inside modules which compose the application. This design encourages code re-usability.


## Features:

- Modular MVC routing
- Database management (via PDO)
- Internationalization (i18n)
- User management (authentication, authorization)
- Assets management

## Installation via composer

```bash
composer require piko/framework
```

## Inspiration

The concepts used in Piko are inspired by [Yii2 framework](https://www.yiiframework.com/).

-----

[Getting started](docs/getting-started.md){: .btn .btn-orange }
