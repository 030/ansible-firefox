#!/bin/bash

set -e

compare_and_exit_if_required() {
	if [[ "$1" != "$2" ]]; then
		echo "Mismatch: $1 vs. $2"
		exit 1
	fi
}

goyq() {
	readonly GOYQ_VERSION=1.1.1
	readonly GOYQ_VERSION_BINARY=go-yq-${GOYQ_VERSION}-linux
	readonly EXPECTED_GOYQ_CHECKSUM=$(curl --location https://github.com/030/go-yq/releases/download/1.1.1/go-yq-1.1.1-linux.sha512.txt | awk '{ print $1 }')

	wget https://github.com/030/go-yq/releases/download/${GOYQ_VERSION}/go-yq-${GOYQ_VERSION}-linux
	readonly ACTUAL_GOYQ_CHECKSUM=$(sha512sum go-yq-${GOYQ_VERSION}-linux | awk '{ print $1 }')

	compare_and_exit_if_required $EXPECTED_GOYQ_CHECKSUM $ACTUAL_GOYQ_CHECKSUM

	chmod +x $GOYQ_VERSION_BINARY
	mv $GOYQ_VERSION_BINARY go-yq
}

compare() {
	readonly LATEST_VERSION=$(curl -s https://product-details.mozilla.org/1.0/firefox_versions.json | jq -r .LATEST_FIREFOX_VERSION)
	readonly VERSION=$(./go-yq -yamlFile defaults/main.yml -key firefox_version)
	readonly LATEST_CHECKSUM="sha512:"$(curl https://ftp.mozilla.org/pub/firefox/releases/${LATEST_VERSION}/SHA512SUMS | grep linux-x86_64/en-US/firefox-${VERSION}.tar.bz2 | sed -e "s|  linux-x86_64/en-US/firefox-${LATEST_VERSION}.tar.bz2$||g")

	readonly CHECKSUM1=$(./go-yq -yamlFile defaults/main.yml -key checksum1)
	readonly CHECKSUM2=$(./go-yq -yamlFile defaults/main.yml -key checksum2)
	readonly CHECKSUM3=$(./go-yq -yamlFile defaults/main.yml -key checksum3)
	readonly CHECKSUM="${CHECKSUM1}${CHECKSUM2}${CHECKSUM3}"

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
