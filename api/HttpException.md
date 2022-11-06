---
layout: default
title: HttpException
parent: API
---



# \Piko\HttpException

HttpException convert exception code to http status header.





**see**  \Exception






## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |


-----



## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(int  $code = 404, string  $message = '', \Throwable  $previous = null): mixed
```

Constructor set http header with response code and message if code is given



#### Parameters
**$code**  (default: 404):
The exception code (should be an HTTP status code, eg. 404)

**$message**  (default: ''):
The exception message.

**$previous**  (default: null):
A previous exception.






#### Return:
**mixed**


