# 使用 GitHub Actions 编译 OpenWrt


<!--more-->

## 前言

Github Ac­tions 是 GitHub 推出的持续集成 (Con­tin­u­ous in­te­gra­tion，简称 CI) 服务，它提供了配置非常不错的[虚拟服务器环境](https://p3terx.com/archives/github-actions-virtual-environment-simple-evaluation.html)（E5 2vCPU/7G RAM），基于它可以进行构建、测试、打包、部署项目。对于公共仓库可免费无时间限制的使用（指累积时间），不过要使用它首先需要知道[如何编写 workflow 文件](https://p3terx.com/archives/github-actions-started-tutorial.html)。但这篇文章并不是教你如何枯燥的去编写 work­flow 文件，而是教你如何去使用博主已经编写好的 Open­Wrt 编译解决方案。

## 教程更新

关注 [GitHub Actions Channel](https://p3terx.com/go/aHR0cHM6Ly90Lm1lL0dpdEh1Yl9BY3Rpb25zX0NoYW5uZWw=) 获得最新情报

- 2019-12-10 新增 **macOS 虚拟机编译**使用说明
- 2019-12-06 添加 tmate 网页终端链接说明
- 2019-12-05 优化基础使用教程，添加 @lietxia 大佬的图文教程链接
- 2019-12-04 新增**云menuconfig**使用方法
- 2019-12-03 新增**并发编译**使用方法
- 2019-11-30 新增**自定义源码编译**使用方法
- 2019-11-14 全网独家首发

## 方案特点

- 免费
- 一键快速编译
- 定时自动编译
- 客制化编译
- 并发编译（可同时进行20+5个编译任务）
- 无需搭建编译环境（在线`make menuconfig`生成配置文件)
- 无需消耗自己的计算机与服务器的计算资源（性感E5在线编译）
- 无需担心磁盘空间不足（近60G磁盘空间）
- 无需使用清理文件（内核更新不怕 boom ）
- 编译速度快（编译时间1-2小时）
- 全新环境（杜绝编译环境不干净导致编译失败）

> 本解决方案是一个开放平台，任何人都可以基于此打造自己专属的编译方案。

## 项目地址

[https://github.com/P3TERX/Actions-OpenWrt](https://p3terx.com/go/aHR0cHM6Ly9naXRodWIuY29tL1AzVEVSWC9BY3Rpb25zLU9wZW5XcnQ=)

> **喜欢的小伙伴请点击`star`哦~**

## 准备工作

- 注册 [GitHub](https://p3terx.com/go/aHR0cHM6Ly9naXRodWIuY29t) 账号并[开启 GitHub Actions 使用权限](https://p3terx.com/go/aHR0cHM6Ly9naXRodWIuY29tL2ZlYXR1cmVzL2FjdGlvbnMvc2lnbnVw)
- 搭建编译环境，用于生成`.config`文件。(可选)

> **TIPS:** 关于编译环境的搭建，推荐去看我之前写的相关文章，Win­dows 10 可以使用 [WSL](https://p3terx.com/archives/compiling-openwrt-with-wsl.html) ，ma­cOS、Linux 可以使用 [Docker](https://p3terx.com/archives/build-openwrt-with-docker.html) 。

## 基础使用

### 默认配置编译

**难度：** ⭐

**门槛：** 基础计算机技能

使用 L 大钦定的配置进行编译，默认是 x86_64 平台。如果你刚好在使用软路由又懒得折腾，那么这是最好的选择。紧跟 L 大的步伐，随时随地进行编译。

> **TIPS:** 默认引用L大的源码，有其它需求可自行修改 work­flow 文件，方法后面的进阶使用中有说明。

- fork [这个仓库](https://p3terx.com/go/aHR0cHM6Ly9naXRodWIuY29tL1AzVEVSWC9BY3Rpb25zLU9wZW5XcnQ=)
- 在 releases 页面发布一个 release 编译工作就会自动开始，在 Actions 页面可以查看编译进度。
- 进入[这个页面](https://p3terx.com/go/aHR0cHM6Ly9naXRodWIuY29tL1AzVEVSWC9BY3Rpb25zLU9wZW5XcnQ=)，点击右上角的`star`按钮可加快编译速度和成功率（大雾
- 编译完成点击 Actions 页面右上角的`Artifacts`按钮下载固件。

### 基础客制化编译

**难度：** ⭐️⭐️⭐️

**门槛：**

- Linux 与 Git 基础知识
- 一次纯手工编译 OpenWrt 成功的经历

如果你不满足于默认的配置或者想编译其它平台的固件，那么就开始你的客制化之旅吧。

- fork [这个仓库](https://p3terx.com/go/aHR0cHM6Ly9naXRodWIuY29tL1AzVEVSWC9BY3Rpb25zLU9wZW5XcnQ=)
- 在自己搭建编译环境中使用 [Lean's OpenWrt](https://p3terx.com/go/aHR0cHM6Ly9naXRodWIuY29tL2Nvb2xzbm93d29sZi9sZWRl) 源码生成`.config`文件。（或使用后面进阶玩法中的**云menuconfig**，直接 SSH 到 Actions 进行操作）
- 把生成好的`.config`文件本地仓库根目录，然后 push 到 GitHub 远程仓库编译工作就会自动开始，在 Actions 页面可以查看编译进度。
- 进入[这个页面](https://p3terx.com/go/aHR0cHM6Ly9naXRodWIuY29tL1AzVEVSWC9BY3Rpb25zLU9wZW5XcnQ=)，点击右上角的`star`按钮可加快编译速度和成功率（大雾
- 编译完成点击 Actions 页面右上角的`Artifacts`按钮下载固件。

如果不明白我在说什么，那么推荐去看 [@lietxia](https://p3terx.com/go/aHR0cHM6Ly9naXRodWIuY29tL2xpZXR4aWE=) 大佬写的[图文并茂的教程](https://p3terx.com/go/aHR0cHM6Ly9naXRodWIuY29tL2Nvb2xzbm93d29sZi9sZWRlL2lzc3Vlcy8yMjg4)。

### 再次编译

**难度：** ⭐️⭐️⭐️⭐️

**门槛：**

- Linux 与 Git 基础知识
- 一次纯手工编译 OpenWrt 成功的经历
- ~~小学语文、英语90分~~

当看见源码有更新，在 re­leases 页面发布一个 re­lease 直接将直接使用最新源码进行编译。

> **TIPS:** 如果你嫌发 re­lease 麻烦，那么可以根据后面的进阶玩法开启**真·一键编译**。

此时如果你想修改配置，那么还是生成`.config` 文件并 push 到仓库触发编译的工作流程。

## 进阶使用

**难度：** ⭐️⭐️⭐️⭐️️⭐️

**门槛：** ∞

### DIY 脚本

仓库内有一个 `diy.sh` 文件，你可以把对源码修改的指令写到这个文件中，比如修改默认 IP、主机名、主题、添加 / 删除软件包等操作。但不仅限于这些操作，发挥你强大的想象力，可做出更强大的功能。

> **TIPS:** 脚本工作目录在源码目录，内附一个修改默认 IP 的例子供参考使用。

### 添加软件包

在 DIY 脚本中加入对指定软件包的远程仓库的克隆指令。就像下面这样：

```none
git clone https://github.com/P3TERX/xxx package/xxx
```

这样做的好处是每一次编译都会拉取最新的源码。

> **TIPS:** 生成`.config`文件时记得选中相应的软件。如果添加的软件包与 Open­Wrt 中已有的软件包同名的情况，则需要把源码中的同名软件包删除，否则会优先编译 Open­Wrt 中的软件包。这同样可以利用到的 DIY 脚本。

### Custom files（自定义文件）

俗称 “files 大法”，在仓库根目录下新建 `files` 目录，把文件放入即可。

### 定时自动编译



<details style="box-sizing: border-box; display: block; color: rgba(0, 0, 0, 0.86); font-family: &quot;Droid Serif&quot;, -apple-system, system-ui, sans-serif; font-size: 18px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer; outline: 0px;">点击查看</summary></details>



### 真·一键编译

点击自己仓库页面上的 Star 开始编译，为了防止被滥用，这个功能默认没有开启。开启后如果被恶意点击轻则封号，严重可能会导致中美关系恶化、原子弹爆炸、第三次世界大战等后果。（大雾



<details style="box-sizing: border-box; display: block; color: rgba(0, 0, 0, 0.86); font-family: &quot;Droid Serif&quot;, -apple-system, system-ui, sans-serif; font-size: 18px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer; outline: 0px;">点击查看</summary></details>



### 自定义源码编译

此方案默认引用的是 L 大的源码，如果你觉得不好用或者有编译其它源码的需求可以进行替换，自由是本解决方案最大的特点。



<details style="box-sizing: border-box; display: block; color: rgba(0, 0, 0, 0.86); font-family: &quot;Droid Serif&quot;, -apple-system, system-ui, sans-serif; font-size: 18px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer; outline: 0px;">点击查看</summary></details>



### 并发编译

基于 GitHub Ac­tions 可同时运行多个工作流程的特性，最多可以同时进行至少 20 个编译任务。也可以单独选择其中一个进行编译，这充分的利用到了 GitHub Ac­tions 为每个账户免费提供的 20 个 Ubuntu 虚拟服务器环境。此外你还可以额外再使用 5 个 ma­cOS 虚拟服务器环境进行编译，开启方法在后面有说明。



<details style="box-sizing: border-box; display: block; color: rgba(0, 0, 0, 0.86); font-family: &quot;Droid Serif&quot;, -apple-system, system-ui, sans-serif; font-size: 18px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer; outline: 0px;">点击查看</summary></details>



### 云 menuconfig（SSH 连接到 Actions）

通过 tmate 连接到 GitHub Ac­tions 虚拟服务器环境，可直接进行 `make menuconfig` 操作生成编译配置，或者任意的客制化操作。也就是说，你不需要再自己搭建编译环境了。这可能改变之前所有使用 GitHub Ac­tions 的编译 Open­Wrt 方式。



<details style="box-sizing: border-box; display: block; color: rgba(0, 0, 0, 0.86); font-family: &quot;Droid Serif&quot;, -apple-system, system-ui, sans-serif; font-size: 18px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer; outline: 0px;">点击查看</summary></details>



### macOS 虚拟机编译

GitHub Ac­tions 的 ma­cOS 虚拟机性能要高于 Ubuntu 虚拟机，所以使用它编译 Open­Wrt 理论上速度会更快。博主经过几天时间的研究已经总结出了 [macOS 下的 OpenWrt 编译环境的搭建方法](https://p3terx.com/archives/compiling-openwrt-with-macos.html)，并编写出了适用于 ma­cOS 虚拟环境的 Open­Wrt 编译方案的 work­flow 文件。



<details style="box-sizing: border-box; display: block; color: rgba(0, 0, 0, 0.86); font-family: &quot;Droid Serif&quot;, -apple-system, system-ui, sans-serif; font-size: 18px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;"><summary style="box-sizing: border-box; display: list-item; cursor: pointer; outline: 0px;">点击查看</summary></details>



## 尾巴

希望大家不要滥用免费的开发资源，需要时再编译，让开发者来充分利用才能产生更多更好的软件，这样大家才能受益。

------

相关 TG 群组：[GitHub Actions Group](https://p3terx.com/go/aHR0cHM6Ly90Lm1lL0dpdEh1Yl9BY3Rpb25z)

欢迎订阅我的 [TG 频道](https://p3terx.com/go/aHR0cHM6Ly90Lm1lL1AzVEVSWF9aT05F)，接收最新的文章推送和有趣的内容。加入 [TG 群组](https://p3terx.com/go/aHR0cHM6Ly90Lm1lL2pvaW5jaGF0L0Q3WjVUVThSdzBwOGRDLWo2YWhvZnc=)，和小伙伴们一同交流、学习、成♂长。

> **本文作者：**[P3TERX](https://p3terx.com/)
>
> **本文链接：**https://p3terx.com/archives/build-openwrt-with-github-actions.html
>
> **版权声明：**本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 4.0](https://p3terx.com/go/aHR0cHM6Ly9jcmVhdGl2ZWNvbW1vbnMub3JnL2xpY2Vuc2VzL2J5LW5jLXNhLzQuMC9kZWVkLnpo) 许可协议。非商业转载及引用请注明出处（作者、原文链接），商业转载请联系作者获得授权。
