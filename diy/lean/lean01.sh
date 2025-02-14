#!/bin/bash
#=================================================
# JayKwok's script
#=================================================
##添加自己的插件库
rm -rf ./package/lean/k3screenctrl
rm -rf ./package/lean/autocore
               
sed -i "1isrc-git istoreos_ipk https://github.com/Jaykwok2999/istoreos-ipk\n" feeds.conf.default

# sed -i 's/#src-git luci/src-git luci/g' feeds.conf.default
# sed -i '/luci.git;openwrt-23.05/d' feeds.conf.default
