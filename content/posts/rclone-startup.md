---
title: "如何在服务器重启后自动挂载Rclone-脚本"
subtitle: ""
date: 2020-07-27T17:31:10+08:00
lastmod: 2020-07-27T17:31:10+08:00
draft: false
author: ""
authorLink: ""
description: ""

tags: [rclone]
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

<!--more-->

先把rclone的可执行文件复制到/usr/bin：

```
cp /root/rclone-v1.39-linux-amd64/rclone /usr/bin/rclone
```

新建一个rclone.service文件：

```
vi /usr/lib/systemd/system/rclone.service
```

写入：

```
[Unit]
Description = rclone

[Service]
User = root
ExecStart = /usr/bin/rclone mount embyserver:videos/embyserver /www/wwwroot/v.nashome.cn/embyserver \
--umask 0000 \
--default-permissions \
--allow-non-empty \
--allow-other \
--buffer-size 32M \
--dir-cache-time 12h \
--vfs-read-chunk-size 64M \
--vfs-read-chunk-size-limit 1G
Restart = on-abort

[Install]
WantedBy = multi-user.target
```

重载daemon，让新的服务文件生效：

```
systemctl daemon-reload
```

现在就可以用systemctl来启动rclone了：

```
systemctl start rclone
```

设置开机启动：

```
systemctl enable rclone
```

停止、查看状态可以用：

```
systemctl stop rclone
systemctl status rclone
```

重启你的VPS，然后查看一下rclone的服务起来没，接着查看一下盘子挂上去没：

```
reboot
systemctl status rclone
df -h
```