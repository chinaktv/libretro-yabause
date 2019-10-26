LOCAL_PATH := $(call my-dir)

CORE_DIR := $(LOCAL_PATH)/..

HAVE_MUSASHI = 1
DYNAREC_DEVMIYAX = 0
USE_ARM_DRC = 0
USE_AARCH64_DRC = 0
USE_X86_DRC = 0
ARCH_IS_LINUX = 1
HAVE_SYS_PARAM_H = 1
FORCE_GLEW = 0
FORCE_GLES = 1
USE_RTHREADS = 1
FASTMATH = 1

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
	DYNAREC_DEVMIYAX = 1
	USE_ARM_DRC = 1
else ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
	DYNAREC_DEVMIYAX = 1
	USE_AARCH64_DRC = 1
endif

include $(CORE_DIR)/Makefile.common

FLAGS += -DANDROID

ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
	FLAGS += -DAARCH64
endif

include $(CLEAR_VARS)
LOCAL_MODULE       := retro
LOCAL_SRC_FILES    := $(SOURCES_CXX) $(SOURCES_C) $(SOURCES_S)
LOCAL_C_INCLUDES   := $(INCLUDE_DIRS)
LOCAL_CFLAGS       := -std=gnu11 $(FLAGS)
LOCAL_CPPFLAGS     := -std=gnu++11 $(FLAGS)
LOCAL_LDFLAGS      := -Wl,-version-script=$(CORE_DIR)/link.T
LOCAL_LDLIBS       := -lGLESv3
LOCAL_CPP_FEATURES := exceptions rtti
LOCAL_ARM_MODE     := arm

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
	LOCAL_ARM_NEON := true
endif

include $(BUILD_SHARED_LIBRARY)
