# NextCloud Scan Files on Server


<!--more-->

有时候我们直接上传文件到服务器上，打开Nextcloud却发现并没有这个文件，因为数据库里并没有这个文件的信息。文件信息都被存储在数据库的oc_filecache表中.

## OCC 命令

通过OCC命令我们可以更新文件索引，OCC 有三个用于管理Nextcloud中文件的命令：

```
files
 files:cleanup              #清楚文件缓存
 files:scan                 #重新扫描文件系统
 files:transfer-ownership   #将所有文件和文件夹都移动到另一个文件夹
```

我们需要使用

```
files:scan 
```

```
  格式:
  files:scan [-p|--path="..."] [-q|--quiet] [-v|vv|vvv --verbose] [--all]
  [user_id1] ... [user_idN]

参数:
  user_id               #扫描所指定的用户（一个或多个，多个用户ID之间要使用空格分开）的所有文件

选项:
  --path                #限制扫描路径
  --all                 #扫描所有已知用户的所有文件
  --quiet               #不输出统计信息
  --verbose             #在扫描过程中显示正在处理的文件和目录
  --unscanned           #仅扫描以前未扫描过的文件
```

以下是一个具体的命令示例：

先进入 Nextcloud 根目录

```
sudo -u www php occ files:scan --all   #扫描所有用户的所有文件
```

执行命令后进行扫描并列出扫描信息。

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/NextCloud/OCC/1.png)

如果不想显示扫描信息，可以在后面加上

```
--quiet
```

```
sudo -u www-data php occ files:scan --all --quiet
```

## 指定扫描位置

总是扫描全部信息并不是那么有必要，还会白白消耗服务器资源。

### 1.指定扫描的用户

列出所有用户：

```
sudo -u www-data php occ user:list
```

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/NextCloud/OCC/2.png)

为用户zhaoqiang 扫描文件：

```
sudo -u www-data php occ files:scan zhaoqiang
```

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/NextCloud/OCC/3.png)

### 2.指定扫描目录

当使用

```
--path
```

 选项时，该路径必须包含以下部分：

```
"user_id/files/path"
  或
"user_id/files/mount_name"
  或
"user_id/files/mount_name/path"
```

其中，

```
/files/
```

是必须要加上的，不可忽略。

示例：

```
sudo -u www-data php occ files:scan --path="/ChengYe/files/Photos" #指向用户ChengYe的Photos文件夹
```

