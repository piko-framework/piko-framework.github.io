---
layout: default
title: AssetBundle
parent: API
---



# \Piko\AssetBundle

AssetBundle represents a collection of CSS files and JS files to publish inside the public path.








## Properties summary

| Name | Description |
|------|-------------|
| public [`$css`](#property_css) | List of CSS files that this bundle contains.  |
| public [`$dependencies`](#property_dependencies) | Bundle dependencies.  |
| public [`$js`](#property_js) | List of JavaScript files that this bundle contains... |
| public [`$jsPosition`](#property_jsPosition) | Position of the js file in the generated view.  |
| public [`$name`](#property_name) | The bundle name. (eg. jquery, bootstrap, etc.)  |
| public [`$publishedBasePath`](#property_publishedBasePath) | The root directory storing the published asset fil... |
| public [`$publishedBaseUrl`](#property_publishedBaseUrl) | The base URL through which the published asset fil... |
| public [`$sourcePath`](#property_sourcePath) | The directory that contains the source asset files... |
| protected [`$assetBundles`](#property_assetBundles) | list of the registered asset bundles. The keys are... |

## Inherited Properties

| Name | Description |
|------|-------------|
| protected [`$eventDispatcher`](EventHandlerTrait.md#property_eventDispatcher) |   |
| protected [`$listenerProvider`](EventHandlerTrait.md#property_listenerProvider) |   |

## Methods summary

| Name | Description |
|------|-------------|
| public [`publish`](#method_publish) | Publish assets into public path  |
| public [`register`](#method_register) | Registers this asset bundle with a view.  |
| protected [`copy`](#method_copy) | Copy recursively a folder into another one.  |

## Inherited Methods

| Name | Description |
|------|-------------|
| public [`on`](/EventHandlerTrait.md#method_on) | Registers an event listener.  |
| public [`trigger`](/EventHandlerTrait.md#method_trigger) | Trigger an event that may be listen by event liste... |

-----


## Properties


<a name="property_css"></a>
### public **$css** : string[]
List of CSS files that this bundle contains.






<a name="property_dependencies"></a>
### public **$dependencies** : string[]
Bundle dependencies.






<a name="property_js"></a>
### public **$js** : string[]
List of JavaScript files that this bundle contains.






<a name="property_jsPosition"></a>
### public **$jsPosition** : int
Position of the js file in the generated view.




**see**  \Piko\View



<a name="property_name"></a>
### public **$name** : string
The bundle name. (eg. jquery, bootstrap, etc.)






<a name="property_publishedBasePath"></a>
### public **$publishedBasePath** : string
The root directory storing the published asset files.






<a name="property_publishedBaseUrl"></a>
### public **$publishedBaseUrl** : string
The base URL through which the published asset files can be accessed.






<a name="property_sourcePath"></a>
### public **$sourcePath** : string
The directory that contains the source asset files for this asset bundle.
You can use either a directory or an alias of the directory.





<a name="property_assetBundles"></a>
### protected **$assetBundles** : \Piko\AssetBundle[]
list of the registered asset bundles. The keys are the bundle names
and the values are the AssetBundle class name.




**see**  \Piko\AssetBundle::register()


-----

## Methods




<a name="method_publish"></a>
### public **publish()**: void

```php
public  publish(): void
```

Publish assets into public path








-----



<a name="method_register"></a>
### public **register()**: \Piko\AssetBundle

```php
public static  register(\Piko\View  $view): \Piko\AssetBundle
```

Registers this asset bundle with a view.



#### Parameters
**$view** :
the view to be registered with






#### Return:
**\Piko\AssetBundle**
the registered asset bundle instance

-----



<a name="method_copy"></a>
### protected **copy()**: void

```php
protected  copy(string  $src, string  $dest): void
```

Copy recursively a folder into another one.



#### Parameters
**$src** :
The source directory to copy

**$dest** :
The destination directory to copy




**throws**  \RuntimeExceptionif src not exists



