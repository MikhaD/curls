#!/usr/bin/env bash

# Make sure we have the required commands
failed_dependancy=false

command_installed() {
	if ! command -v $1 &> /dev/null; then
		echo $1 is not installed. Use your package manager to install $1 and try again.
		failed_dependancy=true
		return 1
	else
		return 0
	fi
}

command_installed curl
command_installed jq
command_installed tar

if $failed_dependancy; then
	exit 1
fi

# Check that this script was run with sudo or as su
if [ $EUID -ne 0 ]; then
	echo -e "\e[31;1mERROR:\e[0m Installing \e[94mFireFox Dev Edition\e[0m requires root permissions"
	echo "       Use sudo to run as root"
	exit 1
fi

# Get latest version number from firefox product details API
echo "Finding latest version..."
version=$(curl -s https://product-details.mozilla.org/1.0/firefox_versions.json | jq -r .FIREFOX_DEVEDITION)

echo "Downloading and extracting Firefox Dev Edition $version..."
curl https://download-installer.cdn.mozilla.net/pub/devedition/releases/${version}/linux-x86_64/en-US/firefox-${version}.tar.bz2 | tar xjC /tmp

# Move extracted dir to /opt and change name from firefox to firefox_dev
mv /tmp/firefox /opt/firefox_dev

# Create .desktop file in order to create menu item
echo "Creating .desktop file ..."
echo "[Desktop Entry]
Name=Firefox Dev Edition
GenericName=Firefox Developer Edition
Comment=Firefox Developer Edition Web Browser
Exec=/opt/firefox_dev/firefox %u
Icon=/opt/firefox_dev/browser/chrome/icons/default/default128.png
Type=Application
# https://specifications.freedesktop.org/menu-spec/menu-spec-latest.html#category-registry
Categories=Network;WebBrowser;WebDevelopment;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupWMClass=Firefox Developer Edition
Terminal=false
StartupNotify=true" > /usr/share/applications/firefox-aurora.desktop

echo "Installation complete"
