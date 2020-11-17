---
title: "我是如何优化我的家庭网络使用体验的"
subtitle: ""
date: 2020-10-14T17:19:11+08:00
lastmod: 2020-10-14T17:19:11+08:00
draft: true
author: ""
authorLink: ""
description: ""

tags: []
categories: []

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

## 上网

上网体验在优化过后是能够最直接感受到的，而现在大部分造成打开网页又慢又卡的主要原因就是 DNS 查询慢了，因此怎样能够在输入网址后，立刻查询到最快的IP地址就是解决上网慢的问题关键。

**SmartDNS + AdguardHome + PsWall 三神器组合出场。**

具体如何配置我就不多讲了，网上有很多教程，我是根据【IT奶爸】在油管的教学视频配置的。

最快的时候打开网页的平均速度都是 100ms 以内，这无疑极大的提升了网上冲浪体验。

<img src="https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/homenetwork/DNS.png" alt="DNS" style="zoom: 80%;" />



## 下载

虽说现在大部分的程序和功能都可以在线使用或者观看了，但每月总有那么几天，总有那么一些东东要下载。。。

通过 Aria2 离线下载功能就可以轻松实现对种子文件和磁力链的在线下载了，而且结合了 Telegram 后，只需要将链接或者种子分享到 TelegramBOT 中就可以自动开启下载，下载完成后自动上传到 GoogleDrive 并发送通知。

## 看片

最开始搭建的是 emby 服务器，在没有 cloudflare 加速的情况下，几乎是无法观看的，后来通过cf加速后，速度也能凑合，中间会有一些缓冲，总让人不舒坦，于是尝试通过 goindex 搭建，架设在 cf workers 上，那速度简直了，打开视频任意切换播放点，让人更加爱小姐姐了，唯一的缺点就是没有海报。

1. 自建 emby 服务器（GCP），然后通过 CloudFlare CDN 加快国内访问速度。
2. 自建 GoIndex 服务器（no-VPS），通过 CloudFlare workers 优化节点访问速度。

## 分享

平时一直会有一些小文件需要快速分享，无论是通过自建云盘还是百度云什么的都不理想，直到奶牛快传的出现终于解决了我的大问题。

## 同步

跨平台跨地区的同步主要还是通过群晖 DSM 的 Synology Drive 来实现，家中 PC 和办公室的 PC 各装一个客户端，通过 Drive 就可以随时随地的同步文件了。