---
title: " 同时部署 Hugo 静态博客到 Netlify 和 Github Pages"
date: 2020-01-12T14:49:17+08:00
description: "百度无法收录github pages，因此本文介绍如何把hugo 同时部署到github pages和netlify而且每次更新文章只需要push到github即可"
draft: false
tags: [Netlify,GithubPages,Even]
categories: [hugo]
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

<!--more-->
>**本文同步更新至 [Youtube ](https://youtu.be/ZAi4a1fyBWI) 和 [BiliBili ](https://www.bilibili.com/video/av84216011/)**

## 部署到Github Pages

请参照 [用 Hugo 配合 GithubActions 自动构建我的博客]({{< ref "Hugo-Github-Actions.md" >}})

## 设置Even主题子模块化

在网站根目录下输入添加主题子模块的命令：

```
git submodule add https://github.com/zhaoqiangcn/hugo-theme-even.git themes/even
```

如果在网站根目录下出现 *.gitmodules* 文件，且内容跟我的类似，则表示成功：

```
[submodule "themes/even"]
	path = themes/even
	url = https://github.com/zhaoqiangcn/hugo-theme-even.git
```

然后 进入主题文件夹 *git push* 到远程仓库即可。

## 部署



![1](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/netlify-signup.jpg)

![2](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/netlify-add-new-site.jpg)

![3](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/netlify-create-new-site-step-1.jpg)

![4](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/netlify-create-new-site-step-2.jpg)

![5](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/netlify-deploying-site.gif)


跟官网宣传的一样，部署 Hugo 网站到 Netlify 非常简单，跟着导航操作即可。

经过部署后已经可以通过 Netlify 分配的域名来访问网站了

## 自定义域名

对于想对网站使用**主域名**而言，自定义域名很简单：

1. 找到 *Domain settings* 选项卡，点击进入域名设置
2. 在 *Custom domains* 一项下点击 *Add domain alias* 来添加自定义域名
3. 在弹出来的输入框输出主域名即可
4. 在域名商处添加如下的 DNS 记录，等待 DNS 刷新，看到主域名处出现 *NETLIFY DNS* 的墨绿色标志即代表成功

```
dns1.p01.nsone.net
dns2.p01.nsone.net
dns3.p01.nsone.net
dns4.p01.nsone.net
```

## 开启 HTTPS

在 *HTTPS* 选项卡下的 *SSL/TLS certificate* 选项开启即可。

证书的签发者为 *Let’s Encrypt*，支持自动续期。也可以自定义别的签发者。

如果想在 *Chrome* 地址栏里看到小绿锁（小灰锁），还需要把所有链接都替换成以 *https://* 开头的链接。

接着在页面按下 *F12* 来打开开发者工具，并切换到 *Network*，刷新页面，查看有什么请求不是以 *https://* 发出的，修改相关页面来替换。
