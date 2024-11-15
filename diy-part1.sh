#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

#sed用法里面，\t代表一个tab制表符，也就是缩进。
#自行编译时，会出现内核的魔法值不一样，需要完成如下修改。这样的话在系统里更新软件包时就不会产生错误。
#方式一：

#执行以下脚本即可写入到 vermagic 文件中。注意： 23.05-SNAPSHOT 为版本号
#curl -s https://downloads.immortalwrt.org/releases/23.05-SNAPSHOT/targets/rockchip/armv8/immortalwrt-23.05-snapshot-r28094-a8d3d10f4c-rockchip-armv8.manifest | grep kernel | awk '{print $3}' | awk -F- '{print $3}' > vermagic

#方式二：

#打开官方对应版本的下载链接：https://downloads.immortalwrt.org/releases
#点击：23.05-SNAPSHOT -> targets -> rockchip -> armv8
#下载 Supplementary Files 中的 immortalwrt-23.05-snapshot-r28094-a8d3d10f4c-rockchip-armv8.manifest 文件
#使用文本编辑器打开该文件，记录下 kernel 最后面的那串字符串
#执行以下脚本写入到 vermagic 文件中
# 注意：f927e86044686b2ce4b806f436e32ca1 就是上文中的字符串
#echo 'f927e86044686b2ce4b806f436e32ca1' > vermagic
#这里我们用方式二
echo 'f927e86044686b2ce4b806f436e32ca1' > vermagic

#在121行前面加一个#将这行注释掉
sed -i '121 s/grep/#grep/g' include/kernel-defaults.mk

#在121行后面插入一行字符，\t表示与上一行同样的格式，相当于按一次tab键。
sed -i '121a \\tcp $(TOPDIR)/vermagic $(LINUX_DIR)/.vermagic' include/kernel-defaults.mk

#替换主机名ImmortalWrt为X-WRT
sed -i 's/ImmortalWrt/X-WRT/g' package/base-files/files/bin/config_generate

#替换时区UTC为CST-8
sed -i 's/UTC/CST-8/g' package/base-files/files/bin/config_generate

#在316行后面插入一行字符，\t\t表示与上一行同样的格式，相当于按两次tab键。
sed -i '316a \\t\tset system.@system[-1].zonename='Asia/Shanghai'' package/base-files/files/bin/config_generate

#修改lan口默认IP
sed -i '165 s/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate
