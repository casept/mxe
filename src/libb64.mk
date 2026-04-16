# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libb64
$(PKG)_WEBSITE  := https://github.com/libb64/libb64
$(PKG)_DESCR    := Base64 Encoding/Decoding Routines
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0.0.1
$(PKG)_CHECKSUM := ce8e578a953a591bd4a6f157eec310b9a4c2e6f10ade2fdda6ae6bafaf798b98
$(PKG)_SUBDIR   := libb64-$($(PKG)_VERSION)
$(PKG)_FILE     := libb64-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/libb64/libb64/archive/refs/tags/v$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    $(MAKE) -C '$(SOURCE_DIR)/src' -j '$(JOBS)' \
        CC='$(TARGET)-gcc' \
        AR='$(TARGET)-ar' \
        CFLAGS='-O2 -I../include'
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib'
    $(INSTALL) -m 644 '$(SOURCE_DIR)/src/libb64.a' '$(PREFIX)/$(TARGET)/lib/'
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/include/b64'
    $(INSTALL) -m 644 '$(SOURCE_DIR)/include/b64/'*.h '$(PREFIX)/$(TARGET)/include/b64/'
endef
