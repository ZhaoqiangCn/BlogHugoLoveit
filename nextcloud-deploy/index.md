#  在宝塔面板部署Nextcloud服务


<!--more-->

之前，我用centos7.4 + nginx + [php](https://www.chyiyang.cn/tag/php/)7.2 + MariaDB的环境安装了[Nextcloud](https://www.chyiyang.cn/tag/nextcloud/)14，之后版本大更新，想升级到Nextcloud15，结果不知道按错了按钮还是什么的，把Nextcloud直接给弄崩溃了，直接登录不进去。一气之下，安装了[宝塔](https://www.chyiyang.cn/tag/bt/)面板后，直接安装Nextcloud15。

Nextcloud15在宝塔面板安装环境为PHP7.2 + [SQL](https://www.chyiyang.cn/tag/sql/)5.6 + [Nginx](https://www.chyiyang.cn/tag/nginx/), 接下来，介绍在宝塔面板环境下如何安装Nextcloud。  
1、在网站栏目下添加站点信息。  
[![](https://img.chyiyang.net/images/2019/01/25/QQ20190125221511.png)](https://img.chyiyang.net/images/2019/01/25/QQ20190125221511.png)  
2、在文件栏目下，切换到wwwroot目录下，添加下载好的nextclou.zip包。  
[![](https://img.chyiyang.net/images/2019/01/25/12.png)](https://img.chyiyang.net/images/2019/01/25/12.png)  
也可以选择远程下载，加入下载地址  
[![](https://img.chyiyang.net/images/2019/01/26/130.png)](https://img.chyiyang.net/images/2019/01/26/130.png)  
3、选择上传的zip包，解压到当前目录。  
[![](https://img.chyiyang.net/images/2019/01/25/123.png)](https://img.chyiyang.net/images/2019/01/25/123.png)  
4、清空新建站点下的所有文件，并将nextcloud内的所有文件复制到站点里。  
[![](https://img.chyiyang.net/images/2019/01/26/12222.png)](https://img.chyiyang.net/images/2019/01/26/12222.png)  
[![](https://img.chyiyang.net/images/2019/01/26/134.png)](https://img.chyiyang.net/images/2019/01/26/134.png)  
5、在数据库栏下，添加数据库，输入数据库名、用户名及密码。  
[![](https://img.chyiyang.net/images/2019/01/26/145.png)](https://img.chyiyang.net/images/2019/01/26/145.png)  
6、在浏览器下输入站点地址后，提示下面的错误。

1. 内部服务器错误
2. 服务器不能完成你的请求.
3. 如果多次出现这个错误, 请联系服务器管理员, 请把下面的技术细节包含在您的报告中.
4. 更多细节可以在服务器日志中找到.

[![](https://img.chyiyang.net/images/2019/01/26/136.png)](https://img.chyiyang.net/images/2019/01/26/136.png)  
上面的问题是由于文件夹权限设置的不到位。  
[![](https://img.chyiyang.net/images/2019/01/26/166.png)](https://img.chyiyang.net/images/2019/01/26/166.png)  
站点权限为755，将站点权限改为770.  
[![](https://img.chyiyang.net/images/2019/01/26/125.png)](https://img.chyiyang.net/images/2019/01/26/125.png)  
7、再次在浏览器输入站点地址，出现如下画面  
[![](https://img.chyiyang.net/images/2019/01/26/126.png)](https://img.chyiyang.net/images/2019/01/26/126.png)  
8、分别输入管理员账号及密码，选择数据库并输入数据库用户名、密码及数据库名称，最后点击安装完成。  
[![](https://img.chyiyang.net/images/2019/01/26/127.png)](https://img.chyiyang.net/images/2019/01/26/127.png)  
9、安装完成后，自动跳转到如下界面。  
[![](https://img.chyiyang.net/images/2019/01/26/128.png)](https://img.chyiyang.net/images/2019/01/26/128.png)  


