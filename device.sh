# This file contains information about the device associated with this repo,
# and other
# This file is meant to be used as follows:
#   cat myscript
#   #!/usr/bin/env sh
#   . device.sh
#   echo "Nice ${DEV_NAME} you have there."

export DEV_MFR=Dell
export DEV_NAME=PowerEdge_R630
export DEV_PN=
export DEV_VER=

export DEV_TAG=Dell_PowerEdge_R630
DEV_TAG_SC="$(echo "${DEV_TAG}" | tr '[:upper:]' '[:lower:]')"
export DEV_TAG_SC
