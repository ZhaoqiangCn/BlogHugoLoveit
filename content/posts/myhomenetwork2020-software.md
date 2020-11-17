---
title: "Myhomenetwork2020 Software"
subtitle: ""
date: 2020-10-14T15:30:40+08:00
lastmod: 2020-10-14T15:30:40+08:00
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

# 网络拓扑图

## 软路由系统

**L大大 Openwrt** ：

1. Ad Guard Home
2. Smart DNS
3. Wake On LAN
4. PsWall
5. KMS服务器
6. Server酱
7. IpSec VPN
8. DDNS （Cisco）
9. Any connect（Cisco）

## 软控制器

DSM的Docker中建立的Ubnt的AC控制器。

## 本地存储

群晖的DSM，8T双盘位，一个存放数据，另一个基本用来存放备份的数据，然后通过iSCSI给我的PC共享了500G硬盘。

## 云端存储

### 谷歌云

**宝塔面板**

已宝塔面板为载体搭建了如下服务：

1. Aria2 离线下载并自动上传至Google Drive 可 Telegram 直接操作
2. 阅后即焚
3. emby服务器
4. gd-utils(Google Drive 转存工具）可 Telegram 直接操作
5. RSS 订阅自动推送到 Telegram
6. Twitter 点赞自动推送到 Telegram

**多媒体文件**

emby和goindex所需的媒体文件全部存储在谷歌云盘中。

**本地存储备份**

本地NAS的文件定期会自动上传至谷歌云盘中。

## 多媒体服务

1. 自建emby服务器（GCP），然后通过CloudFlare CDN加快国内访问速度。
2. 自建GoIndex服务器（no-VPS），通过CloudFlare workers优化节点访问速度。

## 阿里云

本站域名nashome.cn,由阿里云托管并解析，本站还通过阿里云CDN，分流国内和国外用户访问节点，本站的静态图片全部由阿里云OSS托管。