include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-config-mode-segment-mover
PKG_VERSION:=1

include $(TOPDIR)/../package/gluon.mk

define Package/gluon-config-mode-segment-mover
  TITLE:=Toggle automatic selection of segment by coordinates
  DEPENDS:=+gluon-config-mode-core +gluon-segment-mover
endef

$(eval $(call BuildPackageGluon,gluon-config-mode-segment-mover))
