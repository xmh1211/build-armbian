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
echo 'f927e86044686b2ce4b806f436e32ca1' > vermagic

sed -i '121 s/grep/#grep/g' include/kernel-defaults.mk

awk 'NR==121 {print; print "        cp $(TOPDIR)/vermagic $(LINUX_DIR)/.vermagic'\''"; next} 1' include/kernel-defaults.mk > tmp && mv tmp include/kernel-defaults.mk

sed -i 's/ImmortalWrt/X-WRT/g' package/base-files/files/bin/config_generate

sed -i 's/UTC/CST-8/g' package/base-files/files/bin/config_generate

awk 'NR==316 {print; print "                set system.@system[-1].zonename='\''Asia/Shanghai'\''"; next} 1' package/base-files/files/bin/config_generate > tmp && mv tmp package/base-files/files/bin/config_generate

sed -i 's/lan) ipad=${ipaddr:-"192.168.1.1"} ;;/lan) ipad=${ipaddr:-"192.168.100.1"} ;;/g' package/base-files/files/bin/config_generate
