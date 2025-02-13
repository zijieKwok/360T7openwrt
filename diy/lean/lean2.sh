#!/bin/bash
#=================================================
# JayKwok's script
#=================================================


#补充汉化
echo -e "\nmsgid \"Control\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"控制\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po

echo -e "\nmsgid \"NAS\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"网络存储\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po

echo -e "\nmsgid \"VPN\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"魔法网络\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po

##补充汉化
echo -e "\nmsgid \"General\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po
echo -e "msgstr \"常规\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po

echo -e "\nmsgid \"LOG\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po
echo -e "msgstr \"日志\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po

              
##配置ip等
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm-k3|TARGET_DEVICES += phicomm-k3| ; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

##清除默认密码password
# sed -i '/V4UetPzk$CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings


##替换K3无线驱动为69027
rm -rf ./package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
cp -af feeds/istoreos_ipk/patch/brcmfmac4366c-pcie.bin ./package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin


##取消bootstrap为默认主题
rm -rf ./feeds/luci/themes/luci-theme-argon
rm -rf ./feeds/luci/themes/luci-theme-design
rm -rf ./feeds/luci/themes/luci-theme-argon-mod

sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile

##加入作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt-$(date +%Y%m%d)'/g" package/lean/default-settings/files/zzz-default-settings   
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By JayKwok'/g" package/lean/default-settings/files/zzz-default-settings
cp -af feeds/istoreos_ipk/patch/diy/banner  package/base-files/files/etc/banner

sed -i "2iuci set istore.istore.channel='OpenWrt_JayKwok'" package/lean/default-settings/files/zzz-default-settings
sed -i "3iuci commit istore" package/lean/default-settings/files/zzz-default-settings

rm -rf feeds/istoreos_ipk/xray-core

# tailscale
# rm -rf feeds/packages/net/tailscale
rm -rf feeds/istoreos_ipk/tailscale/tailscale
# cp -af feeds/istoreos_ipk/tailscale/tailscale  feeds/packages/net/
sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile

##更改主机名
sed -i "s/hostname='.*'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate

### fix speed
sed -i "s/speed = <2500>;/speed = <1000>;/g" target/linux/mediatek/dts/mt7622-*.dts
sed -i "s/speed = <2500>;/speed = <1000>;/g" target/linux/mediatek/dts/mt7623a-*.dts
sed -i "s/speed = <2500>;/speed = <1000>;/g" target/linux/mediatek/dts/mt7981b-*.dts
sed -i "s/speed = <2500>;/speed = <1000>;/g" target/linux/mediatek/dts/mt7986a-*.dts
sed -i "s/speed = <2500>;/speed = <1000>;/g" target/linux/mediatek/dts/mt7622-*.dtsi
sed -i "s/speed = <2500>;/speed = <1000>;/g" target/linux/mediatek/dts/mt7623a-*.dtsi

##
sed -i '/option Interface/d'  package/network/services/dropbear/files/dropbear.config


## rockchip
cp -af feeds/istoreos_ipk/patch/rockchip/*  target/linux/rockchip/armv8/base-files/

# golong1.23依赖
rm -rf feeds/packages/lang/golang
# git clone --depth=1 https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
git clone https://git.kejizero.online/zhao/packages_lang_golang -b 23.x feeds/packages/lang/golang
