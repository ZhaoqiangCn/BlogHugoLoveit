#  同时部署 Hugo 静态博客到 Netlify 和 Github Pages


<!--more-->
>**本文同步更新至 [Youtube ](https://youtu.be/ZAi4a1fyBWI) 和 [BiliBili ](https://www.bilibili.com/video/av84216011/)**

## 部署到Github Pages

请参照 [用 Hugo 配合 GithubActions 自动构建我的博客]({{< ref "Hugo-Github-Actions.md" >}})

## 设置Even主题子模块化

在网站根目录下输入添加主题子模块的命令：

```
git submodule add https://github.com/zhaoqiangcn/hugo-theme-even.git themes/even
```

如果在网站根目录下出现 *.gitmodules* 文件，且内容跟我的类似，则表示成功：

```
[submodule "themes/even"]
	path = themes/even
	url = https://github.com/zhaoqiangcn/hugo-theme-even.git
```

然后 进入主题文件夹 *git push* 到远程仓库即可。

## 部署



![1](https://d33wubrfki0l68.cloudfront.net/0e9f9cefe968382536d4e4baa66e49945ad2694c/e20ef/images/hosting-and-deployment/hosting-on-netlify/netlify-signup.jpg)

![2](https://d33wubrfki0l68.cloudfront.net/1a92de85be074abc024967fa7088c8b719c32466/f7496/images/hosting-and-deployment/hosting-on-netlify/netlify-add-new-site.jpg)

![3](https://d33wubrfki0l68.cloudfront.net/742c7be22b24a5df82a39f7cd259a04a7abdd150/db696/images/hosting-and-deployment/hosting-on-netlify/netlify-create-new-site-step-1.jpg)

![4](https://d33wubrfki0l68.cloudfront.net/188f9bfa9eb4997757414ec0ac1979d7111c9741/8f7a6/images/hosting-and-deployment/hosting-on-netlify/netlify-create-new-site-step-2.jpg)

![5](https://d33wubrfki0l68.cloudfront.net/a9f55d92792a554cb775cd0d10eddf445338b83a/0a424/images/hosting-and-deployment/hosting-on-netlify/netlify-deploying-site.gif)


跟官网宣传的一样，部署 Hugo 网站到 Netlify 非常简单，跟着导航操作即可。

经过部署后已经可以通过 Netlify 分配的域名来访问网站了

## 自定义域名

对于想对网站使用**主域名**而言，自定义域名很简单：

1. 找到 *Domain settings* 选项卡，点击进入域名设置
2. 在 *Custom domains* 一项下点击 *Add domain alias* 来添加自定义域名
3. 在弹出来的输入框输出主域名即可
4. 在域名商处添加如下的 DNS 记录，等待 DNS 刷新，看到主域名处出现 *NETLIFY DNS* 的墨绿色标志即代表成功

```
dns1.p01.nsone.net
dns2.p01.nsone.net
dns3.p01.nsone.net
dns4.p01.nsone.net
```

## 开启 HTTPS

在 *HTTPS* 选项卡下的 *SSL/TLS certificate* 选项开启即可。

证书的签发者为 *Let’s Encrypt*，支持自动续期。也可以自定义别的签发者。

如果想在 *Chrome* 地址栏里看到小绿锁（小灰锁），还需要把所有链接都替换成以 *https://* 开头的链接。

接着在页面按下 *F12* 来打开开发者工具，并切换到 *Network*，刷新页面，查看有什么请求不是以 *https://* 发出的，修改相关页面来替换。

