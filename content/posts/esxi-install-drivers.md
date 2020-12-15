---
title: "如何在Esxi6.7中在线安装第三方网卡驱动（Realtek瑞昱RTL8111G/8168网卡驱动）"
subtitle: ""
date: 2020-12-15T15:59:19+08:00
lastmod: 2020-12-15T15:59:19+08:00
draft: false
author: ""
authorLink: ""
description: ""

tags: [Esxi,Realtek,网卡驱动]
categories: [Linux]

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

此教程主要分享给大家如何在已经安装好的 ESXI6.7 中安装第三方显卡驱动

<!--more-->

#### 开启SSH

**路径：主机>操作>服务>启用安全 Shell（SSH）和启动控制台 Shell**

#### 下载网卡驱动

**地址：**

https://vibsdepot.v-front.de/wiki/index.php/List_of_currently_available_ESXi_packages

找到需要安装的驱动程序，

如图：

![1](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/esxi-drivers/1.png)

点进去到最下面，找到下载链接，另存为

如图：
![2](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/esxi-drivers/2.png)


#### 上传驱动到ESXI

**路径：存储 > DataStore** 

如图：

![3](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/esxi-drivers/3.png)

记录 **位置：/vmfs/volumes/5fd6db75-dbd21eac-4b7e-34e6d74232c4**

点击 **数据存储浏览器** 新建一个 **drivers** 文件夹，把刚才下载的驱动上传到该文件夹

#### 安装驱动

执行如下命令即可安装驱动程序

```linux
esxcli software acceptance set --level=CommunitySupported
```

```linux
esxcli software vib install -v /vmfs/volumes/5fd6db75-dbd21eac-4b7e-34e6d74232c4/drivers/net55-r8168-8.045a-napi.x86_64.vib
```

#### 问题

安装一些上古网卡驱动的时候会报下面这个错误：

```
[DependencyError]
 VIB Realtek_bootbank_net-r8139too_0.9.28-1 requires com.vmware.driverAPI-9.2.0.0, but the requirement cannot be satisfied within the ImageProfile.
 VIB Realtek_bootbank_net-r8139too_0.9.28-1 requires vmkapi_2_0_0_0, but the requirement cannot be satisfied within the ImageProfile.
 Please refer to the log file for more details.
```

不用担心，在命令最后加上 `--force` 即可

```
esxcli software vib install -v /vmfs/volumes/5fd6db75-dbd21eac-4b7e-34e6d74232c4/drivers/XXXX.vib --force
Installation Result
   Message: The update completed successfully, but the system needs to be rebooted for the changes to be effective.
   Reboot Required: true
   VIBs Installed: Realtek_bootbank_net-r8139too_0.9.28-1
   VIBs Removed:
   VIBs Skipped:
```