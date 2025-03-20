### RipCord - Automatically Sleep when USB Drive is Removed
&emsp;&emsp;v0.1.1-alpha

Written By KClose<br>
&emsp;&emsp;Based on an idea by reddit user u/SATLTSADWFZ

About this script:<br>
The intent of this project was to make a failsafe that would put a comptuer to sleep if someone were to steal the computer from someone sitting in public. This works by having a "key" drive that would be tethered to the user like a ripcord. If the computer were taken away forcefully, the USB drive would be removed and the computer will go to sleep. 

This works by installing a script that will start checking for the presense of a USB drive specifially named *RipCord*. If at any point in time, the *RipCord* drive is removed, the computer will immediately go to sleep. The script runs automatically upon installation, and also on startup, ensuring that the safety protocol is constantly in effect. 

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

To uninstall RipCord, simply delete the above listed files.

---
ChangeLog
- 2025.03.20	-	Initial Commit
