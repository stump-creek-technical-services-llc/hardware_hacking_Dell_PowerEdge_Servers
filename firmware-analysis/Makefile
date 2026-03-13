GIT_DIR := $(shell git rev-parse --show-toplevel)
include $(GIT_DIR)/device.sh
include $(HARDWARE_HACKING_ROOT)/include/make/flavor.mk

# This file is meant to run on GNU/Linux
#
# Dependencies: sleuthkit, binwalk, xxd, coreutils
# Ubuntu/Debian: sudo apt install sleuthkit binwalk xxd coreutils

GIT_DIR := $(shell git rev-parse --show-toplevel)
include $(GIT_DIR)/device.sh

FIRMWARE_ANALYSIS_DIR=$(GIT_DIR)/firmware-analysis

FILE ?= $(GIT_DIR)/firmware-images/$(DEV_TAG_SC).$(FLAVOR_BIN_EXT)
FILENAME := $(shell echo $(FILE) | rev | cut -d/ -f1 | rev)

OUTPUT_DIR := $(FIRMWARE_ANALYSIS_DIR)/output
OUTPUT_ANALYSIS_DIR := $(OUTPUT_DIR)/$(FILENAME).analysis
LOCAL_BINWALK := $(GIT_DIR)/../../tools/binwalk/target/release/binwalk

.PHONY: analysis clean extractions hash check

all: check analysis
#	make analysis FILE=$(GIT_DIR)/firmware-images/firmware-free.bin

analysis: \
		check \
		$(OUTPUT_ANALYSIS_DIR) \
		extractions \
		$(OUTPUT_ANALYSIS_DIR)/entropy \
		$(OUTPUT_ANALYSIS_DIR)/fsstat

clean:
	rm -rf $(OUTPUT_DIR)

$(OUTPUT_ANALYSIS_DIR):
	mkdir -p $(OUTPUT_ANALYSIS_DIR)

extractions: $(OUTPUT_ANALYSIS_DIR)
	cd $(OUTPUT_ANALYSIS_DIR) && $(LOCAL_BINWALK) -l $(OUTPUT_ANALYSIS_DIR)/binwalk.log -Me $(FILE)

$(OUTPUT_ANALYSIS_DIR)/entropy: $(OUTPUT_ANALYSIS_DIR)
	cd $(OUTPUT_ANALYSIS_DIR) && binwalk -E $(FILE) | tee $(OUTPUT_ANALYSIS_DIR)/entropy

$(OUTPUT_ANALYSIS_DIR)/fsstat: $(OUTPUT_ANALYSIS_DIR)
	fsstat $(FILE) > $(OUTPUT_ANALYSIS_DIR)/fsstat

$(OUTPUT_ANALYSIS_DIR)/bootloader.bin: $(OUTPUT_ANALYSIS_DIR)
	# Extract the bootloader, which lies between offsets 0x3e and 0x1fd
	dd if=$(FILE) of=$(OUTPUT_ANALYSIS_DIR)/bootloader.bin bs=1 skip=62 count=448
	bin2hex $(OUTPUT_ANALYSIS_DIR)/bootloader.bin

hash: $(OUTPUT_ANALYSIS_DIR)
	sha256sum $(FILE) >> $(OUTPUT_ANALYSIS_DIR)/sha256sums

check: $(OUTPUT_ANALYSIS_DIR)
	sha256sum -c $(OUTPUT_ANALYSIS_DIR)/sha256sums || true

