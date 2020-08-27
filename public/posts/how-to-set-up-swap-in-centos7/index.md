# 如何在Centos7中增加Swap交换分区


<!--more-->

## **增加Swap交换分区**

切换到root用户
`sudo -i`

创建一个1G大小的虚拟磁盘
`dd if=/dev/zero of=/swapfile bs=1M count=1024`
一般建议Swap为内存大小的2倍, 我这设置的1G.
if: 输入文件
/dev/zero: 造0器
of: 输出
bs: 块大小
count: 块数

格式化
`mkswap -f /swapfile`

修改权限
`chmod 0600 /swapfile`

挂载swap
`swapon /swapfile`

查看是否有swap分区
`free -m`

**如需卸载, 使用命令:** `swapoff /swapfile`

到这一步基本已经完成了.
不过系统重启后需要手动挂载swap文件.
如果想让系统重启后自动挂载, 需要修改配置文件`vim /etc/fstab`:

在最后一行添加
`/swapfile none swap sw 0 0`

## **优化**

### **swappiness**

swappiness参数控制换出运行时内存的相对权重. 范围0-100, 默认为60. 低的参数值会让内核尽量少用交换，更高的参数值会使内核更多的去使用交换空间. 这里我们设为10.
`sysctl vm.swappiness=10` 临时设置, 重启失效

编辑启动配置 `vim /etc/sysctl.conf`, 在最后一行添加 `vm.swappiness=10`

### **vfs_cache_pressure**

vfs_cache_pressure设置内核回收用于directory和inode cache内存的倾向, 默认为100, 我们设为50.

`sysctl vm.vfs_cache_pressure=50` 临时设置, 重启失效

编辑启动配置 `vim /etc/sysctl.conf`, 最后一行添加 `vm.vfs_cache_pressure = 50`
