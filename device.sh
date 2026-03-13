# This file contains information about the device associated with this repo,
# and other
# This file is meant to be used as follows:
#   cat myscript
#   #!/usr/bin/env sh
#   . device.sh
#   echo "Nice ${DEV_NAME} you have there."

export DEV_MFR=GizmoTek
export DEV_NAME=Gizmo
export DEV_PN=1234
export DEV_VER=1

export DEV_TAG=GizmoTek_Gizmo_1234_v1
DEV_TAG_SC="$(echo "${DEV_TAG}" | tr '[:upper:]' '[:lower:]')"
export DEV_TAG_SC
