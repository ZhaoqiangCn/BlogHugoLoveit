# 如何安装和配置一台 Dynamics 365 FO的开发机


<!--more-->

**以下是一些安装条件**

* 开发机可以登录 [Microsoft Dynamics Lifecycle Services \(LCS\)](https://lcs.dynamics.com/)，可以打开共用资产库
* 计算机可以运行虚拟机
* 最小 16 GB 内存，最好使用 SSD 硬盘

### 从 Microsoft Dynamics Lifecycle Services 下载安装虚拟机文件

**共用资产库**

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/1.png)

**可下载的 VHD**

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/2.png)

*此处略过如何挂载虚拟机...*

远程桌面用户名密码：
**User name: Administrator**
**Password: pass@word1**

### 重命名开发机

在以下两种情况下需要重命名开发机：
- **Accessing a single Microsoft Azure DevOps project across multiple machines:**  不同的开发机不能使用相同名称的机器名称来登录 Azure DevOps （但是可以使用相同的帐户）
- **Installing One Version service updates:**  确保 D365 FO 的版本升级没有问题

#### 在数据库中更新服务器名称

通过以下命令在 Microsoft SQL Server 2016 中更新：

```sql
sp_dropserver [old_name];
GO
sp_addserver [new_name], local;
GO
```

如果不记得了，可以通过以下命令得到老的服务器名称：

```sql
select @@servername
```

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/3.png)

#### 更新报表服务器

需要在报表服务器配置中重新选择数据库

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/4.png)

#### 更新 Azure Storage Emulator

**开始菜单**，打开 **Microsoft Azure**，打开**Microsoft Azure Storage Emulator**

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/5.png)

或者到路径 ：

```
C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Azure\Storage Emulator
```

执行命令：

```
AzureStorageEmulator.exe start
AzureStorageEmulator.exe status
AzureStorageEmulator.exe init -server new_name
AzureStorageEmulator.exe init -forcecreate
```

#### 更新财务报表

下载更新包后，找到下图目录：

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/6.png)

以管理员身份打开 **Microsoft Windows PowerShell**

```
cd <update folder>\MROneBox\Scripts\Update
.\ConfigureMRDatabase.ps1 -NewAosDatabaseName AxDB -NewAosDatabaseServerName new_name -NewMRDatabaseName ManagementReporter -NewAxAdminUserPassword AOSWebSite@123 -NewMRAdminUserName MRUser -NewMRAdminUserPassword MRWebSite@123 -NewMRRuntimeUserName MRUSer -NewMRRuntimeUserPassword MRWebSite@123 -NewAxMRRuntimeUserName MRUser -NewAxMRRuntimeUserPassword MRWebSite@123
```

**参考文档：**

| 标题                                         | 链接                                                         |
| -------------------------------------------- | ------------------------------------------------------------ |
| Rename a local development (VHD) environment | [vso-machine-renaming](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/migration-upgrade/vso-machine-renaming) |

### 连接 VisualStudioTeamService

**Azure DevOps** (https://dev.azure.com)

在**Azure DevOps** 添加项目

**参考文档**

| 标题         | 链接                                                         |
| ------------ | ------------------------------------------------------------ |
| 添加一个项目 | [create-project](https://docs.microsoft.com/zh-cn/azure/devops/organizations/projects/create-project?view=azure-devops&tabs=preview-page) |

在**Azure DevOps** 添加用户

这个地址不太好找，记录一下URL: https://dev.azure.com/OrganizationId/ProjectId/_settings/

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/20.png)



选择 **Project Settings** 在 **Team** 里面添加用户：

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/21.png)

点击 **Permission** ，在 **Contributor** 中添加刚才创建的用户

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/22.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/23.png)

**参考文档**

| 标题             | 链接                                                         |
| ---------------- | ------------------------------------------------------------ |
| 在项目中添加用户 | [add-users-team-project](https://docs.microsoft.com/zh-cn/azure/devops/organizations/security/add-users-team-project?view=azure-devops&tabs=preview-page) |

连接 **Azure DevOps** 和 **Visual Studio**

**参考文档**

| 标题                         | 链接                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| 连接到团队资源管理器中的项目 | [connect-team-project](https://docs.microsoft.com/zh-cn/visualstudio/ide/connect-team-project?view=vs-2019) |

### 配置 Excel add ins

**初始化 Office app 参数**

路径：系统管理 -> 设置 -> Office App 参数 
![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/14.png)
把其中三个页签内容全部初始化一遍。
![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/15.png)


**Excel add ins**

路径：Insert -> Add Ins -> Store -> 搜索 'dynamics'

按照下图添加即可。
![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/16.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/17.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/18.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/19.png)

### 登录  Dynamics 365 FO 实例

#### **提供管理员帐户**

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SetupDevEnv/7.png)

登录 D365 FO 之前必须提供一个管理员帐户用来登录 D365 FO 环境

以管理员身份运行桌面上的 **AdminUserProvisioning** 工具

输入你的邮箱地址，建议用微软相关的邮箱，可以使用个人邮箱，然后点击提交

#### 通过 URL 登录 Dynamics 365 FO 实例

[https://usnconeboxax1aos.cloud.onebox.dynamics.com](https://usnconeboxax1aos.cloud.onebox.dynamics.com/).




