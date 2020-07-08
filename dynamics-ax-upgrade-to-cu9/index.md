# Dynamics AX Upgrade to Cu9


# Dynamics AX 2012 R3 CU 9更新：分步

自CU 9发布以来已经有一段时间了，本文简要介绍了如何为已安装的Microsoft Dynamics AX 2012 R3 CU8安装累积更新9。 如果您尝试将MS Dynamics AX 2012 R3 CU 9作为新安装进行安装，请这样做，例如slipstream（ [在新安装（slipstreaming）中包括累积更新和修补程序](https://translate.googleusercontent.com/translate_c?depth=1&hl=zh-CN&prev=search&rurl=translate.google.com&sl=en&sp=nmt4&u=http://go.microsoft.com/fwlink/%3FLinkId%3D393836&usg=ALkJrhgCl4Ho-Ue-ijOiYZgcLU5yexL23w) ）安装。

安装方式：

1. 在新安装的MS Dynamics AX 2012 R3 CU 9上使用设置向导和补充流程。
2. 使用更新向导将CU9应用到MS Dynamics AX 2012 R3 CU 8的现有安装上。

我们可以从[Microsoft Dynamics Lifecycle Services](https://translate.googleusercontent.com/translate_c?depth=1&hl=zh-CN&prev=search&rurl=translate.google.com&sl=en&sp=nmt4&u=http://lcs.dynamics.com/&usg=ALkJrhjCiPwvAy7ZyrU6_vyOCOxb8AVHlA)直接安装CU 9，也可以使用[Microsoft Dynamics Lifecycle Services](https://translate.googleusercontent.com/translate_c?depth=1&hl=zh-CN&prev=search&rurl=translate.google.com&sl=en&sp=nmt4&u=http://lcs.dynamics.com/&usg=ALkJrhjCiPwvAy7ZyrU6_vyOCOxb8AVHlA)和[PartnerSource中](https://translate.googleusercontent.com/translate_c?depth=1&hl=zh-CN&prev=search&rurl=translate.google.com&sl=en&sp=nmt4&u=https://mbs.microsoft.com/partnersource/northamerica/&usg=ALkJrhh-VvLyJzF-SSJWotZZ5v8Q39r-ZA)都提供的Dynamics AX安装程序进行安装。 我们将在这里学习有关使用LCS的Dynamics AX安装程序安装CU 9的信息。

环境准备：

1. 备份业务和模型存储数据库。 备份正在更新的数据库。
2. 确保您是本地计算机上的Admin和Dynamics AX中的系统管理员。
3. 确保您是SQL Server实例上“ SecurityAdmin”服务器角色的成员。
4. 确保您是模型数据库中的“ db_owner”角色。
5. 在安装此更新（或停机）时，请确保系统以单用户模式运行。

下载更新安装程序：

1. 登录到[PartnerSource](https://translate.googleusercontent.com/translate_c?depth=1&hl=zh-CN&prev=search&rurl=translate.google.com&sl=en&sp=nmt4&u=https://mbs.microsoft.com/partnersource/northamerica/&usg=ALkJrhh-VvLyJzF-SSJWotZZ5v8Q39r-ZA)或[Microsoft Dynamics生命周期服务](https://translate.googleusercontent.com/translate_c?depth=1&hl=zh-CN&prev=search&rurl=translate.google.com&sl=en&sp=nmt4&u=http://lcs.dynamics.com/&usg=ALkJrhjCiPwvAy7ZyrU6_vyOCOxb8AVHlA) 。
2. 下载更新安装程序的最新版本。
3. 在计算机上保存并解压缩更新安装程序以应用更新。
4. 单击更新安装程序后，选择提取文件的路径。

![image001](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/1.png)]

1. 从解压缩的文件中选择axupdate.exe应用程序以打开AX更新安装程序向导

![image003](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/2.png)

1. 现在，在下一步中单击“接受并继续”，单击“下一步”以接受“软件许可条款”。

![image005](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/3.png)

1. 接受许可条款后，从“下载并安装更新”页面中选择“下载并安装更新”选项，然后单击“下一步”按钮。

![image007](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/4.png)

如果假设在选择“安装更新”选项时使用了定制的软件包（将在步骤17中创建并保存），则将提供一个选项（快速/定制）来选择安装类型，如下所示。 根据需要选择类型。

![image009](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/5.png)

使用定制包时，无需登录LCS即可下载更新，因此在这种情况下将跳过步骤8、9和10。

1. 单击下一步按钮，它将提示您进入LCS并使用您的凭据登录。

![image011](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/6.png)

1. 使用凭据登录到LCS后，选择最新更新，然后单击“确定”。

![image013](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/7.png)

下拉列表将显示最新的更新列表。

![image015](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/8.png)

1. 单击“确定”后，向导将开始在“下载进度”页面中下载更新。

![image017](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/9.png)

1. 下载/导入程序包完成后，从“选择更新类型”页面中选择两种更新类型（二进制更新和应用程序更新）。

![image019](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/10.png)

1. 通过单击“下一步”按钮，向导将开始处理上一步中选择的更新。

![image021](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/11.png)

1. 由于还选择了应用程序更新，因此需要选择模型存储，如下所示。 通过指定服务器名称，可以选择不同的模型存储。

![image023](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/12.png)

1. 通过单击下一步按钮，选择具有默认值的应用程序更新。

![image025](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/13.png)

1. 现在，“查看冲突”页面将显示冲突（如果有）。

![image027](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/14.png)

由于发生冲突，请单击“影响分析向导”以开始并分析影响。

启动影响分析向导：

![image029](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/15.png)

分析影响：

![image031](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/16.png)

这将打开Dynamics AX并生成CIL编译。

影响分析结果：

![image033](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/17.png)

单击“高级”按钮以查看带有高级选项的冲突对象。

![图片035](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/18.png)

我刚刚决定删除冲突对象，因为我没有与此对象共享任何其他模型存储。

1. 现在，“查看更新”页面将显示更新列表，然后单击“下一步”继续。

![image037](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/19.png)

1. 一旦检查了更新，“保存更新”页面将提供一个选项以将其另存为自定义程序包，可在以后的步骤7中使用。如果需要在另一台计算机上安装更新，这将很有用。 如果需要在同一台计算机上安装此更新，请选中“在此计算机上安装所选更新”复选框，然后单击“下一步”。

![image039](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/20.png)

1. 现在，“查看组件”将提供在安装过程中将要更新的组件列表。

![image041](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/21.png)

![图片043](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/22.png)

请取消选择默认情况下会标记的美国薪资（64位）和美国薪资（32位），然后单击“安装”按钮。

1. 现在，将如下图所示进行安装。

![图片045](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/23.png)

1. 现在，所有组件均已成功安装，并且设置已完成，如下所示。 点击“完成”。

![image047](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/24.png)

安装后：

1. 重新初始化模型存储，然后重新启动AOS服务。
2. 打开Microsoft Dynamics AX2012。弹出窗口将指示模型存储已修改，需要采取的措施列表。 选择“启动软件更新清单”选项，然后单击“确定”以启动升级清单过程。

![image049](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/25.png)

1. 选择“启动软件更新清单”，然后单击“确定”。 完成所有清单活动。

![image051](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AX2012upgrade/26.png)

1. 完成🙂
