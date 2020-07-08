# Synology DDNS 02


<!--more-->

# 群晖—-外部访问DDNS教程（第二部分）



> 前文已经说了在配置DDNS之前需要的前提条件，请参照 [群晖—-外部访问DDNS教程（第一部分）]({{< ref "Synology-DDNS-01.md" >}})
>
> 本文将具体说明如何在DSM中配置DDNS

###  1.设置 QuickConnect

QuickConnect 让您使用可自定义的 ID 或地址（如 quickconnect.to/example ）连接到 Synology Router 或部分 Synology 套件（如 Download Station、File Station 和移动应用程序）。

**若要启用 QuickConnect：**

1. 进入**网络中心** &gt; **Internet** &gt; **QuickConnect 和 DDNS**。
2. 勾选**启用 QuickConnect**。
3. 如果您没有 Synology 帐户，请单击**立即注册**。输入所需信息并单击**确定**。如果您已拥有 Synology 帐户，请输入帐户信息。
4. 在 **QuickConnect ID** 栏中创建您自己的 QuickConnect ID。将出现 QuickConnect 链接信息。您可使用这些链接访问 Synology Router。
5. 您还可选择启用或禁用特定套件的 QuickConnect。进入**高级设置**，勾选您要为其启用 QuickConnect 的套件旁的复选框。
6. 单击**应用**来保存设置。

### 2.设置 DDNS

这里可以注册**Synology**提供的DDNS服务或者其他服务商的DDNS。下文仅针对**Synology**，其他下拉列表中的服务商配置基本类似。

**若要设置 DDNS 主机名：**

1. 单击**添加**按钮将出现一个对话框，提示您编辑以下设置：
   * **服务供应商：**选择服务供应商。若要注册以获得 Synology 提供的免费主机名，从下拉菜单中选择 **Synology**，单击**立即注册**，然后按说明输入详情。
   * **主机名：**输入注册的 DDNS 主机名，如 john.synology.me。
   * **用户名/电子邮件：**输入 DDNS 供应商的帐户（如用户名、电子邮件地址…\)
   * **密码：**输入 DDNS 供应商的密码。
   * **外部地址：**使用系统默认设置。
   * **Heartbeat：**启用此选项可接收有关映射主机名状态的报警（仅适用于 Synology 提供的主机名）。
2. 单击**测试连接**以查看设置是否正确。
3. 单击**确定**来保存并结束设置。

**若要管理主机名：**

1. 使用以下按钮可管理已在的主机名条目：
   * **删除：**从列表中删除所选主机名条目。
   * **编辑：**更改所选主机名条目的设置。
   * **立即更新：**更新所有已启用 DDNS 服务的主机名条目状态。

