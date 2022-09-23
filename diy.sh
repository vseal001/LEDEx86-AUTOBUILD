#http://blog.vseal.cn
echo '修改机器名称'
sed -i 's/OpenWrt/LEDEx86/g' package/base-files/files/bin/config_generate

echo '修改网关地址'
sed -i 's/192.168.1.1/192.168.12.1/g' package/base-files/files/bin/config_generate

echo '修改时区'
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

echo '修改默认主题为Argon'
#sed -i 's/option mediaurlbase \/luci-static\/bootstrap/option mediaurlbase \/luci-static\/argon/g' ./feeds/luci/modules/luci-base/root/etc/config/luci
#sed -i 's/config internal themes/config internal themes\n    option Argon  \"\/luci-static\/argon\"/g' ./feeds/luci/modules/luci-base/root/etc/config/luci
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

#echo '去除默认bootstrap主题'
#sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap


echo '删除旧版主题文件,链接新版'
rm -rf package/lean/luci-theme-argon
rm -rf package/lean/luci-theme-atmaterial
cp -rf ../diyTheme/luci-theme-argon package/lean/luci-theme-argon
cp -rf ../diyTheme/luci-app-argon-config package/lean/luci-app-argon-config
cp -rf ../diyTheme/luci-theme-atmaterial package/lean/luci-theme-atmaterial


echo '修改wifi名称及国家区域'
sed -i 's/OpenWrt/LEDE/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/US/CN/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

echo '修改banner'
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/

echo '下载ServerChan'
git clone https://github.com/tty228/luci-app-serverchan ../diyApp/luci-app-serverchan

#echo '下载AdGuard Home'
#svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome ../diyApp/luci-app-adguardhome 
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome ../diyApp/luci-app-adguardhome
#svn co https://github.com/kenzok8/openwrt-packages/trunk/adguardhome ../diyApp/adguardhome

echo '使用最新JD script'
rm -rf package/lean/luci-app-jd-dailybonus
git clone https://github.com/Cathgao/luci-app-jd-dailybonus ../diyApp/luci-app-jd-dailybonus

echo '应用过滤插件'
git clone https://github.com/destan19/OpenAppFilter.git ../diyApp/luci-app-oaf

#echo '更新最新frps运行脚本'
#wget https://github.com/vseal001/my-frp/releases/download/Tages/frps_linux_arm -o ../diyApp/luci-app-frps-arm/root/usr/bin/frps

echo '使用自定义frp编译脚本'
rm -r package/lean/frp/Makefile
cp -r ../diyConfig/frp/Makefile package/lean/frp/Makefile

echo '集成diyApp目录'
ln -s ../../diyApp package/openwrt-packages

#echo '首页增加CPU频率动态显示'
#cp -f ../diyApp/mod-index.htm ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

#echo 'enable magic'
#echo 'src-git helloworld https://github.com/fw876/helloworld'>>./feeds.conf.default
