
# ..../src/router/
# (directory of the last (this) makefile)
export TOP := $(shell cd $(dir $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))) && pwd -P)

# ..../src/
export SRCBASE := $(shell (cd $(TOP)/.. && pwd -P))

include $(SRCBASE)/tomato_profile.mak
include $(TOP)/.config

export BUILD := i386-pc-linux-gnu
export HOSTCC := gcc

export PLATFORM := mipsel-uclibc

export CROSS_COMPILE := mipsel-uclibc-
export CROSS_COMPILER := $(CROSS_COMPILE)
export CONFIGURE := ./configure mipsel-linux --build=$(BUILD)
export TOOLCHAIN := $(shell cd $(dir $(shell which $(CROSS_COMPILE)gcc))/.. && pwd -P)

export CC := $(CROSS_COMPILE)gcc
export AR := $(CROSS_COMPILE)ar
export AS := $(CROSS_COMPILE)as
export LD := $(CROSS_COMPILE)ld
export NM := $(CROSS_COMPILE)nm
export RANLIB := $(CROSS_COMPILE)ranlib
export STRIP := $(CROSS_COMPILE)strip -s -R .note -R .comment
export SIZE := $(CROSS_COMPILE)size

export LINUXDIR := $(SRCBASE)/linux/linux
export LIBDIR := $(TOOLCHAIN)/lib
export USRLIBDIR := $(TOOLCHAIN)/usr/lib

export PLATFORMDIR := $(TOP)/$(PLATFORM)
export INSTALLDIR := $(PLATFORMDIR)/install
export TARGETDIR := $(PLATFORMDIR)/target


ifeq ($(TOMATO_DEV),jon)
CPTMP = cp $@ $(TOP)/ftpshare/ && cp $@ $(TOP)/smbshare/
ifneq ($(STATIC),1)
SIZECHECK = @$(SRCBASE)/btools/sizehistory.pl $@ $(TOMATO_PROFILE_L)_$(notdir $@)
endif
else
CPTMP = true
SIZECHECK = $(SIZE) $@
endif

ifeq ($(NOSIZE),1)
SIZECHECK =
endif
