# 用 Hugo 配合 Valine 实现简洁的评论交互


<!--more-->
>**本文同步更新至 [Youtube ](https://youtu.be/U7fpUaGrt8o) 和 [BiliBili ](https://www.bilibili.com/video/av84392015/)**

## Leancloud相关配置

评论系统依赖于leancloud，所以需要先在leancloud中进行相关的准备工作。

- [登录](https://leancloud.cn/dashboard/login.html#/signin) 或 [注册](https://leancloud.cn/dashboard/login.html#/signup) LeanCloud

- 登录成功后，进入后台点击左上角的创建应用：

  ![img](https://pichome-1254392422.cos.ap-chengdu.myqcloud.com/20180708153104380829479.png)

- 进入应用，左边栏找到【设置】【应用Key】
记录 App ID，App Key 后面配置文件中会用到：
- 建立两个新的存储,因为评论和文章阅读数统计依赖于存储Class
- 创建两个存储Class，分别命名为: `Counter` 和 `Comment`;
  ![img](https://pichome-1254392422.cos.ap-chengdu.myqcloud.com/20180708153104475972323.png)
- 为应用添加安全域名，左边栏点击【设置】【安全中心】【安全域名】
输入博客使用的域名，点击保存即可：
  ![img](https://pichome-1254392422.cos.ap-chengdu.myqcloud.com/20180708153104592457270.png)

## config.toml添加参数

为了使配置更灵活，将 **Valine** 中大部分初始化参数项均设置为配置文件中的参数项，在 **config.toml** 的适当位置，比如我的文件中 **[params.gitment]** 的下面：

```toml
  [params.gitment]          # Gitment is a comment system based on GitHub issues. see https://github.com/imsun/gitment
    owner = ""              # Your GitHub ID
    repo = ""               # The repo to store comments
    clientId = ""           # Your client ID
    clientSecret = ""       # Your client secret

  # 这里添加Valine的相关参数
```

添加 **Valine** 参数项：

```toml
  # Valine.
  # You can get your appid and appkey from https://leancloud.cn
  # more info please open https://valine.js.org
  [params.valine]
    enable = true
    appId = '你的appId'
    appKey = '你的appKey'
    notify = false  # mail notifier , https://github.com/xCss/Valine/wiki
    verify = false # Verification code
    avatar = 'mm' 
    placeholder = '说点什么吧...'
    visitor = true
```

上面几项内容的含义，这里简单一说，具体还是要看 [Valine官网中配置相关的内容](https://valine.js.org/configuration.html)：

| 参数       | 用途                                                         |
| ---------- | ------------------------------------------------------------ |
| enable     | 这是用于主题中配置的，不是官方Valine的参数，**true**时控制开启此评论系统 |
| appId      | 这是在 [leancloud](https://leancloud.cn/) 后台应用中获取的，也就是上面提到的 **App ID** |
| appKey     | 这是在 [leancloud](https://leancloud.cn/) 后台应用中获取的，也就是上面提到的 **App Key** |
| notify     | 用于控制是否开启邮件通知功能，具体参考[邮件提醒配置](https://github.com/xCss/Valine/wiki/Valine-评论系统中的邮件提醒设置) |
| verify     | 用于控制是否开启评论验证码功能                               |
| avatar     | 用于配置评论项中用户头像样式，有多种选择：mm, identicon, monsterid, wavatar, retro, hide。详细参考：[头像配置](https://valine.js.org/avatar.html) |
| placehoder | 评论框的提示符                                               |
| visitor    | 控制是否开启文章阅读数的统计功能i, 详情阅读[文章阅读数统计](https://valine.js.org/visitor.html) |

## 修改主题文件

主要是修改主题中评论相关的布局文件 `themes/even/layouts/partials/comments.html`，按照 [Valine快速开始](https://valine.js.org/quickstart.html) 添加 **Valine** 相关代码，找到以下位置，大概55～81行的位置：

```html
  <!-- gitment -->
  {{- if .Site.Params.gitment.enable -}}
  <div id="comments-gitment"></div>
  <!--这里省略了部分代码-->
  <noscript>Please enable JavaScript to view the <a href="https://github.com/imsun/gitment">comments powered by gitment.</a></noscript>
  {{- end }}

  <!--这个位置添加Valine相关代码-->
```

添加的 **Valine** 评论的代码如下：

```html
  <!-- valine -->
  {{- if .Site.Params.valine.enable -}}
  <!-- id 将作为查询条件 -->
  <span id="{{ .URL | relURL }}" class="leancloud_visitors" data-flag-title="{{ .Title }}">
    <span class="post-meta-item-text">文章阅读量 </span>
    <span class="leancloud-visitors-count">1000000</span>
    <p></p>
  </span>
  <div id="vcomments"></div>
  <script src="//cdn1.lncld.net/static/js/3.0.4/av-min.js"></script>
  <script src='//unpkg.com/valine/dist/Valine.min.js'></script>
  <script type="text/javascript">
    new Valine({
        el: '#vcomments' ,
        appId: '{{ .Site.Params.valine.appId }}',
        appKey: '{{ .Site.Params.valine.appKey }}',
        notify: {{ .Site.Params.valine.notify }}, 
        verify: {{ .Site.Params.valine.verify }}, 
        avatar:'{{ .Site.Params.valine.avatar }}', 
        placeholder: '{{ .Site.Params.valine.placeholder }}',
        visitor: {{ .Site.Params.valine.visitor }}
    });
  </script>
  {{- end }}
```

可以看到上述代码中引用了配置文件中的相关参数，这样以后修改配置就不用修改代码了，只需要改配置文件 `config.toml`，另外注意到的是，我也添加了文章阅读数统计的显示内容。将配置文件中 **valine** 配置的 `eanble` 设置为 `true` ，本地测试一下，正常的话，打开一篇文章会看到：

![img](https://pichome-1254392422.cos.ap-chengdu.myqcloud.com/20180708153104555886981.png)

此时，生成静态博客文件，部署到自己的托管平台，正常的话打开博客中的一篇文章，就可以看到正常的文章计数和评论框了，此时随便评论一条，验证一下，评论如果成功，可以去leancloud后台看一下 `Comment` 和 `Counter`存储中新加了相应网址的条目。
