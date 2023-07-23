#
# Created by GuHaijun on 2023/7/13.
#

LOCAL_PATH:= $(call my-dir)
LIBJSONCPP_ROOT_REL := ../../jsoncpp
LIBJSONCPP_ROOT_ABS := $(LOCAL_PATH)/../../jsoncpp

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    $(LIBJSONCPP_ROOT_REL)/src/lib_json/json_reader.cpp \
    $(LIBJSONCPP_ROOT_REL)/src/lib_json/json_value.cpp  \
    $(LIBJSONCPP_ROOT_REL)/src/lib_json/json_writer.cpp


LOCAL_C_INCLUDES := \
    $(LIBJSONCPP_ROOT_ABS)/ \
    $(LIBJSONCPP_ROOT_ABS)/include/ \
    $(LIBJSONCPP_ROOT_ABS)/src/lib_json

LOCAL_EXPORT_C_INCLUDE_DIRS := \
    $(LIBJSONCPP_ROOT_ABS)/include

LOCAL_CFLAGS := \
	-DJSON_USE_EXCEPTION=0 \

# lib static
LOCAL_EXPORT_LDLIBS := -llog

LOCAL_MODULE := jsoncpp_static
LOCAL_MODULE_TAGS := optional
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(BUILD_STATIC_LIBRARY)
endif
LIBJSONCPP_LOCAL_$(LIBJSONCPP_LIB_TYPE)_LIBRARIES += $(LOCAL_MODULE)

# lib share
ifeq ($(LIBJSONCPP_LIB_TYPE), SHARED)
  include $(CLEAR_VARS)
  LOCAL_EXPORT_LDLIBS += -llog

  LOCAL_WHOLE_STATIC_LIBRARIES = jsoncpp_static
  LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true
  LOCAL_ALLOW_UNDEFINED_SYMBOLS := true

  LOCAL_MODULE := jsoncpp
  ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
      include $(BUILD_SHARED_LIBRARY)
  endif
  LIBJSONCPP_LOCAL_$(LIBJSONCPP_LIB_TYPE)_LIBRARIES += $(LOCAL_MODULE)
endif
