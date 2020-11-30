---
title: " 如何在局域网中访问 Dynamics 365 FO OneBox 虚拟机"
subtitle: ""
date: 2020-11-26T10:57:59+08:00
lastmod: 2020-11-26T10:57:59+08:00
draft: false
author: "ZhaoQiang"
authorLink: ""
description: ""

tags: ["Dynamics365"
]
categories: ["Dynamicsax"
]

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

##  在局域网中访问 Dynamics 365 FO OneBox 虚拟机

### 修改 HOST 文件（域名解析文件）

**文件路径：**

```
C:\Windows\System32\drivers\etc
```

在文件中添加下面解析：其中 IP 地址为虚拟机的网络地址

```
192.168.1.58 usnconeboxax1aos.cloud.onebox.dynamics.com

192.168.1.58 usncax1ret.cloud.onebox.dynamics.com

192.168.1.58 usnconeboxax1ret.cloud.onebox.dynamics.com

192.168.1.58 usnconeboxax1pos.cloud.onebox.dynamics.com

192.168.1.58 usnconeboxax1ecom.cloud.onebox.dynamics.com

192.168.1.58 usncax1ecom.cloud.onebox.dynamics.com

192.168.1.58 usncax1pos.cloud.onebox.dynamics.com

192.168.1.58 retailhardwarestation.cloud.onebox.dynamics.com
```

修改完 HOST 文件后，浏览器打开 [https://usnconeboxax1aos.cloud.onebox.dynamics.com](https://usnconeboxax1aos.cloud.onebox.dynamics.com/) 就可以访问到 D365 了，但是系统会提示证书有问题，不理会他也是可以正常使用的，但是逼死强迫症啊。

### 证书

#### 方法一

在虚拟机中打开 **IIS** 找到 *AOSService* 的 *Bindings…* , 依次点击 **Edit… > View… > Details > Copy to File**, 把证书文件保存好。

<img src="https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365oneboxtolan/1.png" alt="img" style="zoom: 80%;" />

把上一步导出的证书文件，导入本机受信任的根证书颁发机构中。

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365oneboxtolan/3.png)

再次尝试打开网址

<img src="https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365oneboxtolan/2.png" alt="img" style="zoom: 50%;" />

#### 方法二

**自签名证书**

使用管理员运行 PowerShell 命令行工具，运行下面代码：

```
New-SelfSignedCertificate -CertStoreLocation cert:\LocalMachine\My -DnsName *.cloud.onebox.dynamics.com -KeyUsage EncipherOnly, CRLSign, CertSign, KeyAgreement, DataEncipherment, KeyEncipherment, NonRepudiation, DigitalSignature, DecipherOnly -NotAfter (Get-Date).AddMonths(60)
```

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365oneboxtolan/4.png)

**拷贝证书**

上述代码执行完毕会在证书管理中生成下图证书，可以看到较近的日期就是我们刚才生成的，把它复制到受信任的根证书里面

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365oneboxtolan/5.png)

**绑定证书**

打开 IIS ，找到下图位置，替换 AOSService 的证书。 

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365oneboxtolan/6.png)

好了，到这里，只需要根据方法一中的办法，把证书导入客户端的电脑中即可，再次浏览器打开 [https://usnconeboxax1aos.cloud.onebox.dynamics.com](https://usnconeboxax1aos.cloud.onebox.dynamics.com/) 就可以**安全的**访问到 D365 了。