################################################################################
#
# video
#
################################################################################

VIDEO_VERSION = 1.0
VIDEO_SITE = $(TOPDIR)/../app/video
VIDEO_SITE_METHOD = local

VIDEO_LICENSE = Apache V2.0
VIDEO_LICENSE_FILES = NOTICE

ifeq ($(BR2_PACKAGE_DEVICE_EVB),y)
define VIDEO_CONFIGURE_CMDS
	sed -i '/^TARGET/a\DEFINES += DEVICE_EVB' $(BUILD_DIR)/video-$(VIDEO_VERSION)/video.pro
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake
endef
else
define VIDEO_CONFIGURE_CMDS
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake
endef
endif

define VIDEO_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define VIDEO_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/local/video
	cp $(BUILD_DIR)/video-$(VIDEO_VERSION)/conf/* $(TARGET_DIR)/usr/local/video/
	$(INSTALL) -D -m 0755 $(@D)/videoPlayer \
		$(TARGET_DIR)/usr/local/video/videoPlayer
endef

$(eval $(generic-package))
