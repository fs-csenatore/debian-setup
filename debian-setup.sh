#!/bin/bash
# liste der Debian packete

DEB_VSCODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
DEB_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

DEBIAN_DEV_APPS=" \
	linux-headers-amd64
	build-essential \
	make \
	crossbuild-essential-armhf \
	crossbuild-essential-arm64 \
	bison \
	ninja-build \
	flex \
	libssl-dev \
	lzop \
	xxd \
	libarchive-zip-perl \
	gitk \
	git-cola \
	pkexec \
	meld \
	libncurses-dev \
	libudev-dev \
	libsdl2-dev \
	python3-dev \
	nfs-common \
	qtcreator \
	curl \
	chrpath \
	diffstat \
	gawk \
	lz4 \
	device-tree-compiler \
	gnome-disk-utility \
	u-boot-tools \
	tmux \
	nmap \
	docker-compose \
	docker.io-doc \
	docker-doc \
	docker.io \
	docker-clean \
	docker-registry \
	docker-doc \
	cifs-tools \
"

DEBIAN_REMOVE_APPS=" \
	firefox-esr \
"

CODE_EXTENSIONS=" \
	eamodio.gitlens \
	eclipse-cdt.memory-inspector \
	mcu-debug.debug-tracker-vscode \
	mindaro-dev.file-downloader \
	ms-vscode.cmake-tools \
	ms-vscode.cpptools \
	ms-vscode.vscode-serial-monitor \
	nxpsemiconductors.mcuxpresso \
	plorefice.devicetree \
	shardulm94.trailing-spaces \
"

deb_common_install() {
    wget -O /tmp/app.deb $1
    sudo apt install -y /tmp/app.deb
    rm /tmp/app.deb
}

deb_install_vscode() {
    if [ ! $(which code) ]; then
        deb_common_install $DEB_VSCODE
    else
        echo "VS-CODE allready installed"
    fi
}

install_vscode_extensions() {
	for ext in $CODE_EXTENSIONS; do
  		code --install-extension "$ext" --force
	done
}

deb_install_chrome() {
	if [ ! $(which google-chrome) ]; then
		deb_common_install $DEB_CHROME
	else
		echo "Google Chrome allready installed"
	fi
}

install_firefox() {
	wget -O /tmp/firefox-install.sh "https://raw.githubusercontent.com/CS-Alchemist/firefox-linux-installer/refs/heads/main/firefox-install.sh"
	chmod u+x /tmp/firefox-install.sh

	sudo /tmp/firefox-install.sh $1
	rm /tmp/firefox-install.sh

	sudo usermod -aG firefox $USER
}

###MAIN###
sudo apt update
sudo apt install $DEBIAN_DEV_APPS
sudo apt remove $DEBIAN_REMOVE_APPS
install_firefox de
deb_install_vscode
install_vscode_extensions
deb_install_chrome
