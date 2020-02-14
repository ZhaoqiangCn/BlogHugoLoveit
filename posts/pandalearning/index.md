# 学习强国


<!--more-->

### 创建GCP实例

默认 Debian9 系统，以下代码均在此系统下操作 

### 安装chromium

 编辑`/etc/apt/sources.list`文件并加入下面这句

```text
deb http://dl.google.com/linux/chrome/deb/ stable main
```

保存并退出后执行

```text
----------------------
$ wget https://dl-ssl.google.com/linux/linux_signing_key.pub
$ sudo apt-key add linux_signing_key.pub
$ sudo apt-get update
$ sudo apt-get install google-chrome-stable
----------------------
```

安装Chromium

```text
sudo apt-get update 
sudo apt-get install chromium chromium-l10n
```

### 安装chromedriver

#### 下载chromedriver

根据chrome浏览器的版本对应下载driver驱动的版本：   
下载地址：[http://chromedriver.storage.googleapis.com/index.html](http://chromedriver.storage.googleapis.com/index.html)

```text
wget http://chromedriver.storage.googleapis.com/73.0.3683.68/chromedriver_linux64.zip
sudo apt-get install unzip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
```

### 安装xvfb

```text
sudo apt-get install xvfb
```

### 安装Python3

#### 安装make

```text
apt-get install gcc automake autoconf libtool make
```

#### 安装python

在我们安装任何软件之前，通过在终端中运行以下apt-get命令来确保您的系统是最新的非常重要：

```text
apt-get update
apt-get upgrade
```

使用python官方站点的以下命令下载Python

```text
cd /usr/src
wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
sudo tar xzf Python-3.7.2.tgz
```

接下来，在您的系统上编译python源代码

```text
cd Python-3.7.2
sudo ./configure --enable-optimizations
sudo make altinstall
```

完成该过程后，请检查Python 3的版本

```python
python3.7 -V
```

#### 安装pip3

下载get-pip.py文件

```text
wget https://bootstrap.pypa.io/get-pip.py
python3  get-pip.py  //安装pip3
python  get-pip.py   //安装pip2
```

#### 安装Selenium

```text
pip3 install selenium
```

#### 执行

```text
PYTHONIOENCODING=utf-8 python3 Panda-Learning-2.5/'Source Packages'/pandalearning.py 13482308316
```
