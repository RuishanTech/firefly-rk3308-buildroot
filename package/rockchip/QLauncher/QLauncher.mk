################################################################################
#
# QLauncher
#
################################################################################

QLAUNCHER_VERSION = 1.0
QLAUNCHER_SITE = $(TOPDIR)/../app/QLauncher
QLAUNCHER_SITE_METHOD = local

QLAUNCHER_LICENSE = Apache V2.0
QLAUNCHER_LICENSE_FILES = NOTICE

ifeq ($(BR2_PACKAGE_DEVICE_EVB),y)
define QLAUNCHER_CONFIGURE_CMDS
	sed -i '/^TARGET/a\DEFINES += DEVICE_EVB' $(BUILD_DIR)/QLauncher-$(QLAUNCHER_VERSION)/QLauncher.pro
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake
endef
else
define QLAUNCHER_CONFIGURE_CMDS
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake
endef
endif

define QLAUNCHER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QLAUNCHER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/local/QLauncher
	cp $(BUILD_DIR)/QLauncher-$(QLAUNCHER_VERSION)/resources/images/* $(TARGET_DIR)/usr/local/QLauncher/
	$(INSTALL) -D -m 0755 $(@D)/QLauncher \
		$(TARGET_DIR)/usr/local/QLauncher/QLauncher
endef

$(eval $(generic-package))
