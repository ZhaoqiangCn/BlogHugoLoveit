# 如何将 UAT 的数据在上线时部署到生产环境(How to Deploy UAT Data to Production Server in Dynamics 365)




## 前言

首先这次的操作并不是官方推荐的，但是在绝大多数上线的时候，主数据都是在UAT环境配置和测试，并且绝大多数的应用顾问或者用户都不希望做这种重复劳动，他们太忙了吧～

然而系统并没有提供可以直接部署或者还原的功能，那么我们就创建一个Service Request给微软吧。

## Service Request

登录 **LCS**，打开 **Project Details** ,创建一个新的`Service request` 

如下图：

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Dynamics365/deploydata/1.png)

**新建**

如下图：

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Dynamics365/deploydata/2.png)

选择 `Sandbox to production`

如下图：

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Dynamics365/deploydata/3.png)

接下来需要选择 `Sandbox source` 、`downtime` 等等

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/Dynamics365/deploydata/4.png)



**提交**

勾选所有选项后提交吧，提示说这个过程至少需要5个小时的停机时间，但是绝大多数情况1小时左右就能完成了。
