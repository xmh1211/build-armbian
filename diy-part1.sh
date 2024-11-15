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
