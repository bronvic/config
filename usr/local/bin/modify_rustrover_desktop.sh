#!/bin/bash
DESKTOP_FILE="/usr/share/applications/jetbrains-rustrover.desktop"
LOCAL_DESKTOP_FILE="$HOME/.local/share/applications/jetbrains-rustrover.desktop"

# Copy the desktop file to the local directory
cp $DESKTOP_FILE $LOCAL_DESKTOP_FILE

# Modify the Exec line to include the environment variable, handling existing environment variables gracefully
sed -i -E 's|Exec=(env .+ )?"/opt/rustrover/bin/rustrover.sh"|Exec=env _JAVA_AWT_WM_NONREPARENTING=1 \1"/opt/rustrover/bin/rustrover.sh"|' $LOCAL_DESKTOP_FILE

