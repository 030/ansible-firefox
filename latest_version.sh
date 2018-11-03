#!/bin/bash

set -e

goyq() {
	readonly GOYQ_VERSION=1.1.0
	wget https://github.com/030/go-yq/releases/download/${GOYQ_VERSION}/go-yq-${GOYQ_VERSION}-linux
	chmod +x go-yq-${GOYQ_VERSION}-linux
	mv go-yq-1.0.0-linux go-yq
}

compare() {
	readonly LATEST_VERSION=$(curl -s https://product-details.mozilla.org/1.0/firefox_versions.json | jq -r .LATEST_FIREFOX_VERSION)
	readonly VERSION=$(./go-yq -yamlFile defaults/main.yml -key firefox_version)
	readonly LATEST_CHECKSUM="sha512:"$(curl https://ftp.mozilla.org/pub/firefox/releases/${LATEST_VERSION}/SHA512SUMS | grep linux-x86_64/en-US/firefox-${VERSION}.tar.bz2 | sed -e "s|  linux-x86_64/en-US/firefox-${LATEST_VERSION}.tar.bz2$||g")
	readonly CHECKSUM=$(./go-yq -yamlFile defaults/main.yml -key firefox_checksum)

	if [[ "$LATEST_VERSION" != "$VERSION" ]]; then
		echo "A newer version of Firefox is available ($LATEST_VERSION vs. $VERSION)!"
		exit 1
	fi

	if [[ "$LATEST_CHECKSUM" != "$CHECKSUM" ]]; then
		echo "Checksum is incorrect: ($LATEST_CHECKSUM vs. $CHECKSUM)!"
		exit 1
	fi
}

main() {
	goyq
        compare
}

main
