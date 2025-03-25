include $(TOPDIR)/rules.mk

PKG_NAME:=zero-files
PKG_VERSION:=1.0
PKG_RELEASE:=$(COMMITCOUNT)
PKG_FLAGS:=hold essential nonshared

PKG_LICENSE:=CC0-1.0
PKG_MAINTAINER:=jjm2473 <jjm2473@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=Zero Files for Argon theme
  MAINTAINER:=jjm2473 <jjm2473@gmail.com>
  DEPENDS:=+luci-theme-argon
endef

define Package/$(PKG_NAME)/description
  This package provides additional icons for the Argon theme, including Cellular network icon.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile/Default
endef
Build/Compile = $(Build/Compile/Default)

# 安装文件到目标系统
define Package/$(PKG_NAME)/install
	$(CP) ./files/* $(1)/      # 拷贝文件夹内容到安装目录
endef

# postinst 脚本处理
define Package/$(PKG_NAME)/postinst
#!/bin/sh

HOST_SED="$(subst ${STAGING_DIR_HOST},$${STAGING_DIR_HOST},$(SED))"
HOST_LN="$(subst ${STAGING_DIR_HOST},$${STAGING_DIR_HOST},$(LN))"

[ -n "$${IPKG_INSTROOT}" ] && {
	# 向 Argon 主题的 header.htm 中添加引入 easeicon.css 的语句
	$${HOST_SED} '/<link rel="shortcut icon" href="<%=media%>\/favicon.ico">/a         <link rel="stylesheet" href="<%=resource%>/zero-files/easeicon.css?t=1649313193968">' \
		"$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon/header.htm" \
		"$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon_dark/header.htm" \
		"$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon_light/header.htm" \
		"$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon_dark_purple/header.htm" \
		"$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon_light_green/header.htm"
}
true
endef

# 安装国际化文件
define Package/$(PKG_NAME)/intl/install
	$(CP) ./intl/* $(1)/   # 如果有国际化文件，放在这个文件夹下
endef

$(eval $(call BuildPackage,zero-files))
