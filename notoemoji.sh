SHELL=/bin/bash

DOWNLOADS=~/Downloads
NOTO_URL=https://noto-website-2.storage.googleapis.com/pkgs/Noto-hinted.zip
NOTO_ZIP=noto-font.zip
NOTO_DIR=/usr/share/fonts/opentype/noto

all:	download install

download:
	test -d ${DOWNLOADS}/ || mkdir -vp ${DOWNLOADS}/
	wget -c ${NOTO_URL} -O ${DOWNLOADS}/${NOTO_ZIP}

install:
	sudo mkdir -vp ${NOTO_DIR}
	sudo unzip ${DOWNLOADS}/${NOTO_ZIP} -d ${NOTO_DIR}
