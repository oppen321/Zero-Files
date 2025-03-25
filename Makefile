include $(TOPDIR)/rules.mk

PKG_NAME:=Zero-Files
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Zero-Files - Add Cellular Icon for Argon Theme
  DEPENDS:=+luci-theme-argon
endef

define Build/Compile
	# 这个包不需要编译，仅仅安装相关文件
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/zero-files-init $(1)/etc/uci-defaults/

	$(INSTALL_DIR) $(1)/www/luci-static/zero-files
	$(INSTALL_DATA) ./files/iconfont.* $(1)/www/luci-static/zero-files/
	$(INSTALL_DATA) ./files/easeicon.css $(1)/www/luci-static/zero-files/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/themes/argon
	$(INSTALL_BIN) ./files/postinst.sh $(1)/usr/lib/lua/luci/view/themes/argon/
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
/etc/uci-defaults/zero-files-init
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
