GIT_DIR := $(shell git rev-parse --show-toplevel)
include $(GIT_DIR)/device.properties
DEV_TAG_SC="$(shell echo "${DEV_TAG}" | tr '[:upper:]' '[:lower:]')"
include $(HARDWARE_HACKING_ROOT)/include/make/flavor.mk

OUTPUT_FILENAME ?= $(DEV_TAG_SC).$(FLAVOR_BIN_EXT)

OUTPUT_DIR ?= $(HARDWARE_HACKING_ROOT)/firmware-copyrighted/$(DEV_TAG)
OUTPUT_PATH=$(OUTPUT_DIR)/$(OUTPUT_FILENAME)

FW_IMAGES_DIR ?= $(GIT_DIR)/firmware-images
FW_IMAGES_LINK_PATH=$(FW_IMAGES_DIR)/$(OUTPUT_FILENAME)
FW_IMAGES_HEX_PATH=FW_IMAGES_LINK_PATH.hex
LOG_PATH=$(FW_IMAGES_DIR)/$(OUTPUT_FILENAME).flashrom.log

TEE=tee -a $(LOG_PATH)

# Targets
.PHONY: all

all: \
	$(OUTPUT_DIR) \
	$(OUTPUT_PATH) \
	$(OUTPUT_DIR)/sha256sums \
	$(FW_IMAGES_LINK_PATH) \
	$(FW_IMAGES_DIR)/sha256sums \
	$(FW_IMAGES_HEX_PATH)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

$(OUTPUT_PATH): $(OUTPUT_DIR)
	echo DEV_TAG_SC = $(DEV_TAG_SC)
	flashrom_dump $(OUTPUT_PATH) | $(TEE)
	git -C $(OUTPUT_DIR) stash
	git -C $(OUTPUT_DIR) add $(OUTPUT_PATH)
	git -C $(OUTPUT_DIR) commit -m "Added $(FLAVOR) firmware for $(DEV_TAG)"
	git -C $(OUTPUT_DIR) push
	git -C $(OUTPUT_DIR) stash pop || true

$(OUTPUT_DIR)/sha256sums: $(OUTPUT_PATH)
	cd $(OUTPUT_DIR) && sha256sum $(OUTPUT_PATH) >> sha256sums
	git -C $(OUTPUT_DIR) stash
	git -C $(OUTPUT_DIR) add sha256sums
	git -C $(OUTPUT_DIR) commit -m "Updated sha256sums $(OUTPUT_FILENAME)"
	git -C $(OUTPUT_DIR) push
	git -C $(OUTPUT_DIR) stash pop || true

$(FW_IMAGES_LINK_PATH): $(OUTPUT_PATH)
	ln -sf $(OUTPUT_PATH) $(FW_IMAGES_LINK_PATH)

$(FW_IMAGES_DIR)/sha256sums: $(FW_IMAGES_LINK_PATH)
	cd $(FW_IMAGES_DIR) && sha256sum $(FW_IMAGES_LINK_PATH) >> sha256sums

$(FW_IMAGES_HEX_PATH): $(FW_IMAGES_LINK_PATH)
	LANG=C bin2hex $(OUTPUT_FILENAME) | $(TEE)
