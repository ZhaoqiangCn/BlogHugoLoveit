#  使用 Aria2 实现百度云(Baiduyun)自动转存到谷歌云(GoogleDrive)


> 前文已经说过如何通过 Aria2离线下载并自动上传到 Google Drive，请参照 [Aria2 搭建离线下载并自动上传到 Google Drive]({{< ref "aria2.md" >}})
>
> 本文将具体说明如何通过 Aria2 离线下载百度云盘的内容 从而实现百度云转存到 Google Drive

## 安装

需要以下二个工具配合使用：

- [BaiduExporter](https://github.com/acgotaku/BaiduExporter/releases/download/v0.8.5/Exporter.crx)：百度云盘导出下载的 `Chrome` 插件。[下载地址](https://github.com/acgotaku/BaiduExporter/releases/download/v0.8.5/Exporter.crx)
- [Aria2](https://github.com/aria2/aria2)：离线下载工具

### BaiduExporter设置

下载的`BaiduExporter`由于目前`chrome`的限制，是无法直接使用的。

**解决办法：**修改文件后缀为`.rar` 然后解压缩,得到如下文件夹。

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/aria2baiduyun/01.png)

### Chrome设置

在`Chrome`扩展程序中打开**开发者模式**，**加载已解压的扩展程序**，然后选中刚才解压的文件夹即可。

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/aria2baiduyun/02.png)

### 百度云设置

刷新浏览器来到百度网盘后，任意选中一个文件就可以看到多出了一个**导出下载**的按钮了。

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/aria2baiduyun/03.png)

点击**设置**,在这里需要输入之前配置好的ARIA2的地址和远程下载的文件夹，**这个文件夹我就选上一篇文章中设置好的可以自动上传到googledrive的文件夹了**，其他参数不需要修改。

**RPC地址格式**：http://token:123456qwerty@example.com:6800/jsonrpc

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/aria2baiduyun/04.png)

## 使用

使用非常简单，在百度云中选中需要下载的文件，点击 **ARIA2 RPC** 后下载就已经自动开始啦。

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/aria2baiduyun/05.png)

## 结语

充值一波信仰吧，否则速度会让你崩溃。
