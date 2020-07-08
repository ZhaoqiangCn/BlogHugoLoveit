# How to create deployable packages in Dynamics 365 


<!--more-->

## 概览

Dynamics 365 中，部署开发者的代码和客制化的程序到生产环境必须通过 deployable packages。


Deployable packages 可以通过 **Visual Studio dev tools**，或者 **build automation process** 创建，创建后需要上传至LCS Project Asset library。一起都准备好之后，系统管理员即可通过 LCS 中的 **Maintain > Apply updates** tool，将程序发布到生产环境。

下图简单描述了整个过程:

![Create and apply a deployment package](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/deployment/media/createandapplydeployablepackage.png)

## 创建  deployable package

在开发环境中，可以在Visual studio通过以下步骤创建 deployable package。


1. 选择 **Dynamics 365** > **Deploy** > **Create Deployment Package**. ![Create deployment package](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/deployment/media/createdeploymentpackage-986x1024.png)
2. 指定文件路径![Select a location](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/deployment/media/pack4.png)
3. 创建好之后，登录 LCS ，点击 **Asset Library** 。
4. 上传刚才创建的deployable package。

## 删除 deployable package

详细信息可以参考：[Uninstall a package](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/deployment/uninstall-deployable-package).
