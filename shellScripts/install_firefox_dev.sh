#!/usr/bin/env bash

clear

cd ~
temp=temp${RANDOM}
mkdir $temp
cd $temp
wget https://download-installer.cdn.mozilla.net/pub/devedition/releases/ > /dev/null

function ver() {
tac index.html | while read line
do
	if [[ $line =~ "href=" ]]
	then
		line=${line%%'/</a'*}
		echo ${line#*'/">'*}
		break
	fi
done
}
version=$(ver $1)

file=${1:-firefox_dev}

read -p "Remove regular firefox [y/N]: "
if [ ${REPLY:-n} = y ]
then  
  echo "Removing regular firefox..."
  sudo apt-get remove firefox > /dev/null
fi
#Navigate to /opt dir where firefox will be installed
cd /opt
#Download tar archive
echo "Downloading Firefox Dev Edition..."
wget https://download-installer.cdn.mozilla.net/pub/devedition/releases/${version}/linux-x86_64/en-US/firefox-${version}.tar.bz2 > /dev/null
#Extract tar archive
echo "Extracting..."
tar xvf firefox-${version}.tar.bz2 > /dev/null
#Delete tar archive
rm firefox-${version}.tar.bz2 > /dev/null
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
Exec=/usr/local/bin/${file}
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
favorites=$(gsettings get org.gnome.shell favorite-apps)
gsettings set org.gnome.shell favorite-apps "${favorites::-1}, '${file}.desktop']"
#Navigate back to home directory
cd ~
rm -rf $temp

echo "Firefox Developer edition installation complete"
read -p "Do you want to delete this script [Y/n]: "
if [ ${REPLY:-y} != n ]
then
  rm -rf `basename "$0"`
fi

echo "Installation courtesy of MikhaD"