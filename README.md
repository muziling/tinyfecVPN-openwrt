tinyfecVPN running on Openwrt/LEDE
===

编译/Compile
---

```bash
cd openwrt
git clone https://github.com/muziling/tinyfecVPN-openwrt.git feeds/packages/net/tinyfecVPN
rm -rf tmp/

./scripts/feeds update -a
./scripts/feeds install -a

make menuconfig
make package/tinyfecVPN/compile
```
