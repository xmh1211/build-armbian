#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light

echo 'f927e86044686b2ce4b806f436e32ca1' > vermagic

sed -i 's/grep '=[ym]' $(LINUX_DIR)/.config.set | LC_ALL=C sort | $(MKHASH) md5 > $(LINUX_DIR)/.vermagic/#grep '=[ym]' $(LINUX_DIR)/.config.set | LC_ALL=C sort | $(MKHASH) md5 > $(LINUX_DIR)/.vermagic/g' include/kernel-defaults.mk

sed -i '121 a cp $(TOPDIR)/vermagic $(LINUX_DIR)/.vermagic' include/kernel-defaults.mk

sed -i 's/set system.@system[-1].hostname='ImmortalWrt'/set system.@system[-1].hostname='X-WRT'/g' package/base-files/files/bin/config_generate

sed -i 's/set system.@system[-1].timezone='UTC'/set system.@system[-1].timezone='CST-8'/g' package/base-files/files/bin/config_generate

sed -i '315 a set system.@system[-1].zonename='Asia/Shanghai' package/base-files/files/bin/config_generate

sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate
