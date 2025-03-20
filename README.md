### RipCord - Automatically Sleep when USB Drive is Removed
&emsp;&emsp;v0.1.1-alpha

Written By KClose<br>
&emsp;&emsp;Based on an idea by reddit user u/SATLTSADWFZ

About this script:<br>
The intent of this project was to make a failsafe that would put a comptuer to sleep if someone were to steal the computer from someone sitting in public. This works by having a "key" drive that would be tethered to the user like a ripcord. If the computer were taken away forcefully, the USB drive would be removed and the computer will go to sleep. 

This works by installing a script that will checks for the presense or absense of a USB drive specifially named *RipCord*. If at any point in time, the *RipCord* drive is removed, the computer will immediately go to sleep. The script runs automatically upon installation, and also on startup, ensuring that the safety protocol is constantly in effect. 

The USB drive does not need to be present at all times, only if you believe your computer might be at risk. Removing the USB drive puts the computer to sleep, but only upon initial removal after being inserted. If you unlock the computer after the drive has been removed, it will not lock again until the drive has been reinserted and removed again.

---
This script will install the following files:
- ~/Library/Scripts/KClose3Scripts/com.kclose3.ripcord.sh
- ~/Library/LaunchAgents/com.kclose3.ripcord.plist

To install RipCord:
1. Download the [Install Script](https://github.com/kclose3/RipCord/blob/72ece31c56cca98751c5962174ba415c03544a78/Ripcord.sh)
2. Open Terminal and run the install script to complete the installation and start the USB monitor
3. Set your Security & Privacy preferences to "Require password **Immediately** after sleep or screen saver begins
4. Rename a USB drive as *RipCord*

To use RipCord:<br>
RipCord starts running upon installation and will launch automatically at every system startup. Inserting the *RipCord* USB drive will "arm" the system. The next time the drive is removed, the computer will go to sleep.

To uninstall RipCord:
1. Delete the two files noted above
2. Restart your computer to ensure that the service is no longer running

---
### Automator Version
There is also an Automator Version fo this script. Download the [zip file](https://github.com/kclose3/RipCord/blob/f75cf2cacd4dcd2e5d2c113e1e8755fcc9afba47/RipCord.zip) and extract the Applet. There is no UI for this application. This version does not run perpetually like the script versin. Instead, When you want to protect your computer, run this Applet and insert a USB drive with the name *RipCord* to engage the monitor. You can tell it is running from the spinning gear on the Menu Bar. This version automatically quits when the USB drive is removed after the computer is put to sleep. To end the monitor manually, click on the spinning gear in the Menu Bar, and click the "X" next to RipCord in the drop down menu.

---
ChangeLog
- 2025.03.20	-	Initial Commit
