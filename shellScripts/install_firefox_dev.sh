#!/usr/bin/env bash

ffVersion="75.0b3"
file="firefox_dev.desktop"

#Remove regular firefox to avoid conflicts
sudo apt remove firefox
#Navigate to /opt dir where firefox will be installed
cd /opt
#Download tar archive
wget https://download-installer.cdn.mozilla.net/pub/devedition/releases/${ffVersion}/linux-x86_64/en-US/firefox-${ffVersion}.tar.bz2
#Extract tar archive
tar xvf firefox-${ffVersion}.tar.bz2
#Delete tar archive
rm firefox-${ffVersion}.tar.bz2
#Change name of extracted dir from firefox to firefox_dev
mv firefox firefox_dev
#Create link so user can run firefox
ln -s /opt/firefox_dev/firefox /usr/local/bin/firefox_dev
#Create .desktop file in order to create a desktop shortcut
touch $file
echo "[Desktop Entry]
Name=Firefox Dev Edition
GenericName=Firefox Developer Edition
Exec=/usr/local/bin/firefox_dev %u
Terminal=false
Icon=/opt/firefox_dev/browser/chrome/icons/default/default128.png
Type=Application
Categories=Application;Network;X-Developer;
Comment=Firefox Developer Edition Web Browser
StartupWMClass=Firefox Developer Edition" > $file
#Give all groups permission to execute the shortcut
chmod +x /usr/share/applications/$file
