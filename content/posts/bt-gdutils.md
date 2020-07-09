---
title: "使用宝塔面板安装和管理 Google Drive 百宝箱"
subtitle: ""
date: 2020-07-01T16:42:31+08:00
lastmod: 2020-07-01T16:42:31+08:00
draft: false
author: "ZhaoQiang"
authorLink: ""
description: ""

tags: ["宝塔面板",
"GoogleDrive",
"telegrambot"
]
categories: ["Linux",
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

在Telegram中使用 /copy SourceId即可转存到GoogleDrive指定路径

<!--more-->

## 前置条件

- Rclone 已安装配置
- Autorclone 已安装配置
- Gclone 已安装配置

前置条件的安装请转至这里：[如何安装和配置 Autorclone Gclone]({{< ref "install-autorclone-gclone.md" >}})

## 环境配置

```
git clone https://github.com/iwestlin/gd-utils && cd gd-utils
npm install --unsafe-perm=true --allow-root
```

代码执行好之后，直接将 /AutoRclone/accounts/ 的文件全部复制到/gd-utils/sa/

至此，gd-utils就安装好了，接下来是如何配置Telegram bot来实现更方便的管理。

## 修改配置文件

`config.js` 中主要修改的是以下内容，其余的视情况自行修改

```
  const DEFAULT_TARGET = '团队盘ID或者是目录ID' 
  tg_token: '机器人Token'
  tg_whitelist: ['个人用户名'] //['abcberf']
```

## 宝塔面板配置

#### 创建网站

域名随意gd.example.com ，所有设置默认即可。
![PNG](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/GdUtils/1.png)

把 `gd.example.com` 做 A 记录解析到服务器地址。

使用宝塔的PM2管理器或者在命令行直接输入以下代码都可：


```
npm i pm2 -g
cd /gd-utils/
pm2 start server.js
```

#### 添加SSL
![PNG](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/GdUtils/2.png)

#### 添加反向代理
![PNG](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/GdUtils/3.png)
```
代理名称：自定
目标URL：http://127.0.0.1:23333
```

#### 开启防火墙

![PNG](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/GdUtils/6.png)


#### 启动程序

```
curl https://gd.example.com/api/gdurl/count?fid=124pjM5LggSuwI1n40bcD5tQ13wS0M6wg
```

#### 连接Telegram

```
curl -F "url=HTTPS://gd.example.com/api/gdurl/tgbot" 'https://api.telegram.org/bot电报Token/setWebhook'
```

#### 测试

![PNG](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/GdUtils/4.png)
![PNG](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/GdUtils/5.png)