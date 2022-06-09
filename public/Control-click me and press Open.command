## Pop Pixie Installation Script
#
# Apple requires that all macOS apps downloaded from the internet are signed,
# which costs the developer $99/year. The only way to avoid this is to use the
# `xattr` command to remove the quarantine flag from the app after it has been
# downloaded, which is what this script does.
#
# If you'd like to sponsor us to get the Pop Pixie macOS binary signed, or if
# you know of an alternative workaround, please contact us at
# team@mousetrapped.co.uk.

SOURCE_PATH="$(dirname "$0")/.Pop Pixie.app"
DESTINATION_PATH="/Applications/Pop Pixie.app"
BACKUP_DESTINATION_PATH="/$HOME/Downloads/Pop Pixie.app"

echo "Installing Pop Pixie to $DESTINATION_PATH"

rm -r "$DESTINATION_PATH" 2>/dev/null
cp -r "$SOURCE_PATH" "$DESTINATION_PATH" 2>/dev/null || {
	echo "Failed to install to $DESTINATION_PATH"

	DESTINATION_PATH="$BACKUP_DESTINATION_PATH"
	echo "Installing Pop Pixie to $DESTINATION_PATH"

	rm -r "$DESTINATION_PATH" 2>/dev/null
	cp -r "$SOURCE_PATH" "$DESTINATION_PATH" 2>/dev/null || {
		echo "Failed to install to $DESTINATION_PATH"
		echo "Could not install Pop Pixie. Please contact us at team@mousetrapped.co.uk for help."
		read
		exit 1
	}
}

xattr -d com.apple.quarantine "$DESTINATION_PATH" 2>/dev/null ||
  echo "Failed to remove quarantine flag. If you experience any difficulties installing Pop Pixie, contact us at team@mousetrapped.co.uk."

open -R "$DESTINATION_PATH" &&
	echo "Installation complete. Press return to exit."

read
