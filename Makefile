TARGET := iphone:clang:latest:15.0
INSTALL_TARGET_PROCESSES = ToolBox

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = ToolBox
ToolBox_FILES = main.m ToolBoxAppDelegate.m ToolBoxRootViewController.mm
ToolBox_FRAMEWORKS = UIKit CoreGraphics QuartzCore
ToolBox_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/application.mk

before-package::
	chmod -R 0755 $(THEOS_STAGING_DIR)
	cp Info.plist $(THEOS_STAGING_DIR)/Applications/ToolBox.app/Info.plist
	cp font.ttf $(THEOS_STAGING_DIR)/Applications/ToolBox.app/font.ttf
