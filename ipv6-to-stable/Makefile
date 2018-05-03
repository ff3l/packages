include $(TOPDIR)/rules.mk

PKG_NAME:=ipv6-to-stable
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include ../../../package/gluon.mk

define Package/ipv6-to-stable
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Replace ipv6 with stable branch
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
	$(call GluonSrcDiet,./luasrc,$(PKG_BUILD_DIR)/luadest/)
endef

define Package/ipv6-to-stable/install
	$(CP) $(PKG_BUILD_DIR)/luadest/* $(1)/
endef

$(eval $(call BuildPackage,ipv6-to-stable))