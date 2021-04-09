---
title: "如何生成 Dynamics 365 车队管理解决方案文件"
subtitle: ""
date: 2021-03-30T09:53:36+08:00
lastmod: 2021-03-30T09:53:36+08:00
draft: false
author: "ZhaoQiang"
authorLink: ""
description: "Dynamics 365 Find Fleet Management Solution File"

tags: ["Dynamics365"]
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

一些 Dynamics 365 教程需要 Fleet Management 解决方案文件。所有 Dynamics AX 开发 VM 上都存在 Fleet Management 模型。但是，某些 VM 不包含编辑，测试和调试这些模型所需的解决方案文件。您可以按照此处描述的步骤，轻松地从 Fleet Management 模型中创建 Visual Studio 解决方案文件。

从 **Dynamics 365  > Options** 对话框中启用 **Organize project by element type** 选项  

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/5773.pic1.jpg)

在 **Application Explorer** 中按 **model:"fleet management"** 的所有元素过滤

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/4527.filterbymodel.png)

搜索完成后，右键单击 **AOT** 节点，然后选择 **将搜索结果添加到新项目**

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/1563.pic3.jpg)

在 **新建项目** 对话框中，输入解决方案名称，项目名称和位置，然后单击 **确定** 。

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/0815.pic4.jpg)


   *   将解决方案命名为 FleetManagement
   *   将项目命名为 FleetManagement 或 **Fleet Management Migrated** （在某些教程中，该项目称为“ Fleet Management Migrated”项目）  

这将在新的 FleetManagement 解决方案下创建一个 FleetManagement 项目，并将属于 Fleet Management 模型的所有元素添加到该项目中。

重复步骤2到3，将**Fleet Management Extension**模型添加到新项目中。

在“新建项目”对话框中，输入项目名称，并确保选择 **添加到解决方案 **以将新项目添加到现有的 Fleet Management 解决方案中。

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/2072.pic5.jpg)

最终结果将是一个 Fleet Management 解决方案，其中包含2个项目：

* **Fleet Management（或 Fleet Management Migrated）**

* **Fleet Management Extension**

* ![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/5706.pic6.jpg)

您可以使用此过程从Application Explorer中的任何模型中创建项目或解决方案。您还可以将其他过滤器应用于Application Explorer搜索，以从模型元素的子集而不是整个模型创建项目。