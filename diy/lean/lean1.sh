#!/bin/bash
#=================================================
# JayKwok's script
#=================================================
##添加自己的插件库
rm -rf ./package/lean/k3screenctrl
rm -rf ./package/lean/autocore
               
sed -i "1isrc-git extraipk https://github.com/zijieKwok/jaykwok-ipk\n" feeds.conf.default

