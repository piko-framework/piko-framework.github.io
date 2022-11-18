---
layout: default
title: ViewInterface
parent: API
---



# \Piko\View\ViewInterface

View interface.







## Methods summary

| Name | Description |
|------|-------------|
| public [`render`](#method_render) | Render the view.  |

-----


## Methods




<a name="method_render"></a>
### public **render()**: string

```php
public  render(string  $file, array  $model = []): string
```

Render the view.



#### Parameters
**$file** :
The view file name.

**$model**  (default: []):
An array of data (name-value pairs) to transmit to the view.






#### Return:
**string**
The view's output.

