---
title: "Dynamics AX Issue： Insufficient Memory to Run Script"
subtitle: ""
date: 2020-07-07T09:08:44+08:00
lastmod: 2020-07-07T09:08:44+08:00
draft: false
author: "ZhaoQiang"
authorLink: ""
description: ""

tags: ["Ax2009","Ax4.0",
""
]
categories: ["Dynamicsax",
""
]

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: ""
featuredImagePreview: ""

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

lightgallery: false
license: ""
---

在AX4.0和5.0中，有时候在读取一些内容比较多的文件的时候会报错中断：在AX2012中是50MB，但是在AX2009中大约是7MB

Error executing code: Insufficient memory to run script. 

<!--more-->

# Error executing code: Insufficient memory to run script

我们需要到操作系统的注册表中做出如下设置：

**For the \*Dynamics AX Client\* the correct Registry value is:**

**AX 4.0:**

```
Key name:  [HKEY_CURRENT_USER\Software\Microsoft\Dynamics\4.0\Configuration\*(configuration name)*]
Value name: maxbuffersize
Value type: REG_SZ
Value:   (Maximum amount of memory in MB or 0 for no limit)
```

**AX 2009:**

```
Key name:  [HKEY_CURRENT_USER\Software\Microsoft\Dynamics\5.0\Configuration\*(configuration name)*]
Value name: maxbuffersize
Value type: REG_SZ
Value:   (Maximum amount of memory in MB or 0 for no limit)
```

**需要注意的是：**

我们可以直接把*maxbuffersize,Text,15*加入到.axc文件中， 15表示15MB。

**For the \*Dynamics AX .Net Business Connector/AX BizTalk Adapter\* the correct location is:**

**AX 4.0:**

```
  Key name:  [HKEY_LOCAL_MACHINE\Software\Microsoft\Dynamics\4.0\Configuration\*(configuration name)*]
  Value name: maxbuffersize
  Value type: REG_SZ
  Value:   (Maximum amount of memory in MB or 0 for no limit)
```
**AX 2009:**

```
  Key name:  [HKEY_LOCAL_MACHINE\Software\Microsoft\Dynamics\5.0\Configuration\*(configuration name)*]
  Value name: maxbuffersize
  Value type: REG_SZ
  Value:   (Maximum amount of memory in MB or 0 for no limit)
```
**For the \*Dynamics AX AOS\* the correct Registry value is:**

**AX 4.0:**

```
  Key name:  [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dynamics Server\4.0\*(AOS instance)*\*(configuration name)*]
  Value name: maxbuffersize
  Value type: REG_SZ
  Value:   (Maximum amount of memory in MB or 0 for no limit)
```
 **AX 2009:**
```
  Key name:  [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dynamics Server\5.0\*(AOS instance)*\*(configuration name)*]
  Value name: maxbuffersize
  Value type: REG_SZ
  Value:   (Maximum amount of memory in MB or 0 for no limit)
```
**需要注意的是:**

- 注册表中的*maxbuffersize*默认是不存在的 
- 设置好之后所有关联的组件都需要重启
- 尽管可以设置为0（无限制），但是这并不推荐！

**References:**

[KB961548](https://mbs.microsoft.com/knowledgebase/KBDisplay.aspx?scid=kb;EN-US;961548); [KB953914](https://mbs.microsoft.com/knowledgebase/KBDisplay.aspx?scid=kb;EN-US;953914)