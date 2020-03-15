#!/usr/bin/env bash

ffVersion="75.0b3"
file=${1:-firefox_dev}

read -p "Remove regular firefox [y/N]: " i
if [ ${i:-n} != y ]
then  
  echo "Removing regular firefox..."
  sudo apt-get remove firefox > /dev/null
fi
#Navigate to /opt dir where firefox will be installed
cd /opt
#Download tar archive
echo "Downloading Firefox Dev Edition..."
wget https://download-installer.cdn.mozilla.net/pub/devedition/releases/${ffVersion}/linux-x86_64/en-US/firefox-${ffVersion}.tar.bz2 > /dev/null
#Extract tar archive
echo "Extracting..."
tar xvf firefox-${ffVersion}.tar.bz2 > /dev/null
#Delete tar archive
rm firefox-${ffVersion}.tar.bz2 > /dev/null
#Change name of extracted dir from firefox to firefox_dev
mv firefox $file > /dev/null
#Create link so user can run firefox
ln -s /opt/${file}/firefox /usr/local/bin/$file > /dev/null
#Create .desktop file in order to create a desktop shortcut
echo "Creating desktop icon..."
touch /usr/share/applications/${file}.desktop
echo "[Desktop Entry]
Name=Firefox Dev Edition
GenericName=Firefox Developer Edition
Exec=/usr/local/bin/${file} %u
Terminal=false
Icon=/opt/${file}/browser/chrome/icons/default/default128.png
Type=Application
Categories=Application;Network;X-Developer;
Comment=Firefox Developer Edition Web Browser
StartupWMClass=Firefox Developer Edition" > /usr/share/applications/${file}.desktop
#Give all groups permission to execute the shortcut
chmod +x /usr/share/applications/${file}.desktop
#Add firefox dev edition to favorites
echo "Adding to favorites..."
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), '${file}.desktop']"
#Navigate back to home directory
cd ~

echo "Firefox Developer edition installation complete"



