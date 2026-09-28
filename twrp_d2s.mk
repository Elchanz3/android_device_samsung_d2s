PRODUCT_RELEASE_NAME := d2s
PRODUCT_BUILD_RECOVERY_IMAGE := true

# Inherit from the recovery product configuration.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_PACKAGES += \
    make_f2fs \
    fsck.f2fs

# Device identifier
PRODUCT_DEVICE := d2s
PRODUCT_NAME := twrp_d2s
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := Galaxy Note 10+
PRODUCT_MANUFACTURER := samsung
