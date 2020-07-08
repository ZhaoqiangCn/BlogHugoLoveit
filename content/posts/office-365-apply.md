---
title: "免费申请 Office365 企业版一年试用教程"
date: 2020-01-14T14:45:12+08:00
description: ""
draft: false
tags: [Office365]
categories: [Dynamicsax]
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

### ***\*注册步骤\****

1）需要一个微软的账号，如果已经有了就跳过这一步！

填写注册信息很轻松完成！

特别提醒一下，需要到：https://account.microsoft.com/profile  维护自己用户名等信息，否则无法进行下一步！

2）开通Office开发者账号

注册链接：https://developer.microsoft.com/en-us/office/profile/

完善相关信息，国家选择China

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Office365/1.jpg)

3）下面是勾选你要使用那些功能。不知道怎么勾选那就全勾选吧！

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Office365/2.jpg)

鼠标点的累？Chrome 浏览器 F12 打开控制复制下面的脚本执行一下，全部勾选了。

```
$(".ms-Checkbox").each(function(i,o){$(o)[0].click()})
```

4）点击加入后，稍等一会可见下面的成功界面！点击【SET UP SUBSCRIPTION】设置订阅相关内容！其实就是设置一个全局管理员！需要一个手机号接收验证码！

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Office365/3.jpg)

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Office365/4.jpg)

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Office365/5.jpg)

5）设置完成后可见成功界面如下！到期时间！

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Office365/6.jpg)

### **登录控制台**

地址：https://portal.office.com/AdminPortal/Home

登录以后可以管理订阅，管理用户！

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Office365/7.jpg)

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/Office365/8.jpg)

### **许可证信息**

这个是企业版E3订阅详情内容！

| 1234567891011121314 | Office 365 Enterprise E3 DeveloperTo-Do (Plan 3)Microsoft Forms (Plan E5)Microsoft Stream for O365 E5 SKUFlow for Office 365PowerApps for Office 365Microsoft TeamsMicrosoft PlannerSwayOffice 最新的桌面版本Skype for Business Online (Plan 2)Exchange Online (Plan 2)Office Online for DeveloperSharePoint Online for Developer |
| ------------------- | ------------------------------------------------------------ |
|                     |                                                              |

你最多可以在 5 台电脑或 Mac、5 个平板电脑以及智能手机上安装 Office。

### **其他提醒**

网上经常有一些忽悠小白用户，用试用E3订阅当E3 MSDN 来卖！大家一定要警惕！！！

### ***\*后续更新\****

1. 手机号不能接受短信的，扶墙去。发短信页面调用了谷歌的人机验证。
2. 订购周期。从今年4月份开始执行一个更好的政策，90天续订一次。是否有续订资格，微软拿算法评估。我估计挂oneindex的人会比较容易过。
3. 一旦没拿到资格，许可证会被吊销，普通账号有30天缓冲期。管理员有额外60天缓冲期，可以用来下载数据。
4. 没拿到资格可以找office365业务线的客服申诉，说明自己在开发哪类应用。
5. 被删除数据后，可以重新申请90天试用。
6. office365的客服对以上事情完全不知情。
7. 试用版不享受技术性的支持，只享受财务方面的支持和一些帮你找说明文档类的简单支持，支持级别比较低。好像是不支持azuread的高级功能。反正比e3功能要少一些，常用的都有。