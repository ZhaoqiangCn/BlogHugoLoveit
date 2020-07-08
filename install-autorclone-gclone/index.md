# 如何安装和配置 Autorclone Gclone


使用Gclone搬运Google Drive资源

<!--more-->

[Autorclone地址](https://github.com/xyou365/AutoRclone/)

[Gclone地址](https://www.hostloc.com/thread-643808-1-1.html)

## 安装步骤

### 一、安装Rclone、Gclone

```
curl https://rclone.org/install.sh | sudo bash
安装原版rclone
bash <(wget -qO- https://git.io/gclone.sh)
安装修改后的Gclone
```

### 二、安装配置Autorclone

**配置环境**

```
#CentOS系统
wget https://www.moerats.com/usr/shell/Python3/CentOS_Python3.6.sh && sh CentOS_Python3.6.sh
yum install screen git -y
#Debian系统
wget https://www.moerats.com/usr/shell/Python3/Debian_Python3.6.sh && sh Debian_Python3.6.sh
apt-get install screen git 
#Ubuntu系统
apt update
apt install python3-pip python3-setuptools python3-dev python3-wheel build-essential screen git -y
```

**安装源码并配置环境**

```
git clone https://github.com/xyou365/AutoRclone && cd AutoRclone && pip3 install -r requirements.txt
```

### 三、生成SA账号

1. 获取账户的JSON
在[Python Quickstart ](https://developers.google.com/drive/api/v3/quickstart/python)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AutoRclone/1.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AutoRclone/2.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AutoRclone/3.png)

这一步会得到一个文件，保存它
2. 生成SA账号
```
python3 gen_sa_accounts.py --quick-setup 1
```
最后的参数1表示创建多少项目，一个项目一百个SA账户。

然后运行下面的命令，会在ROOT目录生成一个email文件，该文件就是你所创建的账户的所有的邮箱地址。
```
cat ~/AutoRclone/accounts/*.json | grep "client_email" | awk '{print $2}'| tr -d ',"' | sed 'N;N;N;N;N;N;N;N;N;/^$/d;G' > ~/email
```
3. 创建[Google Group](https://groups.google.com/)
将上面得到的email文件中的邮箱全部加如刚创建的Group
![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AutoRclone/4.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AutoRclone/5.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/AutoRclone/6.png)

至此，Autorclone的配置全部结束

### 四、配置Gclone

```
gclone config

[root@izj6cfrhpszlpag2u50h1pz ~]# gclone config

Current remotes:

Name                 Type
====                 ====
gc                   drive
gc1                  drive
jygd                 drive
sjhl                 onedrive

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> n
name> gc
Remote "gc" already exists.
name> gc2
Type of storage to configure.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value
 1 / 1Fichier
   \ "fichier"
 2 / Alias for an existing remote
   \ "alias"
 3 / Amazon Drive
   \ "amazon cloud drive"
 4 / Amazon S3 Compliant Storage Provider (AWS, Alibaba, Ceph, Digital Ocean, Dreamhost, IBM COS, Minio, etc)
   \ "s3"
 5 / Backblaze B2
   \ "b2"
 6 / Box
   \ "box"
 7 / Cache a remote
   \ "cache"
 8 / Citrix Sharefile
   \ "sharefile"
 9 / Dropbox
   \ "dropbox"
10 / Encrypt/Decrypt a remote
   \ "crypt"
11 / FTP Connection
   \ "ftp"
12 / Google Cloud Storage (this is not Google Drive)
   \ "google cloud storage"
13 / Google Drive
   \ "drive"
14 / Google Photos
   \ "google photos"
15 / Hubic
   \ "hubic"
16 / In memory object storage system.
   \ "memory"
17 / JottaCloud
   \ "jottacloud"
18 / Koofr
   \ "koofr"
19 / Local Disk
   \ "local"
20 / Mail.ru Cloud
   \ "mailru"
21 / Mega
   \ "mega"
22 / Microsoft Azure Blob Storage
   \ "azureblob"
23 / Microsoft OneDrive
   \ "onedrive"
24 / OpenDrive
   \ "opendrive"
25 / Openstack Swift (Rackspace Cloud Files, Memset Memstore, OVH)
   \ "swift"
26 / Pcloud
   \ "pcloud"
27 / Put.io
   \ "putio"
28 / QingCloud Object Storage
   \ "qingstor"
29 / SSH/SFTP Connection
   \ "sftp"
30 / Sugarsync
   \ "sugarsync"
31 / Transparently chunk/split large files
   \ "chunker"
32 / Union merges the contents of several remotes
   \ "union"
33 / Webdav
   \ "webdav"
34 / Yandex Disk
   \ "yandex"
35 / http Connection
   \ "http"
36 / premiumize.me
   \ "premiumizeme"
Storage> 13
** See help for drive backend at: https://rclone.org/drive/ **

Google Application Client Id
Setting your own is recommended.
See https://rclone.org/drive/#making-your-own-client-id for how to create your own.
If you leave this blank, it will use an internal key which is low performance.
Enter a string value. Press Enter for the default ("").
client_id> 
Google Application Client Secret
Setting your own is recommended.
Enter a string value. Press Enter for the default ("").
client_secret> 
Scope that rclone should use when requesting access from drive.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value
 1 / Full access all files, excluding Application Data Folder.
   \ "drive"
 2 / Read-only access to file metadata and file contents.
   \ "drive.readonly"
   / Access to files created by rclone only.
 3 | These are visible in the drive website.
   | File authorization is revoked when the user deauthorizes the app.
   \ "drive.file"
   / Allows read and write access to the Application Data folder.
 4 | This is not visible in the drive website.
   \ "drive.appfolder"
   / Allows read-only access to file metadata but
 5 | does not allow any access to read or download file content.
   \ "drive.metadata.readonly"
scope> 1
ID of the root folder
Leave blank normally.

Fill in to access "Computers" folders (see docs), or for rclone to use
a non root folder as its starting point.

Note that if this is blank, the first time rclone runs it will fill it
in with the ID of the root folder.

Enter a string value. Press Enter for the default ("").
root_folder_id> 
Service Account Credentials JSON file path 
Leave blank normally.
Needed only if you want use SA instead of interactive login.
Enter a string value. Press Enter for the default ("").
*************************************************此处为重点***************************************
service_account_file> 因为我们在root目录配置的Autorclone，所以此处填写为/root/AutoRclone/accounts/任意一个json文件名
*************************************************此处为重点***************************************
Enter a string value. Press Enter for the default ("").
service_account_file_path> 此处填写/root/AutoRclone/accounts/
Enter a string value. Press Enter for the default ("").
service_account_file_path> 
Edit advanced config? (y/n)
y) Yes
n) No (default)
y/n> n
Remote config
Use auto config?
 * Say Y if not sure
 * Say N if you are working on a remote or headless machine
y) Yes (default)
n) No
y/n> n
Please go to the following link: 这里返回是的一个链接，自行复制粘贴到浏览器完成授权，并获取token
Log in and authorize rclone for access
Enter verification code> token输入在这里
后面会有个让你选择是否为团队盘的选项，认真看一下，选完之后就可以一直回车了
```

到这里，AutoRclone和Gclone就完全配置完了.

接下来可以配置Google Drive百宝箱来更方便和快速的搬运了。

({{< ref "bt-gdutils.md" >}})
