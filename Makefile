include $(TOPDIR)/rules.mk

PKG_NAME:=zero-files
PKG_VERSION:=1.0
PKG_RELEASE:=$(COMMITCOUNT)
PKG_FLAGS:=hold essential nonshared

PKG_LICENSE:=CC0-1.0
PKG_MAINTAINER:=oppen321 <zj18139624826@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=Zero files
  MAINTAINER:=oppen321 <zj18139624826@gmail.com>
  DEFAULT:=y
  DEPENDS:=+luci-theme-argon
endef

define Package/$(PKG_NAME)/description
 Custom files for Zero theme including modified Argon sidebar icons.
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
HOST_LN="$(subst ${STAGING_DIR_HOST},$${STAGING_DIR_HOST},$(LN))"

[ -n "$${IPKG_INSTROOT}" ] && {
    # 修改 Argon 主题的侧边栏图标
    $${HOST_SED} 's/<link rel="stylesheet" href="<%=resource%>\/argon.css">/<link rel="stylesheet" href="<%=resource%>\/argon.css?t=1649313193968">/' \
    "$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon/sidebar.htm"

    $${HOST_SED} '/<link rel="shortcut icon" href="<%=media%>\/favicon.ico">/a         <link rel="stylesheet" href="<%=resource%>/easepi/easeicon.css?t=1649313193968">' \
    "$${IPKG_INSTROOT}/usr/lib/lua/luci/view/themes/argon/sidebar.htm"

    # 删除原本的 argon 配置
    rm -f "$${IPKG_INSTROOT}/etc/uci-defaults/luci-argon-config"
}
true
endef

$(eval $(call BuildPackage,zero-files))
