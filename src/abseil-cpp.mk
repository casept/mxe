# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := abseil-cpp
$(PKG)_WEBSITE  := https://github.com/abseil/abseil-cpp
$(PKG)_DESCR    := Abseil C++ Common Libraries
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 20250512.1
$(PKG)_CHECKSUM := 9b7a064305e9fd94d124ffa6cc358592eb42b5da588fb4e07d09254aa40086db
$(PKG)_GH_CONF  := abseil/abseil-cpp/tags
$(PKG)_DEPS     := cc
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS_$(BUILD) :=

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)' \
        -DCMAKE_CXX_STANDARD=17 \
        -DABSL_BUILD_TESTING=OFF \
        -DABSL_PROPAGATE_CXX_STD=ON \
        -DABSL_ENABLE_INSTALL=ON
    '$(TARGET)-cmake' --build '$(BUILD_DIR)' --config Release -j '$(JOBS)'
    '$(TARGET)-cmake' --build '$(BUILD_DIR)' --config Release --target install
endef

define $(PKG)_BUILD_$(BUILD)
    cd '$(BUILD_DIR)' && cmake '$(SOURCE_DIR)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(BUILD)' \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_CXX_STANDARD=17 \
        -DABSL_BUILD_TESTING=OFF \
        -DABSL_PROPAGATE_CXX_STD=ON \
        -DABSL_ENABLE_INSTALL=ON
    cmake --build '$(BUILD_DIR)' --config Release -j '$(JOBS)'
    cmake --build '$(BUILD_DIR)' --config Release --target install
endef
