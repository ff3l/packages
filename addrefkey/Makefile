include $(TOPDIR)/rules.mk

PKG_NAME:=addrefkey
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/addrefkey
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=addrefkey
#  DEPENDS:=+gluon-alfred
endef

define Build/Prepare
        mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/addrefkey/install
        $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,addrefkey))

