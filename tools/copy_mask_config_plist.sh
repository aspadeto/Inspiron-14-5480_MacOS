#!/bin/sh

# Baseado no script gen_debug 
# originalmente escrito por black.dragon74 

diskutil mount EFI

cp /Volumes/EFI/EFI/CLOVER/config.plist .

pledit=/usr/libexec/PlistBuddy
maskedVal=""

echo "Masking your System IDs"
$pledit -c "Set SMBIOS:SerialNumber $maskedVal" config.plist &>/dev/null
$pledit -c "Set SMBIOS:BoardSerialNumber $maskedVal" config.plist &>/dev/null
$pledit -c "Set SMBIOS:SmUUID $maskedVal": config.plist &>/dev/null
$pledit -c "Set RtVariables:ROM $maskedVal" config.plist &>/dev/null
$pledit -c "Set RtVariables:MLB $maskedVal" config.plist &>/dev/null
