#!/bin/bash

######################################################################################################################################
#
# RipCord - Automatically Sleep when Drive is Removed
#	v0.1.1-alpha
#
# Written By KClose
#	Based on an idea by reddit user u/SATLTSADWFZ
#
# This script will install the following files:
#	~/Library/Scripts/KClose3Scripts/com.kclose3.ripcord.sh
#	~/Library/LaunchAgents/com.kclose3.ripcord.plist
#
# To uninstall RipCord, simply delete the above listed files.
#
# ChangeLog
#	2025.03.20	-	Initial Commit
#
# Requirements:
#	You must set your Security & Privacy preferences to "Require password **Immediately** after sleep or screen saver begins.
#	You must also have a USB drive specifically named *RipCord* as your trigger device. 
#
######################################################################################################################################

### VARIABLES ###

# Fetch Current User and Home Folder.
currentUser=$(whoami)
userHome=$(/usr/bin/dscl . read "/Users/$currentUser" NFSHomeDirectory | awk '{print $NF}')

# Define Static (file location) Variables.
launchAgentPath="$userHome/Library/LaunchAgents/com.kclose3.ripcord.plist"
scriptLocation="$userHome/Library/Scripts/KClose3Scripts"
scriptFilename="com.kclose3.ripcord.sh"
scriptPath="$scriptLocation/$scriptFilename"

### MAIN SCRIPT ###

# Check for script folder and create it if it does't exist.
if [[ ! -e "$scriptLocation" ]]; then
	echo "Creating directory."
	mkdir -p "$scriptLocation"
else
	echo "Directory exists."
fi

# Unload the LaunchAgent.
if [[ -e $launchAgentPath ]]; then
	echo "Unloading the LaunchAgent at $launchAgentPath."
	launchctl unload $launchAgentPath
fi

# Write out new LaunchAgent.
echo "Writing new LaunchAgent."
cat <<LaunchAgent > $launchAgentPath
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
		<key>Disabled</key>
		<false/>
		<key>Label</key>
		<string>$(basename $launchAgentPath | sed 's/.plist//')</string>
		<key>ProgramArguments</key>
		<array>
				<string>/bin/sh</string>
				<string>$scriptPath</string>
		</array>
		<key>RunAtLoad</key>
		<true/>
</dict>
</plist>
LaunchAgent

# Set LaunchAgent permissions.
echo "Setting $launchAgentPath file permissions ..."
/usr/sbin/chown "$currentUser" "$launchAgentPath"
/bin/chmod 644 $launchAgentPath

# Create the Ethernet Check Script
echo "Writing out RipCord Script."

cat <<'RipCordScript' > $scriptPath
#!/bin/bash

######################################################################################################################################
#
#	RipCord - Automatically Sleep when Drive is Removed
#		0.1.1-alpha
#
#	Written By KClose
#		Based on an idea by reddit user u/SATLTSADWFZ
#
######################################################################################################################################

### VARIABLES ###

ripcordLog="/tmp/RipCordLog.txt"
systemMonitoring="true"

### FUNCTIONS ###

# Function to write out a switch file to record the current drive state.
# This function logs whether the RipCord drive is mounted or removed, along with a timestamp.
# It helps track changes in the drive's state for further actions, such as securing the computer.
switchfile() {
	# Collect variables for switch.
	drivestate=$1
	timestamp=$(date)
	# Write the result to the switch file.
	echo "$timestamp - $drivestate" >> "$ripcordLog"
}

### MAIN SCRIPT ###

# Create a new switch file if it doesn't already exist. Otherwise the tail check will fail.
if [[ ! -f "$ripcordLog" ]]; then
	touch "$ripcordLog"
	if [[ -d /Volumes/RipCord ]]; then
		switchfile "Drive Mounted."
	else
		switchfile "Drive Removed."
	fi
fi

# Check to see if the RipCord drive is mounted.
#	If this is the first check, or if the status has changed, note the change.
#	If the status has changed to "removed," lock the computer.
#	If the status has not changed, do nothing.

while $systemMonitoring; do
	if [[ -d /Volumes/RipCord ]]; then
		if (tail -n 1 "$ripcordLog" | grep -q "Drive Removed"); then
			switchfile "Drive Mounted."
		fi
	else
		if (tail -n 1 "$ripcordLog" | grep "Drive Mounted"); then
			switchfile "Drive Removed - Securing Computer!"
			pmset displaysleepnow
		fi
	fi
	# Pause for 1 second before checking again.
	sleep 1
done
RipCordScript

# Set ownership and permissions.
echo "Setting $scriptPath file permissions ..."
chown -R "$currentUser" "$scriptPath"
chmod -R 755 "$scriptPath"

# Load the LaunchAgent.
echo "Loading the LaunchAgent at $launchAgentPath."
launchctl load  "$launchAgentPath"
