# Speedtest Iperf3


<!--more-->

## 群晖安装Iperf3 非docker

### **Synology 群晖 NAS synogear Diagnosis Tool**

```
$ sudo -s
# synogear list
Tools are not installed yet. You can run this command to install it:
   synogear install
   synogear install
   root@nas:~# iperf3
-ash: iperf3: command not found
root@nas:~# synogear install
root@nas:~# iperf3
iperf3: parameter error - must either be a client (-c) or server (-s)

Usage: iperf [-s|-c host] [options]
       iperf [-h|--help] [-v|--version]

Server or Client:
  -p, --port      #         server port to listen on/connect to
  -f, --format    [kmgKMG]  format to report: Kbits, Mbits, KBytes, MBytes
  -i, --interval  #         seconds between periodic bandwidth reports
  -F, --file name           xmit/recv the specified file
  -A, --affinity n/n,m      set CPU affinity
  -B, --bind      <host>    bind to a specific interface
  -V, --verbose             more detailed output
  -J, --json                output in JSON format
  --logfile f               send output to a log file
  -d, --debug               emit debugging output
  -v, --version             show version information and quit
  -h, --help                show this message and quit
Server specific:
  -s, --server              run in server mode
  -D, --daemon              run the server as a daemon
  -I, --pidfile file        write PID file
Client specific:
  -c, --client    <host>    run in client mode, connecting to <host>
  -u, --udp                 use UDP rather than TCP
  -b, --bandwidth #[KMG][/#] target bandwidth in bits/sec (0 for unlimited)
                            (default 1 Mbit/sec for UDP, unlimited for TCP)
                            (optional slash and packet count for burst mode)
  -t, --time      #         time in seconds to transmit for (default 10 secs)
  -n, --bytes     #[KMG]    number of bytes to transmit (instead of -t)
  -k, --blockcount #[KMG]   number of blocks (packets) to transmit (instead of -                                                                                                                                                             t or -n)
  -l, --len       #[KMG]    length of buffer to read or write
                            (default 128 KB for TCP, 8 KB for UDP)
  --cport         <port>    bind to a specific client port (TCP and UDP, default                                                                                                                                                             : ephemeral port)
  -P, --parallel  #         number of parallel client streams to run
  -R, --reverse             run in reverse mode (server sends, client receives)
  -w, --window    #[KMG]    TCP window size (socket buffer size)
  -C, --congestion <algo>   set TCP congestion control algorithm (Linux and Free                                                                                                                                                             BSD only)
  -M, --set-mss   #         set TCP maximum segment size (MTU - 40 bytes)
  -N, --nodelay             set TCP no delay, disabling Nagle's Algorithm
  -4, --version4            only use IPv4
  -6, --version6            only use IPv6
  -S, --tos N               set the IP 'type of service'
  -L, --flowlabel N         set the IPv6 flow label (only supported on Linux)
  -Z, --zerocopy            use a 'zero copy' method of sending data
  -O, --omit N              omit the first n seconds
  -T, --title str           prefix every output line with this string
  --get-server-output       get results from server
  --udp-counters-64bit      use 64-bit counters in UDP test packets

[KMG] indicates options that support a K/M/G suffix for kilo-, mega-, or giga-

iperf3 homepage at: http://software.es.net/iperf/
Report bugs to:     https://github.com/esnet/iperf

root@nas:~# synogear list
All tools:

```



## 电脑安装iperf3

1. 路由器安装iperf3。用ssh或者网页控制台进入路由器后台，然后先执行包更新，再安装iperf3软件，代码如下：

```
1. opkg update
2. opkg install iperf3
```

2.路由器端后台运行iperf3.最好使用后台运行否则测速过程中连接断开，就会中断。代码如下：

```
iperf3 -s -D
```

这里-s 表示运行的是服务器模式，就是测速接收方，-D（大写字母）表示后台运行，断开连接之后还会运行。好了，这样路由器端就弄好了，你可以断开ssh了。


3.电脑或者手机连接上路由器的无线（或者有线，看你测什么速度），然后运行iperf3测速。
软件下载链接如下https://iperf.fr/iperf-download.php
找到适合自己平台的下载下来。如果你是Windows 64位用户，下载这个https://iperf.fr/download/windows/iperf-3.1.3-win64.zip
下载之后解压缩，然后在解压的文件夹目录运行命令提示符CMD，然后执行测速，代码如下：

```
iperf3 -c 192.168.123.1 -b 1000m -t 60 -i 1 -u
```

上面这个讲一下，192.168.123.1是路由器的ip地址，我这里用的是老毛子Padavan固件，请你根据自己的路由器地址进行替换。-c表示运行的是客户端模式，就是测速发送方。 -b表示估计带宽，-t表示持续测速时间，就是一共跑60秒，-i表示间隔输出结果时间，就是每隔1秒钟输出一次，-u表示使用udp连接来测速，默认是tcp连接测速，因为tcp要进行确认所以不如udp测速更准确。当然这里默认使用了单线程，你可以使用多线程命令。

```
iperf3 -c 192.168.123.1 -b 1000m -t 60 -i 1 -u -P 2
```

这里是使用了两个线程来跑。我自己测试下来，如果要用多线程，2-4个最好，太多了路由器吃不消（也可能是我手机吃不消）。

以上方法是从电脑发数据到路由器，测试的是上传速度。同样的你可以在电脑上运行服务端，路由器运行客户端，这样就是测量路由器下载速度了。
有线链接也可以测一下，看看千兆口是不是真的跑到了千兆网速。
