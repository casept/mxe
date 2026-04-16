# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := protobuf
$(PKG)_WEBSITE  := https://github.com/protocolbuffers/protobuf
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 34.1
$(PKG)_CHECKSUM := e4e6ff10760cf747a2decd1867741f561b216bd60cc4038c87564713a6da1848
$(PKG)_GH_CONF  := protocolbuffers/protobuf/releases,v
$(PKG)_DEPS     := cc abseil-cpp zlib $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS_$(BUILD) := abseil-cpp

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)' \
        -DCMAKE_CXX_STANDARD=17 \
        -Dprotobuf_BUILD_TESTS=OFF \
        -Dprotobuf_BUILD_CONFORMANCE=OFF \
        -Dprotobuf_BUILD_EXAMPLES=OFF \
        -Dprotobuf_WITH_ZLIB=ON \
        -Dprotobuf_BUILD_PROTOC_BINARIES=OFF \
        -Dprotobuf_BUILD_LIBPROTOC=OFF \
        -DWITH_PROTOC='$(PREFIX)/$(BUILD)/bin/protoc' \
        -Dprotobuf_LOCAL_DEPENDENCIES_ONLY=ON \
        -Dprotobuf_ABSL_PROVIDER=package
    '$(TARGET)-cmake' --build '$(BUILD_DIR)' --config Release -j '$(JOBS)'
    '$(TARGET)-cmake' --build '$(BUILD_DIR)' --config Release --target install

    '$(TARGET)-g++' \
        -W -Wall -Werror -std=c++17 \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-protobuf.exe' \
        `'$(TARGET)-pkg-config' protobuf --cflags --libs`
endef

define $(PKG)_BUILD_$(BUILD)
    cd '$(BUILD_DIR)' && cmake '$(SOURCE_DIR)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(BUILD)' \
        -DCMAKE_PREFIX_PATH='$(PREFIX)/$(BUILD)' \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_CXX_STANDARD=17 \
        -Dprotobuf_BUILD_TESTS=OFF \
        -Dprotobuf_BUILD_CONFORMANCE=OFF \
        -Dprotobuf_BUILD_EXAMPLES=OFF \
        -Dprotobuf_WITH_ZLIB=ON \
        -Dprotobuf_LOCAL_DEPENDENCIES_ONLY=ON \
        -Dprotobuf_ABSL_PROVIDER=package
    cmake --build '$(BUILD_DIR)' --config Release -j '$(JOBS)'
    cmake --build '$(BUILD_DIR)' --config Release --target install
endef
