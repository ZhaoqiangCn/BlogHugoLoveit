---
title: "一键部署之如何搭建时下最流行的Trojan"
subtitle: ""
date: 2020-07-09T14:35:18+08:00
lastmod: 2020-07-09T14:35:18+08:00
draft: true
author: ""
authorLink: ""
description: ""

tags: [trojan]
categories: [linux]

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

Trojan 模仿了互联网上最常见的HTTPS协议，以诱骗 GFW 认为它就是 HTTPS，从而不被识别。

<!--more-->

## 前置条件

- 一个域名
- 已做好A记录解析

### 依赖包

安装依赖包(Debian/Ubuntu)：

```linux
apt-get update && apt-get install sudo whiptail curl locales -y && sudo -i
```

安装依赖包(Centos):

```linux
yum update -y && yum install sudo newt curl -y && sudo -i
```

## 一键安装脚本

首先感谢大佬，好人一生平安

一键脚本：https://github.com/johnrosen1/trojan-gfw-script

```linux
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/harry3633/trojan-gfw-script/master/trojangui.sh)"
```

1. 方向键选择，回车确定安装，直接回车
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Trojan/1.png)
2. 可安装项目有很多，根据喜好选择
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Trojan/2.png)
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Trojan/3.png)
3. 输入准备好的解析成功的域名。
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Trojan/4.png)
4. 输入用户密码阵列两个，可输不同的密码，一样也可以。
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Trojan/5.png)
5. 输入访问 natdata 访问路径，随便填。
6. 是否使用 API ，支持 cloudflare，aliyun，dnspod 等几家，选否即可，后面会自动通过ACME生产证书
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Trojan/6.png)
7. 开始安装，需要等一会儿
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Trojan/7.png)
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Trojan/8.png)
8. 访问域名会出现一个网站
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Trojan/9.png)

### 完工！

