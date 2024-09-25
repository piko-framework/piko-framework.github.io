---
layout: default
title: View
parent: API
---



# \Piko\View

Base application view.







## Constants summary

| Name | Description |
|------|-------------|
| public [`POS_END`](#constant_POS_END) | End of body position.  |
| public [`POS_HEAD`](#constant_POS_HEAD) | Head position.  |

## Properties summary

| Name | Description |
|------|-------------|
| public [`$charset`](#property_charset) | The charset encoding used in the view.  |
| public [`$css`](#property_css) | The registered CSS code blocks.  |
| public [`$cssFiles`](#property_cssFiles) | The registered CSS files.  |
| public [`$endBody`](#property_endBody) | Parts of the end of the body.  |
| public [`$extension`](#property_extension) | View filename extension  |
| public [`$head`](#property_head) | Parts of the head.  |
| public [`$js`](#property_js) | The registered JS code blocks  |
| public [`$jsFiles`](#property_jsFiles) | The registered JS files.  |
| public [`$params`](#property_params) | View parameters.  |
| public [`$paths`](#property_paths) | Directories where to find view files.  |
| public [`$themeMap`](#property_themeMap) | Theme map configuration. A key paired array where ... |
| public [`$title`](#property_title) | The page title  |

## Inherited Properties

| Name | Description |
|------|-------------|
| public [`$behaviors`](BehaviorTrait.md#property_behaviors) | Behaviors container.  |
| protected [`$eventDispatcher`](EventHandlerTrait.md#property_eventDispatcher) |   |
| protected [`$listenerProvider`](EventHandlerTrait.md#property_listenerProvider) |   |

## Methods summary

| Name | Description |
|------|-------------|
| public [`__construct`](#method___construct) | Constructor |
| public [`escape`](#method_escape) | Escape HTML special characters.  |
| public [`registerCSS`](#method_registerCSS) | Register css code.  |
| public [`registerCSSFile`](#method_registerCSSFile) | Register a stylesheet url.  |
| public [`registerJs`](#method_registerJs) | Register a script.  |
| public [`registerJsFile`](#method_registerJsFile) | Register a script url.  |
| public [`render`](#method_render) | Render the view.  |
| protected [`applyTheme`](#method_applyTheme) | Try to find an override of the file in a theme.  |
| protected [`endBody`](#method_endBody) | Assemble html in the end of the body position.  |
| protected [`findFile`](#method_findFile) | Retrieve a view file.  |
| protected [`head`](#method_head) | Assemble html in the head position.  |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`__call`](/BehaviorTrait.md#method___call) | Magic method to call a behavior.  |
| public [`attachBehavior`](/BehaviorTrait.md#method_attachBehavior) | Attach a behavior to the class instance.  |
| public [`detachBehavior`](/BehaviorTrait.md#method_detachBehavior) | Detach a behavior.  |
| public [`on`](/EventHandlerTrait.md#method_on) | Registers an event listener.  |
| public [`trigger`](/EventHandlerTrait.md#method_trigger) | Trigger an event that may be listen by event liste... |

-----

<a name="constant_POS_END"></a>
### public **$POS_END**
End of body position.





<a name="constant_POS_HEAD"></a>
### public **$POS_HEAD**
Head position.





-----

## Properties


<a name="property_charset"></a>
### public **$charset** : string
The charset encoding used in the view.






<a name="property_css"></a>
### public **$css** : string[]
The registered CSS code blocks.




**see**  \Piko\View::registerCss()



<a name="property_cssFiles"></a>
### public **$cssFiles** : string[]
The registered CSS files.




**see**  \Piko\View::registerCssFile()



<a name="property_endBody"></a>
### public **$endBody** : string[]
Parts of the end of the body.






<a name="property_extension"></a>
### public **$extension** : string
View filename extension






<a name="property_head"></a>
### public **$head** : string[]
Parts of the head.






<a name="property_js"></a>
### public **$js** : string[][]
The registered JS code blocks




**see**  \Piko\View::registerJs()



<a name="property_jsFiles"></a>
### public **$jsFiles** : string[][]
The registered JS files.




**see**  \Piko\View::registerJsFile()



<a name="property_params"></a>
### public **$params** : array
View parameters.






<a name="property_paths"></a>
### public **$paths** : string[]
Directories where to find view files.






<a name="property_themeMap"></a>
### public **$themeMap** : array&lt;string,string|string[]&gt;
Theme map configuration.
A key paired array where each key represents
a path to override and the value, the mapped path. The value could be either a string
or an array of path and in this case, it may be possibe to use child themes.
Configuration example :
```
...
'view' => [
    'class' => 'piko\View',
    'themeMap' => [
        '@app/modules/site/views' => [
            '@app/themes/child-theme',
            '@app/themes/parent-theme',
        ],
        '@app/modules/admin/views' => '@app/themes/piko/admin',
    ],
],
```





<a name="property_title"></a>
### public **$title** : string
The page title





-----

## Methods




<a name="method___construct"></a>
### public **__construct()**: mixed

```php
public  __construct(array&lt;string,mixed&gt;  $config = []): mixed
```




#### Parameters
**$config**  (default: []):







#### Return:
**mixed**


-----



<a name="method_escape"></a>
### public **escape()**: string

```php
public  escape(string  $string): string
```

Escape HTML special characters.



#### Parameters
**$string** :
Dirty html.






#### Return:
**string**
Clean html.

-----



<a name="method_registerCSS"></a>
### public **registerCSS()**: void

```php
public  registerCSS(string  $css, string  $key = null): void
```

Register css code.



#### Parameters
**$css** :
The css code.

**$key**  (default: null):
An optional identifier






-----



<a name="method_registerCSSFile"></a>
### public **registerCSSFile()**: void

```php
public  registerCSSFile(string  $url): void
```

Register a stylesheet url.



#### Parameters
**$url** :
The stylesheet url.






-----



<a name="method_registerJs"></a>
### public **registerJs()**: void

```php
public  registerJs(string  $js, int  $position = self::POS_END, string  $key = null): void
```

Register a script.



#### Parameters
**$js** :
The script code.

**$position**  (default: self::POS_END):
The view position where to insert the script (default at the end of the body).

**$key**  (default: null):
An optional identifier






-----



<a name="method_registerJsFile"></a>
### public **registerJsFile()**: void

```php
public  registerJsFile(string  $url, int  $position = self::POS_END, string  $key = null): void
```

Register a script url.



#### Parameters
**$url** :
The script url.

**$position**  (default: self::POS_END):
The view position where to insert the script (default at the end of the body).

**$key**  (default: null):
An optional identifier






-----



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
An array of data (name-value pairs) to transmit to the view file.






#### Return:
**string**
The view output.

-----



<a name="method_applyTheme"></a>
### protected **applyTheme()**: string

```php
protected  applyTheme(string  $path): string
```

Try to find an override of the file in a theme.



#### Parameters
**$path** :
The file path






#### Return:
**string**
The overriden or not file path

-----



<a name="method_endBody"></a>
### protected **endBody()**: string

```php
protected  endBody(): string
```

Assemble html in the end of the body position.








#### Return:
**string**
The end of the body html.

-----



<a name="method_findFile"></a>
### protected **findFile()**: string

```php
protected  findFile(string  $viewName): string
```

Retrieve a view file.



#### Parameters
**$viewName** :
The view name (without extension).




**throws**  \RuntimeExceptionif view file not found.



#### Return:
**string**
The path of the view file.

-----



<a name="method_head"></a>
### protected **head()**: string

```php
protected  head(): string
```

Assemble html in the head position.








#### Return:
**string**
The head html.

