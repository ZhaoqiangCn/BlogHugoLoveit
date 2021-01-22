# 如何把 Dynamics 365 FO的开发机升级到最新版本


<!--more-->

**以下是一些条件**

* 可以登录 [Microsoft Dynamics Lifecycle Services \(LCS\)](https://lcs.dynamics.com/)，可以打开资产库
* 确认当前 Dev Machine 版本是10.0.13，最新版本是10.0.15
* 开发机已经配置好并且可以正常使用

为了让部署在本地的开发机（虚拟机目前最高版本是10.0.13）和 Azure 的测试环境（SandBox环境目前最高10.0.15）保持代码的一致性，因此需要把本地的开发机升级一下。

### 从 Lifecycle Services 下载大版本的更新包

**资产库**

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365UpgradeDevEnv/4.png)

**软件可部署包**
选择 Service Update ，点击后就会自动开始下载。
![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365UpgradeDevEnv/5.png)

### 从 Lifecycle Services 下载小版本的更新包

**完整详细信息**

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365UpgradeDevEnv/1.png)

这里可以看到当前 SandBox 环境的大版本号和小版本号，我们点击右侧的**查看更新**
![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365UpgradeDevEnv/2.png)

在弹出的页面中我们可以看到已经有许多更新存在这里了，点击右上角的**保存包**就会开始下载了。
![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365UpgradeDevEnv/3.png)



### 在开发机中安装补丁包

**重命名**

文件夹命名方式：只需要版本号即可，注意将版本号的 . 换成 - （可能不识别.）。命名长度不宜过长。

**执行**

打开命令行（管理员），来到解压路径，执行如下命令

```
AXUpdateInstaller.exe list
```

定位到解压路径，找到**文件 DefaultTopologyData.xml** ，定位到`<ServiceModelList>`，将上一步列出来的service，以同样的格式加进来。

执行如下命令

```
AXUpdateInstaller.exe generate -runbookid="MININT-5REKJI6-10015-runbook" -topologyfile="DefaultTopologyData.xml" -servicemodelfile="DefaultServiceModelData.xml" -runbookfile="MININT-5REKJI6-10015-runbook.xml"
```

*-runbook 命名规则：计算机名-版本号-runbook*

执行如下命令，即开始更新了

```
AXUpdateInstaller.exe import -runbookfile="MININT-5REKJI6-10015-runbook.xml"
AXUpdateInstaller.exe list
AXUpdateInstaller.exe execute -runbookid="MININT-5REKJI6-10015-runbook"
```

执行完毕后，如果没有失败，执行如下命令

```
AXUpdateInstaller.exe export -runbookid="MININT-5REKJI6-10015-runbook" -runbookfile="MININT-5REKJI6-10015-runbook.xml"
```

**补充**
如果执行过程中，某一步出错，通过以下命令继续执行

```
AXUpdateInstaller.exe execute -runbookid="runbookID" -rerunstep=stepID
```

**过程中我遇到过的错误**

1. **step25** 由于前几步的更新会关闭Reporting Service，打开后重试即可

   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365UpgradeDevEnv/step25-error.png)

2. **step30** 如果出现这个错误，请直接重新执行第30步

   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365UpgradeDevEnv/step30-error.png)

3. **step52** 这一步比较妖孽，我更新了服务器补丁，重启数次后才生效，，但是安装第二个包的时候却又报错了，索性不更新该服务了

   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365UpgradeDevEnv/step52-error.png)

**参考文档：**

| 标题                                              | 链接                                                         |
| ------------------------------------------------- | ------------------------------------------------------------ |
| Install deployable packages from the command line | [install-deployable-package](https://docs.microsoft.com/zh-cn/dynamics365/fin-ops-core/dev-itpro/deployment/install-deployable-package) |


