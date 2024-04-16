#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='ImmortalWrt'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='OpenWrt $(date +"%Y%m%d%M")'/g" package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By JayKwok'/g" package/base-files/files/etc/openwrt_release
rm -rf package/base-files/files/etc/banner
cp -af feeds/extraipk/patch/diy/banner  package/base-files/files/etc/banner
##New WiFi
sed -i "s/ImmortalWrt-2.4G/OpenWrt_2.4G/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i "s/ImmortalWrt-5G/OpenWrt_5G/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
##更新FQ
rm -rf feeds/luci/applications/luci-app-passwall/*
cp -af feeds/extraipk/patch/wall-luci/luci-app-passwall/*  feeds/luci/applications/luci-app-passwall/

rm -rf feeds/luci/applications/luci-app-openclash/*
cp -af feeds/extraipk/patch/wall-luci/luci-app-openclash/*  feeds/luci/applications/luci-app-openclash/


##MosDNS
rm -rf feeds/packages/net/mosdns/*
cp -af feeds/extraipk/op-mosdns/mosdns/* feeds/packages/net/mosdns/
rm -rf feeds/packages/net/v2ray-geodata/*
cp -af feeds/extraipk/op-mosdns/v2ray-geodata/* feeds/packages/net/v2ray-geodata/
echo "DISTRIB_MODEL='360T7'" >> package/base-files/files/etc/openwrt_release
target=$(grep -m 1 "CONFIG_TARGET_.*_.*=y" .config | sed "s/CONFIG_TARGET_\(.*\)_\(.*\)=y/\1\/\2/g")
for configFile in $(ls target/linux/$target/config*)
do
    echo -e "\nCONFIG_NETFILTER_NETLINK_GLUE_CT=y" >> $configFile
done
