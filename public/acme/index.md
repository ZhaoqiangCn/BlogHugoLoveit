# 使用 ACME 免费申请 Let's Encrypt 证书


<!--more-->

## 1. 安装 **acme.sh**

安装很简单, 一个命令:

```text
curl  https://get.acme.sh | sh
```

普通用户和 root 用户都可以安装使用. 安装过程进行了以下几步:

1. 把 acme.sh 安装到你的 **home** 目录下:

```text
~/.acme.sh/
```

并创建 一个 bash 的 alias, 方便你的使用: `alias acme.sh=~/.acme.sh/acme.sh`

2\). 自动为你创建 cronjob, 每天 0:00 点自动检测所有的证书, 如果快过期了, 需要更新, 则会自动更新证书.

更高级的安装选项请参考: [https://github.com/Neilpang/acme.sh/wiki/How-to-install](https://github.com/Neilpang/acme.sh/wiki/How-to-install)

**安装过程不会污染已有的系统任何功能和文件**, 所有的修改都限制在安装目录中: `~/.acme.sh/`

## 2. 生成证书

**acme.sh** 实现了 **acme** 协议支持的所有验证协议. 一般有两种方式验证: http 和 dns 验证.

#### 1. http 方式需要在你的网站根目录下放置一个文件, 来验证你的域名所有权,完成验证. 然后就可以生成证书了.

```text
acme.sh  --issue  -d mydomain.com -d www.mydomain.com  --webroot  /home/wwwroot/mydomain.com/
```

只需要指定域名, 并指定域名所在的网站根目录. **acme.sh** 会全自动的生成验证文件, 并放到网站的根目录, 然后自动完成验证. 最后会聪明的删除验证文件. 整个过程没有任何副作用.

如果你用的 **apache**服务器, **acme.sh** 还可以智能的从 **apache**的配置中自动完成验证, 你不需要指定网站根目录:

```text
acme.sh --issue  -d mydomain.com   --apache
```

如果你用的 **nginx**服务器, 或者反代, **acme.sh** 还可以智能的从 **nginx**的配置中自动完成验证, 你不需要指定网站根目录:

```text
acme.sh --issue  -d mydomain.com   --nginx
```

**注意, 无论是 apache 还是 nginx 模式, acme.sh在完成验证之后, 会恢复到之前的状态, 都不会私自更改你本身的配置. 好处是你不用担心配置被搞坏, 也有一个缺点, 你需要自己配置 ssl 的配置, 否则只能成功生成证书, 你的网站还是无法访问https. 但是为了安全, 你还是自己手动改配置吧.**

如果你还没有运行任何 web 服务, **80** 端口是空闲的, 那么 **acme.sh** 还能假装自己是一个webserver, 临时听在**80** 端口, 完成验证:

```text
acme.sh  --issue -d mydomain.com   --standalone
```

更高级的用法请参考: [https://github.com/Neilpang/acme.sh/wiki/How-to-issue-a-cert](https://github.com/Neilpang/acme.sh/wiki/How-to-issue-a-cert)

#### 2. 手动 dns 方式, 手动在域名上添加一条 txt 解析记录, 验证域名所有权.

这种方式的好处是, 你不需要任何服务器, 不需要任何公网 ip, 只需要 dns 的解析记录即可完成验证. 坏处是，如果不同时配置 Automatic DNS API，使用这种方式 acme.sh 将无法自动更新证书，每次都需要手动再次重新解析验证域名所有权。

```text
acme.sh  --issue  --dns   -d mydomain.com
```

然后, **acme.sh** 会生成相应的解析记录显示出来, 你只需要在你的域名管理面板中添加这条 txt 记录即可.

等待解析完成之后, 重新生成证书:

```text
acme.sh  --renew   -d mydomain.com
```

注意第二次这里用的是 `--renew`

dns 方式的真正强大之处在于可以使用域名解析商提供的 api 自动添加 txt 记录完成验证.

**acme.sh** 目前支持 cloudflare, dnspod, cloudxns, godaddy 以及 ovh 等数十种解析商的自动集成.

以 dnspod 为例, 你需要先登录到 dnspod 账号, 生成你的 api id 和 api key, 都是免费的. 然后:

```text
export DP_Id="1234"

export DP_Key="sADDsdasdgdsf"

acme.sh   --issue   --dns dns_dp   -d aa.com  -d www.aa.com

```

证书就会自动生成了. 这里给出的 api id 和 api key 会被自动记录下来, 将来你在使用 dnspod api 的时候, 就不需要再次指定了. 直接生成就好了:

```text
acme.sh  --issue   -d  mydomain2.com   --dns  dns_dp
```

更详细的 api 用法: [https://github.com/Neilpang/acme.sh/blob/master/dnsapi/README.md](https://github.com/Neilpang/acme.sh/blob/master/dnsapi/README.md)

First you need to login to your Aliyun account to get your API key. [https://ak-console.aliyun.com/\#/accesskey](https://ak-console.aliyun.com/#/accesskey)

```text
export Ali_Key="sdfsdfsdfljlbjkljlkjsdfoiwje"
export Ali_Secret="jlsdflanljkljlfdsaklkjflsa"
```

Ok, let's issue a cert now:

```text
acme.sh --issue --dns dns_ali -d example.com -d www.example.com
```

The `Ali_Key` and `Ali_Secret` will be saved in `~/.acme.sh/account.conf` and will be reused when needed.

## 3. copy/安装 证书

前面证书生成以后, 接下来需要把证书 copy 到真正需要用它的地方.

注意, 默认生成的证书都放在安装目录下: `~/.acme.sh/`, 请不要直接使用此目录下的文件, 例如: 不要直接让 nginx/apache 的配置文件使用这下面的文件. 这里面的文件都是内部使用, 而且目录结构可能会变化.

正确的使用方法是使用 `--installcert` 命令,并指定目标位置, 然后证书文件会被copy到相应的位置, 例如:

```text
acme.sh  --installcert  -d  <domain>.com   \
        --key-file   /etc/nginx/ssl/<domain>.key \
        --fullchain-file /etc/nginx/ssl/fullchain.cer \
        --reloadcmd  "service nginx force-reload"
```

\(一个小提醒, 这里用的是 `service nginx force-reload`, 不是 `service nginx reload`, 据测试, `reload` 并不会重新加载证书, 所以用的 `force-reload`\)

Nginx 的配置 `ssl_certificate` 使用 `/etc/nginx/ssl/fullchain.cer` ，而非 `/etc/nginx/ssl/<domain>.cer` ，否则 [SSL Labs](https://www.ssllabs.com/ssltest/) 的测试会报 `Chain issues Incomplete` 错误。

`--installcert`命令可以携带很多参数, 来指定目标文件. 并且可以指定 reloadcmd, 当证书更新以后, reloadcmd会被自动调用,让服务器生效.

详细参数请参考: [https://github.com/Neilpang/acme.sh\#3-install-the-issued-cert-to-apachenginx-etc](https://github.com/Neilpang/acme.sh#3-install-the-issued-cert-to-apachenginx-etc)

值得注意的是, 这里指定的所有参数都会被自动记录下来, 并在将来证书自动更新以后, 被再次自动调用.

## 4. 更新证书

目前证书在 60 天以后会自动更新, 你无需任何操作. 今后有可能会缩短这个时间, 不过都是自动的, 你不用关心.

## 5. 更新 acme.sh

目前由于 acme 协议和 letsencrypt CA 都在频繁的更新, 因此 acme.sh 也经常更新以保持同步.

升级 acme.sh 到最新版 :

```text
acme.sh --upgrade
```

如果你不想手动升级, 可以开启自动升级:

```text
acme.sh  --upgrade  --auto-upgrade
```

之后, acme.sh 就会自动保持更新了.

你也可以随时关闭自动更新:

```text
acme.sh --upgrade  --auto-upgrade  0
```

## 6. 出错怎么办：

如果出错, 请添加 debug log：

```text
acme.sh  --issue  .....  --debug 
```

或者：

```text
acme.sh  --issue  .....  --debug  2
```

请参考： [https://github.com/Neilpang/acme.sh/wiki/How-to-debug-acme.sh](https://github.com/Neilpang/acme.sh/wiki/How-to-debug-acme.sh)

最后, 本文并非完全的使用说明, 还有很多高级的功能, 更高级的用法请参看其他 wiki 页面.

[https://github.com/Neilpang/acme.sh/wiki](https://github.com/Neilpang/acme.sh/wiki)
