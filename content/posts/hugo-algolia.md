---
title: "用 Hugo 配合 Algolia 实现高效美观的站内搜索"
date: 2020-02-18T09:13:13+08:00
lastmod: 2020-02-18T09:13:13+08:00
draft: false
description: ""
show_in_homepage: true
description_as_summary: false
license: ""

tags: ["hugo",
"algolia",
"站内搜索",
"search"
]
categories: ["hugo"
]

featured_image: ""
featured_image_preview: ""

toc:
  enable: true
  auto: false
code:
  copy: true
math:
  enable: true
mapbox:
  accessToken: ""
share:
  enable: true
comment:
  enable: true
---
> **本文同步更新至 [Youtube ](https://youtu.be/D77dMN_U4YA) 和 [BiliBili ](https://www.bilibili.com/video/av91537755/)**
>
> 作者已经在最新的主题中加入了Algolia搜索，现在只要在配置文件中开启一下即可。

<!--more-->

## 前言

很多的 `Hugo` 主题是没有自带搜索功能的，但是们为了方便用户浏览和查找内容是需要在网站上提供搜索功能。大家可以查看 [Hugo 官方推荐的搜索方案](https://gohugo.io/tools/search/)，这里我选择的是 [Algolia](https://www.algolia.com/) ， 折腾了很久，主题也从`EVEN`更新到了现在的`LOVEIT`，发现也并非很繁琐，以下是折腾后的成果。

##  在Algolia 端创建应用和索引

### Application

点击**NEW APPLICATION**，**Name**可选，方案选择**FREE**，然后创建，随后的地区选择邻近地区即可；
![](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Algolia/1.png)

### Indices & Index

点击侧栏的**Indices**，然后点击**Create Index**，**Index name**自定义（例如自己的域名）
![](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Algolia/0.png)		
![](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Algolia/2.png)

### API Keys

点击侧栏**API Keys**，记住以下的 **Keys**，之后都会用到；
![](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Algolia/3.png)

## 在本地生成索引

### config.yaml

在`themes`同级添加`config.yaml`文件,注意这里的`key`是**Admin API Key**。

```yaml
---
baseurl: "https://www.nashome.cn/"
DefaultContentLanguage: "zh-cn"
hasCJKLanguage: true
languageCode: "zh-cn"
title: "zhaoqiang's blog"
theme: "loveit"
metaDataFormat: "yaml"
algolia:
  index: "**blogloveit"
  key: "*****9748e4cf6b"
  appID: "***KWB5"
---
```

### hugo-aligolia

我们这里使用一个`hugo-algolia`的插件来完成我们的数据同步工作,要安装`hugo-aligolia`我们需要先确保我们已经安装了 `npm` 或者 `yarn` 包管理工具。

使用下面的命令安装即可：

```bash
$ npm install hugo-algolia -g
```

配置完成以后，在根目录下面执行下面的命令：

```bash
$ hugo-algolia -s
JSON index file was created in public/algolia.json
{ updatedAt: '2020-01-23T02:36:09.480Z', taskID: 249063848950 }
```

这个时候我们在 **dashboard** 中打开 **Indices**，可以看到已经有几十条数据了。

如果某篇文章不想被索引的话，我们只需要在文件的最前面设置 index 参数为 false 即可。

## 页面展示

### 新建search.html

在`themes\LoveIt\layouts\partials`新建`search.html`并添加如下代码

```html
<div class="aa-input-container" id="aa-input-container">
    <input type="search" id="aa-search-input" class="aa-input-search" placeholder="Search for titles or URIs..." name="search" autocomplete="off" />
    <svg class="aa-input-icon" viewBox="654 -372 1664 1664">
        <path d="M1806,332c0-123.3-43.8-228.8-131.5-316.5C1586.8-72.2,1481.3-116,1358-116s-228.8,43.8-316.5,131.5  C953.8,103.2,910,208.7,910,332s43.8,228.8,131.5,316.5C1129.2,736.2,1234.7,780,1358,780s228.8-43.8,316.5-131.5  C1762.2,560.8,1806,455.3,1806,332z M2318,1164c0,34.7-12.7,64.7-38,90s-55.3,38-90,38c-36,0-66-12.7-90-38l-343-342  c-119.3,82.7-252.3,124-399,124c-95.3,0-186.5-18.5-273.5-55.5s-162-87-225-150s-113-138-150-225S654,427.3,654,332  s18.5-186.5,55.5-273.5s87-162,150-225s138-113,225-150S1262.7-372,1358-372s186.5,18.5,273.5,55.5s162,87,225,150s113,138,150,225  S2062,236.7,2062,332c0,146.7-41.3,279.7-124,399l343,343C2305.7,1098.7,2318,1128.7,2318,1164z" />
    </svg>
</div>
```

### 添加search.js

在`themes\LoveIt\assets\js`下添加`search.js`

```javascript
$(function() {
  // 替换成自己的algolia信息
  var client = algoliasearch("***KWB5", "7139d*****9748e4cf6bc36ab191d");
  var index = client.initIndex("**blogloveit");
  autocomplete(
    "#aa-search-input",
    { hint: false },
    {
      source: autocomplete.sources.hits(index, { hitsPerPage: 8 }),
      displayKey: "name",
      templates: {
        suggestion: function(suggestion) {
          console.log(suggestion);
          var search;
          if (suggestion.search) {
            search = suggestion.search;
          } else {
            search = suggestion.uri;
          }
          return (
            "<span>" +
            '<a href="/' +
            search +
            '">' +
            suggestion._highlightResult.title.value +
            "</a></span>"
          );
        }
      }
    }
  );


  $(document).on("click", ".aa-suggestion", function () { 
    var aa = $(this).find("a").attr("href");
    window.location.href = aa;
  })
});
```

### 添加search.css文件

在`themes\LoveIt\assets\css`路径下添加`search.css`样式文件

```css
@import 'https://fonts.googleapis.com/css?family=Montserrat:400,700';
.aa-input-container {
  display: inline-block;
  position: relative;
  width: 100%;
}
.aa-input-container span,.aa-input-container input {
    width: inherit;
}
.aa-input-search {
  width: 300px;
  padding: 12px 28px 12px 12px;
  border:0px;
  border: 2px solid #e4e4e4;
  border-radius: 4px;
  -webkit-transition: .2s;
  transition: .2s;
  font-family: "Montserrat", sans-serif;
  box-shadow: 4px 4px 0 rgba(241, 241, 241, 0.35);
  font-size: 11px;
  box-sizing: border-box;
  color: black;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  font-weight: bold;
}
.aa-input-search::-webkit-search-decoration, .aa-input-search::-webkit-search-cancel-button, .aa-input-search::-webkit-search-results-button, .aa-input-search::-webkit-search-results-decoration {
    display: none;
}
.aa-input-search:focus {
    outline: 0;
    border-color: #D3D3D3;
    box-shadow: 4px 4px 0 rgba(58, 150, 207, 0.1);
}
.aa-input-icon {
  height: 16px;
  width: 16px;
  position: absolute;
  top: 50%;
  right: 16px;
  -webkit-transform: translateY(-50%);
          transform: translateY(-50%);
  fill: #e4e4e4;
}
.aa-hint {
  color: yellow;
}
.aa-dropdown-menu {
  background-color: #fff;
  border: 2px solid rgba(228, 228, 228, 0.6);
  border-top-width: 1px;
  font-family: "Montserrat", sans-serif;
  width: 300px;
  margin-top: 10px;
  box-shadow: 4px 4px 0 rgba(241, 241, 241, 0.35);
  font-size: 11px;
  border-radius: 4px;
  box-sizing: border-box;
}
.aa-suggestion {
  padding: 12px;
  border-top: 1px solid gray;
  cursor: pointer;
  -webkit-transition: .2s;
  transition: .2s;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-pack: justify;
      -ms-flex-pack: justify;
          justify-content: space-between;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
}
/* 背景色 */
.aa-suggestion:hover, .aa-suggestion.aa-cursor {
    background-color: #F5F5F5;
}
.aa-suggestion > span:first-child {
    color: #000;
}
.aa-suggestion > span:last-child {
    text-transform: uppercase;
    color: #000;
}
.aa-suggestion > span:first-child em, .aa-suggestion > span:last-child em {
  font-weight: 700;
  font-style: normal;
  background-color: rgba(0, 0, 0, 0.1);
  padding: 2px 0 2px 2px;
}

.aa-suggestion a{
  color: #000;
  font-weight:bold;
}
.aa-suggestion a:hover{
  color: #4B89DC;
}
```

### 在baseof.html中添加代码

在`themes\LoveIt\layouts\_default\baseof.html`中添加代码

```html
{{ if ne .Site.Params.version "5.x" -}}
{{ errorf "\n\nThere are two possible situations that led to this error:\n  1. You haven't copied the config.toml yet. See https://github.com/dillonzq/LoveIt#installation \n  2. You have an incompatible update. See https://github.com//dillonzq/LoveIt/blob/master/CHANGELOG.md \n\n有两种可能的情况会导致这个错误发生:\n  1. 你还没有复制 config.toml 参考 https://github.com/dillonzq/LoveIt#installation \n  2. 你进行了一次不兼容的更新 参考 https://github.com//dillonzq/LoveIt/blob/master/CHANGELOG.md \n" -}}
{{ end -}}
<!DOCTYPE html>
<html lang="{{ .Site.LanguageCode }}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>{{ block "title" . }}{{ .Site.Title }}{{ end }}</title>
    {{- partial "head.html" . }}
</head>

<body>
    <script>
        window.isDark = (window.localStorage && window.localStorage.getItem('theme')) === 'dark';
        window.isDark && document.body.classList.add('dark-theme');
    </script>
    <div class="wrapper">
        {{ partial "header.html" . -}}
        <main class="main">
            <div class="container">
                {{ block "content" . }}{{ end -}}
            </div>
        </main>
        {{ partial "footer.html" . -}}
        {{ partial "scripts.html" . -}}
    </div>
    <a href="#" class="dynamic-to-top" id="dynamic-to-top" data-scroll><span>&nbsp;</span></a>

<!-- 添加的代码  -->
    <div id="ex1" class="modal">
        {{ partial "search.html" . }}
    </div>
<!-- 添加代码结束 -->
</body>

</html>
```

### 引用css文件和js文件

在head.html中添加如下代码

```html
{{ $res := resources.Get "css/search.css" | resources.Minify -}}
<link rel="stylesheet" href="{{ $res.RelPermalink }}">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
```

在scripts.html中添加如下代码

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>

<!-- jQuery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>

<script src="https://res.cloudinary.com/jimmysong/raw/upload/rootsongjc-hugo/algoliasearch.min.js"></script>
<script src="https://res.cloudinary.com/jimmysong/raw/upload/rootsongjc-hugo/autocomplete.min.js"></script>


 {{ $res := resources.Get "/js/search.js" }}
<script src= "{{ $res.RelPermalink }}" type="text/javascript"></script>
```

### 添加锚点

在header.html中添加如下代码(手机端和桌面端两个地方都要添加代码)

```html
<div class="navbar-menu">
            {{ $currentPage := . }}
            {{ range .Site.Menus.main }}
            <a class="menu-item{{ if or ($currentPage.IsMenuCurrent "main" .) ($currentPage.HasMenuCurrent "main" .) | or (eq $currentPage.RelPermalink .URL) }} active{{ end }}"
                href="{{ .URL | absLangURL }}" title="{{ .Title }}">{{ .Name | safeHTML }}</a>
            {{ end }}
            <a href="javascript:void(0);" class="theme-switch"><i class="fas fa-adjust fa-rotate-180 fa-fw"></i></a>
            <!-- 添加的代码 -->
            <a href="#ex1" rel="modal:open"><i class="fas fa-search fa-fw"></i></a>
            <!-- 添加代码结束 -->
        </div>
```