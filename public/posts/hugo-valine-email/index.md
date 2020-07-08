# 用 Hugo 配合 Valine 实现评论后实时邮件通知


<!--more-->
>**本文同步更新至 [Youtube ](https://youtu.be/y45Y_bYHBk8) 和 [BiliBili ](https://www.bilibili.com/video/av84409002/)**
>
>注意：Leancloud已经改版，有些界面位置已经与本文内容有所变化。

如果你对 `Valine` 自带的`邮件提醒`不满意，还可以使用更完善的第三方`邮件提醒`：

- [Valine-Admin](https://github.com/zhaojun1998/Valine-Admin) (by [@zhaojun1998](https://github.com/zhaojun1998/Valine-Admin))，感谢 `Valine-Admin 及其作者`~

## 概览

　　此项目是一个对 [Valine](https://valine.js.org/) 评论系统的拓展应用，可增强 `Valine` 的邮件通知功能。基于 `Leancloud` 的云引擎与云函数。可以提供邮件 `通知站长` 和 `@ 通知` 的功能，而且还支持自定义 [邮件通知模板](https://github.com/zhaojun1998/Valine-Admin/blob/master/高级配置.md#邮件通知展示)。　

### 部署Github源码

使用第三方评论插件的话，就无需使用 Valine 自带邮件提醒插件。在配置文件 `config.toml` 中把 `notify` 设置为 `false`。

进入 [Leancloud](https://leancloud.cn/dashboard/applist.html#/apps) 对应的 `Valine` 应用中，点击 `云引擎 -> 设置` 填写代码库并保存：`https://github.com/zhaojun1998/Valine-Admin`

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/1.png)

　　切换到部署标签页，选择 `Git 源码部署`

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/2.png)

　　分支使用 `master`，点击部署即可

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/3.png)

　　可以在 `云引擎 -> 应用日志` 查看部署日志信息

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/4.png)



## 配置

　　此外，你需要设置云引擎的环境变量以提供必要的信息，点击 `云引擎 -> 设置`，找到 `自定义环境变量`

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/5.png)

**必选参数**

- `SITE_NAME` : 网站名称。
- `SITE_URL` : 网站地址， **最后不要加 `/` 。**
- `SMTP_USER` : SMTP 服务用户名，一般为邮箱地址。
- `SMTP_PASS` : SMTP 密码，一般为授权码，而不是邮箱的登陆密码，请自行查询对应邮件服务商的获取方式
- `SMTP_SERVICE` : 邮件服务提供商，支持 `QQ`、`163`、`126`、`Gmail`、`"Yahoo"`、`......` ，全部支持请参考 : [Nodemailer Supported services](https://nodemailer.com/smtp/well-known/#supported-services)。 — *如这里没有你使用的邮件提供商，请查看自定义邮件服务器*
- `SENDER_NAME` : 寄件人名称。



### 邮箱开启 SMTP 服务

　　想要使用第三方邮件提醒，必须将 `SMTP_USER` 中的邮箱开启 SMTP 服务，这里以 QQ 邮箱为例：

　　然后将 `邮箱地址` 设置至 `SMTP_USER`，`邮箱授权码` 设置至 `SMTP_PASS`，`SMTP_SERVICE` 中填写 `QQ`

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/6.png)



### 其他功能

- `TEMPLATE_NAME`：设置提醒邮件的主题，目前内置了两款主题，分别为 `default` 与 `rainbow`。默认为 `default` 。

- `TO_EMAIL`：这个是填收邮件提醒的邮箱地址，若没有这个字段，则邮件将发到`SMTP_USER`。

　　如果 `SMTP_SERVICE` 中没有你使用的邮件服务提供商, 也可以进行自定义。

　　参数配置如下：

- `SMTP_HOST` : 邮件服务提供商 SMTP 地址，如 qq : `smtp.qq.com`，*此项需要自行查询或询问其服务商*。
- `SMTP_PORT` : 邮件服务提供商 SMTP 端口, *此项需要自行查询或询问其服务商*。
- `SMTP_SECURE` : 是否启用加密, 默认为 `true`，一般不需要设置，如有特殊请自行配置。 *此项需要自行查询或询问其服务商*。

> 注: 配置自定义邮件服务器的话，请不要同时配置 SMTP_SERVICE。当 SMTP_SERVICE 未配置时才会启用自定义邮件服务



### 关闭LeanCloud 休眠

　　免费版的 LeanCloud 容器，是有强制性休眠策略的，不能 24 小时运行：

- 每天必须休眠 6 个小时
- 30 分钟内没有外部请求，则休眠。
- 休眠后如果有新的外部请求实例则马上启动（但激活时此次发送邮件会失败）。

　　分析了一下上方的策略，如果不想付费的话，最佳使用方案就设置定时器，每天 7 - 23 点每 20 分钟访问一次，这样可以保持每天的绝大多数时间邮件服务是正常的。

　　首先需要先配置下 Web 主机的域名，使用定时器时要用到。配置方式如下。

　　点击 `云引擎 -> 设置`，找到 `Web 主机域名`

> 此处如果要设置自定义的 Web 主机域名，根据中国大陆有关法律法规，国内用户绑定独立域名前必须先域名备案。

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/7.png)

#### 使用自带定时器

　　首先需要添加环境变量，`ADMIN_URL`：`Web 主机域名`，如图所示（添加后重启容器才会生效）：

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/8.png)

　　然后点击云引擎 - 定时任务，新增定时器，按照图片上填写：

- 定时任务名称：自定义
- 选择生成环境：self_wake
- Cron 表达式：定时器触发代码，表示 7点 ~ 23点每20分钟执行一次
![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/9.png)

　　添加后要记得**点击启用**，启用状态如下：

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/10.png)

　　启用成功后，每 20 分钟在 `云引擎 -> 应用日志` 中可以看到日志。

> **注意：更新新版本与更改环境变量均需要重启容器后生效。**

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/11.png)

### LeanCloud 评论管理

　　LeanCloud 提供了一套评论管理后台，该后台登录需要账号密码，需要在这里设置，只需要填写 `email`、`password`、`username`，这三个字段即可, 使用 `email` 作为账号登陆即可。（为了安全考虑，此 `email` 必须为配置中的 `SMTP_USER` 或 `TO_EMAIL`， 否则不允许登录）

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/12.png)

　　访问自己的 Web 主机域名，效果如下：


![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/13.png)

　　使用已设置好的账号密码登录即可管理评论。

## 完工

　　此时，我们在站点发表评论以后，邮箱中就会收到提醒信息啦。

![img](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/ValineComments/14.png)


