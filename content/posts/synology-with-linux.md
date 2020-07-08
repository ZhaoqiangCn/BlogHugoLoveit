---
title: "Synology With Linux"
date: 2020-01-01T16:19:26+08:00
description: ""
draft: false
tags: [Synology,BestTrace,Ipkg,Rclone,SpeedTest]
categories: [Linux]
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

### 简单几步在群晖中安装BestTrace路由追踪

在windows中可以方便的使用BestTrace来追踪DNS记录，但是有些时候也想要知道我的群晖数据是怎么出去的，查阅后发现BestTrace有linux版本，群晖也可以使用。

安装和操作方式如下：

```text
wget http://cdn.ipip.net/17mon/besttrace4linux.zip
unzip besttrace4linux.zip #7z
chmod +x besttrace32
#如何使用
./besttrace32 -q 1 目标IP
```

### 简单几步在群晖中安装IPKG

#### **确定当前的处理器类型：**

```text
cat /proc/cpuinfo | grep cpu
uname –machine 
```

#### **根据CPU类型去下载对应的CPU Bootstrap Script安装包：**

```text
ARM (armv5tejl)：
http://ipkg.nslu2-linux.org/feeds/optware/syno-x07/cross/unstable/syno-x07-bootstrap_1.2-7_arm.xsh
 
PowerPC (ppc_6xx)：
http://ipkg.nslu2-linux.org/feeds/optware/ds101g/cross/unstable/ds101-bootstrap_1.0-4_powerpc.xsh
 
PowerPC (ppc_85xx, e500v?)：
http://ipkg.nslu2-linux.org/feeds/optware/syno-e500/cross/unstable/syno-e500-bootstrap_1.2-7_powerpc.xsh
 
Marvell Kirkwood 88F6281, 88F6282, 88FR131 (ARMv5TE Feroceon)：
http://ipkg.nslu2-linux.org/feeds/optware/cs08q1armel/cross/stable/syno-mvkw-bootstrap_1.2-7_arm.xsh
 
Intel Atom：
http://ipkg.nslu2-linux.org/feeds/optware/syno-i686/cross/unstable/syno-i686-bootstrap_1.2-7_i686.xsh
 
```

```text
Synology ds216+ii：
wget http://ipkg.nslu2-linux.org/feeds/optware/syno-i686/cross/unstable/syno-i686-bootstrap_1.2-7_i686.xsh
将脚本可执行化：
chmod +x syno-i686-bootstrap_1.2-7_i686.xsh 
执行脚本：
sh syno-i686-bootstrap_1.2-7_i686.xsh 
删除脚本：
rm syno-i686-bootstrap_1.2-7_i686.xsh 
更新一下软件源：
/opt/bin/ipkg update
ipkg版本：ipkg -v

链接:
http://ipkg.nslu2-linux.org/feeds/optware/syno-i686/cross/unstable/
```

#### **变量加入系统path：**

vi /root/.profile在path这行结尾分号之前，加入：/opt/sbin:/opt/bin最后保存即可，生效只需录入su切换下用户或者重启就行。 

### 简单几步在群晖中安装Rclone

#### 群晖开机自动挂载脚本

```bash
#!/bin/bash
#!/usr/bin/rclone
# Make script executable with: chmod a+x /root/scripts/nas-mountOnStartup.sh

/usr/bin/rclone mount driveteamspacesh: /volume1/video/DriveSpaceSH \--config=/root/.config/rclone/rclone.conf \--allow-other \--dir-cache-time 672h \--vfs-cache-max-age 675h \--vfs-read-chunk-size 64M \--vfs-read-chunk-size-limit 1G \--buffer-size 32M &
	
exit
```

### 简单几步在群晖中安装SpeedTest测速

在windows中可以方便的使用SpeedTest来测速，但是有些时候也想要知道我的群晖网络速度，查阅后发现SpeedTest有linux版本，群晖也可以使用。

安装和操作方式如下：

```text
wget https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
chmod +x speedtest.py
./speedtest.py --server 3633
./speedtest.py --list | grep Shanghai
```

```text
22145) ESUN Technology (Shanghai) Co., Ltd. (Shanghai, China) [4.49 km] 
21005) China Unicom (Shanghai, China) [19.64 km] 
16803) China Mobile Group Shanghai Co.,Ltd. (Shanghai, China) [19.64 km] 
3633) China Telecom (Shanghai, China) [19.64 km] 
16719) China Mobile Group Shanghai Co.,Ltd. (Shanghai, China) [19.64 km]
```