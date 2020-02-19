# NaiveBoom 阅后即焚


<!--more-->

这是一个无需注册即可使用的阅后即焚程序，当你需要在能够被第三方监听的平台，分享一些敏感信息时，可以借助NaiveBoom，将敏感信息以一个一次性链接的形式发送，一旦被人点击，信息即消失了。

## 项目介绍

项目遵循MIT协议开源。
工作环境为：nodejs、redis、Nginx或Apache等（可选）
Github地址：https://github.com/kchown/naiveboom

## 预览
电脑端Web界面预览：
![PNG](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/NaiveBooMImage/diannaoyulan.png)
iOS手机端Web界面预览：		

![PNG](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/NaiveBooMImage/shoujiyulan.png)

基础环境配置
Redis
由于我的VPS本身部署了lnmp 1.5(https://lnmp.org/install.html)，因此也直接使用了其提供的Redis，具体安装过程如下：
![PNG](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/NaiveBooMImage/anzhuangguocheng.png)
进入lnmp解压后的目录，执行：

```text
./addons.sh install redis
```
按任意键开始安装即可。

安装完成后，可以通过
```text
/etc/init.d/redis {start|stop|restart|kill}
```
进行状态管理。

## nodejs 环境
里我选择了Node.js v8.x，系统为Debian 8：

```text
# Using Debian, as root
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs
```
对于一些npm包，可能还需要安装build-essential：

```text
apt-get install build-essential
```
通过PM2我们可以方便地启动和管理Node.js程序：

```text
npm install -g pm2
```
## 部署NaiveBoom

我们将NaiveBoom clone至本地:

```text
git clone https://github.com/kchown/naiveboom.git
```
配置 & 启动
如果你的Redis设置与config.js中的不同，请按照实际进行修改。
然后在NaiveBoom目录下，我们开始安装依赖：

```text
npm install
```
完成后，我们选择PM2进行启动和管理，这样更为方便：

```text
pm2 start run.js
```
如果显示如下画面，那么NaiveBoom已经在正常运行了：
![PNG](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/NaiveBooMImage/pm2.png)
我们此时如果访问http://ip:3000，应该就能正常访问NaiveBoom了！
