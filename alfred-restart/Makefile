include $(TOPDIR)/rules.mk

PKG_NAME:=alfred-restart
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/alfred-restart
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=alfred-restart
  DEPENDS:=+gluon-alfred
endef

define Build/Prepare
        mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/alfred-restart/install
        $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,alfred-restart))

