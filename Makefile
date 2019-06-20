export target = :clang:11.2:12.0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HuluGestureDisabler
HuluGestureDisabler_FILES = Tweak.xm
HuluGestureDisabler_FRAMEWORKS = Foundation UIKit
HuluGestureDisabler_CFLAGS += -fobjc-arc
HuluGestureDisabler_ARCHS = arm64 arm64e

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Hulu"
