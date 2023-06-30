---
title: "关于在D365FO中创建SSRS报表的一切"
subtitle: "All useful code about create SSRS in D365FO"
date: 2023-06-30T14:38:44+08:00
lastmod: 2023-06-30T14:38:44+08:00
draft: false
author: ""
authorLink: ""
description: ""

tags: ["Dynamics365","Customization"]
categories: ["Dynamicsax"]

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: ""
featuredImagePreview: ""

toc:
  enable: true
math:
  enable: false
lightgallery: false
license: ""
---

<!--more-->
## 概览
通常我们需要创建一个DP，一个Controller，一个Contract，对话框复杂一些的时候需要创建UIBuilder，需要创建一些临时表用来存储展示的数据，需要创建一个查询用来过滤数据。
最后创建SSRS报表和设计。

### 类
#### DP
{{< gist zhaoqiangcn 855565c89bd619133ee6493c8ddcaeca reportDP.md >}}
#### Controller
{{< gist zhaoqiangcn 855565c89bd619133ee6493c8ddcaeca reportController.md >}}
#### Contract
{{< gist zhaoqiangcn 855565c89bd619133ee6493c8ddcaeca reportContract.md >}}
#### UIBuilder

### 临时表
### 查询
### 一些常用的相关元素
<details>
<summary>#### 条码</summary>
{{< gist zhaoqiangcn 855565c89bd619133ee6493c8ddcaeca reportBarcode.md >}}
</details>

<details>
<summary>#### LOGO</summary>
在临时表中创建如下字段：
* Field name: CompanyLogo
* Data type: Container
* Extended data type: Bitmap
{{< gist zhaoqiangcn 855565c89bd619133ee6493c8ddcaeca reportLOGO.md >}}
</details>



