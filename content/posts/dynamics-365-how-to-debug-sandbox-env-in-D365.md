---
title: "如何在 D365 的 Sandbox 或者 UAT 环境中调试代码"
subtitle: ""
date: 2021-07-30T22:23:22+08:00
lastmod: 2021-07-30T22:23:22+08:00
draft: false
author: "ZhaoQiang"
authorLink: ""
description: "D365 Debug with UAT and SandBox database"

tags: ["Dynamics365"]
categories: ["Dynamicsax"]

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

开发人员经常会遇到一些需要调试的问题，但调试生产数据库并不是一件容易的事，因为它需要从 LCS 将生产环境中的 DB 刷新到沙箱环境，然后需要通过 LCS 从沙箱中导出 DB，然后将 DB 恢复到 开发环境，这是一项手动任务，需要很多命令和时间。 那么如何调试D365FO中的Sandbox/Test环境

上述步骤可以减少到只有一个步骤，即通过 LCS 将生产数据库刷新到沙箱，然后我们可以使用以下指南直接从开发环境连接到沙箱环境进行调试：

### **Enable access for your IP address**

   ***路径： LCS -> sandbox environment page -> Enable access***

   要连接到测试环境 RDP，您需要为您的 IP 地址创建白名单规则

   ![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/enable-access.png)

### **Connect RDP and open SSMS** 

   *如果不需要修改表相关的数据，请直接跳到第六步使用如下数据修改webconfig。*

![image-20210802111104611](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/image-20210802111104611.png)

![image-20210802111008460](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/image-20210802111008460.png)

![image-20210802110646089](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/image-20210802110646089.png)

   使用 LCS 中的服务器名称连接到 SQL 服务器并将前缀添加到 SQL 服务器名称

    – **[servername.database.windows.net](http://servername.database.windows.net)**

   ![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/2020-03-11-18_05_35-2020-03-11-17_57_56-CREATE-USER-debuguser-WITH-PASSWORD.docx-Word-Product-Act.png)

### **Create a new query to test DB**

   下面的查询将创建一个用于调试的新用户

   ```sql
   CREATE USER devtempuser WITH PASSWORD = 'pass@word1' EXEC sp_addrolemember 'db_owner', 'devtempuser'
   ```

   ![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/2020-03-11-18_13_22-CREATE-USER-debuguser-WITH-PASSWORD.docx-Word-Product-Activation-Failed.png)

### **Whitelist your IP address** 

   选择针对 Master DB 的新查询

   ```sql
   exec sp_set_firewall_rule N'DEVNAME', 'IP', 'IP'
   ```

   ![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/2020-03-11-18_15_08-CREATE-USER-debuguser-WITH-PASSWORD.docx-Word-Product-Activation-Failed.png)

### **Stop IIS, WWW service and Batch Service** 

   打开 IIS 并停止服务。 打开运行并输入services.msc并停止WWW和Microsoft D365批处理服务

### **Edit Web config** 

   Path: **C:\AosService\webroot\web.config**  

   将原始文件保存在其他地方作为备份。 按照下面的屏幕截图修改 4 个键。 您可以评论原始配置或删除它并添加沙箱环境的新配置

   ![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/2020-03-11-18_24_34-_C__AOSService_webroot_web.config-Notepad.png)

### **Start IIS and WWW services** 

   启动IIS和第5步停止的WWW服务，不要启动批处理服务。

### **Open the development environment AX URL** 

   如果您收到 503 不可用错误，请转到 CMD（以管理员身份）并键入 **IISRESET**

### **Debug**

   现在沙箱环境已连接到您的开发环境。 您可以简单地打开 Visual Studio 将断点添加到 X++ 对象进行调试。

按照以上 9 个简单易懂的步骤操作后，您现在可以轻松调试沙箱环境了。 我希望本文能帮助您学习如何在 D365fo 开发环境中调试沙箱/测试环境，并在 D365 财务和运营 AX 中花费最少的精力。
