#
# Copyright (c) 2017 Yu Wang <wangyucn@gmail.com>
#
# This is free software, licensed under the MIT.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tinyfecVPN
PKG_VERSION:=20180804.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/wangyu-/tinyfecVPN.git
PKG_SOURCE_VERSION:=55757c6f4915af7dcfeddc9b63be5c7d579998cd
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Yu Wang

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tinyfecVPN
	SECTION:=net
	CATEGORY:=Network
	TITLE:=VPN with Build-in Forward Error Correction Support
	URL:=https://github.com/wangyu-/tinyfecVPN
endef

define Package/tinyfecVPN/description
	A Lightweight VPN with Build-in Forward Error Correction Support(or A Network Improving Tool which works at VPN mode). Improves your Network Quality on a High-latency Lossy Link.
endef

MAKE_FLAGS += cross2

define Build/Prepare
	$(PKG_UNPACK)
	sed -i 's/cc_cross=.*/cc_cross=$(TARGET_CXX)/g' $(PKG_BUILD_DIR)/makefile
	sed -i '/\*gitversion/d' $(PKG_BUILD_DIR)/makefile
	echo 'const char *gitversion = "$(PKG_SOURCE_VERSION)";' > $(PKG_BUILD_DIR)/git_version.h
	$(Build/Patch)
endef

define Package/tinyfecVPN/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tinyvpn_cross $(1)/usr/bin/tinyfecvpn
endef

$(eval $(call BuildPackage,tinyfecVPN))
