# 使用 Folderclone 批量转存共享内容到自己的Google Drive


<!--more-->

## 安装 Folderclone

### Linux

**Debian/Ubuntu **安装

```bash
apt update
apt install python3-pip git screen -y
git clone https://github.com/Spazzlo/folderclone.git
cd folderclone
pip3 install folderclone
CentOS`把`apt-get`替换成`yum
```

因拷贝时间长，防止中断，强烈建议使用`screen`后台运行。`screen`简单使用方法

```bash
# 创建screen窗口,folderclone名字可自定义
screen -S folderclone
# 临时退出使用screen后台运行,按组合键
【Ctrl】【a】【d】
# 回到screen窗口
screen -r folderclone
```

### Windows

[下载Python](https://www.python.org/downloads/)安装

[Python 3.7.4 64-bit](https://www.python.org/ftp/python/3.7.4/python-3.7.4-amd64.exe) 、 [Python 3.8.1](https://www.python.org/ftp/python/3.8.1/python-3.8.1.exe)

[下载folderclone源码](https://github.com/Spazzlo/folderclone/archive/master.zip)并解压，比如我的放置在`E:\folderclone-master`

**以管理员身份运行** `cmd`或`Windows PowerShell`执行,且**确保本地cmd或Windows PowerShell稳定的外网环境。**

```bash
# 进入folderclone解压根目录
cd E:\folderclone-master
pip install folderclone
```

## 开启 Drive API

打开登陆 [Python Quickstart](https://developers.google.com/drive/api/v3/quickstart/python) ，点击`Enable the Drive API`

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/01.png)

然后`DOWNLOAD CLIENT CONFIGUIRATION`

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/02.png)

会下载一个`credentials.json`的文件，把`credentials.json`放置上传到folderclone解压根目录，如下图所示

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/03.png)

在终端上，将目录更改为您刚才创建并运行的folderclone文件夹：

```bash
multimanager interactive
```

这将以交互模式启动多管理器。首先，将您带到登录页面进行身份验证。然后会提示您启用服务使用API。访问它提供的链接，启用API，然后返回并按Enter键重试。不必担心每次都要这样做，这是一次设置。

然后会自动弹窗打开浏览器`选择账号`登陆

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/04.png)

【高级】

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/05.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/06.png)

【转至Quickstart（不安全）】【允许】`Quickstart`

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/07.png)

直到浏览器提示`The authentication flow has completed. You may close this window.`

按提示复制里面的`3`个URL链接到浏览器中打开

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/08.png)

启用【Service Usage API】、【Cloud Resource Manager API】、【Cloud Resource Manager API】

完成后按`Enter`回车键，将出现`Multi Manager`提示。

```bash
Multi Manager
mm>
```

您已成功设置`Multi Manager`！

## 创建SA机器人、添加成员到团队盘

对于folderclone，您需要准备几个服务帐户（service accounts）。为此，请运行：

```bash
mm> quick-setup N SHARED_DRIVE_ID
```

`N`您要使用的项目数量以及`SHARED_DRIVE_ID`要复制到的共享驱动器的ID 在哪里。

例如，假设我想复制100 TB的内容。我需要134个SA（每个750 GB）来进行复制，因此需要2个项目。我将复制到ID为`0ABCdeyz_ZaMsxxxLGA`的全新共享驱动器。我将运行：

```bash
mm> quick-setup 2 0ABCdeyz_ZaMsxxxLGA
```

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/09.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/10.png)

这将自动；

- 创建2个项目
- 启用所需的服务
- 创建服务帐户
- 将它们添加到共享驱动器
- 并将其凭据下载到新文件夹中 `accounts`

```bash
mm> quick-setup 2 0AKqujK7R10w9Uk9PVA
Creating 2 projects.
Enabling services.
Creating Service Accounts in mm-q1n5s5q0tenwkm6i-844bj5-43n
Creating Service Account keys in mm-q1n5s5q0tenwkm6i-844bj5-43n
Creating Service Accounts in mm-bj81pc594lhe8z4rr1jkk0871k5
Creating Service Account keys in mm-bj81pc594lhe8z4rr1jkk0871k5
Fetching emails.
Adding 200 users  #按回车键
Done.
mm>
```

现在您可以进行下一步了。

## 使用 

multifoldeclone是可以为您完成所有克隆的工具。这是最简单的使用方法。

```bash
multifolderclone -s SOURCE_FOLDER_ID -d DESTINATION_FOLDER_ID
```

凡`SOURCE_FOLDER_ID`（通过使该文件夹的公共或共享与服务使用的是具有复制账户文件夹确保源文件夹的服务帐户访问）是你要复制的文件夹的ID，并且`DESTINATION_FOLDER_ID`是您要复制到的文件夹的ID。这可以是共享驱动器的ID，也可以是共享驱动器中的文件夹。

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/folderclone/11.png)
