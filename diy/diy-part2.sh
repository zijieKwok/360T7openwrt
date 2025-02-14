#!/bin/bash
#=================================================
# 
#=================================================


#补充汉化
#echo -e "\nmsgid \"Control\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
#echo -e "msgstr \"控制\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

#echo -e "\nmsgid \"NAS\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
#echo -e "msgstr \"网络存储\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

#echo -e "\nmsgid \"VPN\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
#echo -e "msgstr \"魔法网络\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

echo -e "\nmsgid \"Temperature\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
echo -e "msgstr \"温度\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
              
##配置ip等
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm-k3|TARGET_DEVICES += phicomm-k3| ; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
sed -i 's/192\.168\.[0-9]*\.[0-9]*/192.168.5.1/g' package/base-files/files/bin/config_generate
sed -i 's/192\.168\.[0-9]*\.[0-9]*/192.168.5.1/g' package/base-files/luci2/bin/config_generate

# tailscale
rm -rf feeds/packages/net/tailscale
cp -af feeds/istoreos_ipk/tailscale/tailscale  feeds/packages/net/
sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile



