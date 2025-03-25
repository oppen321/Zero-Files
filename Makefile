include $(TOPDIR)/rules.mk

PKG_NAME:=Zero-Files
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_FLAGS:=hold essential nonshared

PKG_LICENSE:=CC0-1.0
PKG_MAINTAINER:=oppen321

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=Zero Files for Argon Theme
  MAINTAINER:=oppen321
  DEPENDS:=+luci-theme-argon
endef

define Package/$(PKG_NAME)/description
 Custom files for OpenWrt Argon theme, adding sidebar icons.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile/Default

endef
Build/Compile = $(Build/Compile/Default)

define Package/$(PKG_NAME)/install
	$(CP) ./files/* $(1)/
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh

HOST_SED="$(subst ${STAGING_DIR_HOST},$${STAGING_DIR_HOST},$(SED))"

[ -n "$${IPKG_INSTROOT}" ] && {
	$${HOST_SED} '/<link rel="shortcut icon" href="<%=media%>\/favicon.ico">/a         <link rel="stylesheet" href="<%=resource%>/zero-files/easeicon.css?t=1649313193968">' \
		"$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon/header.htm" \
		"$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon_dark/header.htm" \
		"$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon_light/header.htm" \
		"$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon_dark_purple/header.htm" \
		"$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon_light_green/header.htm"
}
true
endef

$(eval $(call BuildPackage,Zero-Files))
