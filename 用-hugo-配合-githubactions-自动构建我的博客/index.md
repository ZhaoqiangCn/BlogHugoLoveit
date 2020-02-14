# 用 Hugo 配合 GithubActions 自动构建我的博客


<!--more-->

> ***本文同步更新至 [Youtube ](https://youtu.be/X3ROQto8jWM) 和 [BiliBili ](https://www.bilibili.com/video/av84104625/)***


## 初始化 GitHub 仓库

我们起一个 分支名字叫 develop,用来保存我们的 Hugo 的源码。

然后起一个 `gh-pages` 分支，推送到远端，用来当做我们的 GitHub Pages 展示的分支。

GitHub Pages 其实就是一个静态页面展示的一个地方，他利用生成静态页面，直接通过域名来给用户展示。

```
# git checkout -b gh-pages
# git push origin gh-pages
# git checkout -b develop
# git push origin develop
```

## 初始化 Hugo

如果你已经初始化了 Hugo 项目，可以跳过这一步，直接到 Actions 自动构建

### 下载一个主题

Hugo 的开源主题还是挺多的，你可以通过 [主题官网](https://themes.gohugo.io/) 找一个你比较喜欢的主题来搭建自己的博客。

我们这里用 Even这个主题

```
# git clone https://github.com/olOwOlo/hugo-theme-even themes/even
```

进入 **blog/themes/even/exampleSite** 文件夹，将 **config.tom** 文件拷贝到项目根目录下，同时将 **blog/themes/even/exampleSite/content** 文件夹覆盖掉根目录下的 **content** 。



### 运行看一看你的博客

```
# hugo -D server
```

hugo 编译后，会自动生成一个 public 文件夹的静态页面，我们只需要把 public 文件夹里面的东西，提交到 gh_pages 分支，就能够成功构建 GitHub Pages 页面了。

## Actions 自动构建

这里，我们只需要去监听 develop 是否推送就可以了。

- 构建我们需要做一下流程：
  - 1. 检出代码
  - 1. 安装 Hugo 环境
  - 1. 编译 Hugo
  - 1. 将 public 下的文件夹推送到 gh-pages分支

我们再 `.github/workflows` 里面新建一个 gh_pages.yml

```
name: GitHub Page Deploy

on:
  push:
    branches:
      - develop
jobs:
  build-deploy:
    runs-on: ubuntu-18.04
    steps:
      - name: Checkout master
        uses: actions/checkout@v1
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.61.0'
          # extended: true

      - name: Build Hugo
        run: |
          hugo

      - name: Deploy Hugo to gh-pages
        uses: peaceiris/actions-gh-pages@v2
        env:
          ACTIONS_DEPLOY_KEY: ${{ secrets.ACTIONS_DEPLOY_KEY }}
          PUBLISH_BRANCH: gh-pages
          PUBLISH_DIR: ./public
```

这些 action 统统可以在 github actions marketplace 里面找到。

我们要巧妙的去搜索一些关于 uses 的一些 actions 这样可以极大的节省我们去写 shell 的时间。

上面代码中，只要配几个参数就可以用。参数之中， 需要我们的秘钥去推送到 gh-pages 分支，使用的是加密变量，需要在项目的settings/secrets菜单里面设置。

具体 我们可以看 [peaceiris/actions-gh-pages@v2](https://github.com/peaceiris/actions-gh-pages) 的文档，里面告诉了我们如何加入到 secrets 里面。

- **特别注意** 我们要去对着 [peaceiris/actions-gh-pages@v2](https://github.com/peaceiris/actions-gh-pages) 去看如何生成，以及加入加密变量。

`ACTIONS_DEPLOY_KEY` 一定要加入到 secrets 里面，否则构建推送会失败。

## 推送到Github
```text
#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo -t even

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin develop
```

执行上面的代码后，Github 收到PUSH后Actions 就会自动开始构建了，等待结束大约1分钟不到即可打开网站域名试试吧。

