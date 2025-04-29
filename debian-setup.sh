#!/bin/bash
# liste der Debian packete

DEB_VSCODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
DEB_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

DEBIAN_DEV_APPS=" \
	gcc \
	make \
	gcc-arm-linux-gnueabi \
	binutils-arm-linux-gnueabi \
	gcc-aarch64-linux-gnu \
	binutils-aarch64-linux-gnu \
	bison \
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
	g++ \
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
	docker-ce-cli \
	docker-engine \
	docker-ee-cli \
	docker.io-doc \
	docker-buildx-plugin \
	docker-doc \
	docker-ce \
	docker-ee \
	docker.io \
	docker-ce-rootless-extras \
	docker \
	docker-clean \
	docker-engine-cs \
	docker-registry \
	docker-doc \
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
install_firefox de
deb_install_vscode
deb_install_chrome
