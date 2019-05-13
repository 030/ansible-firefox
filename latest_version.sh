#!/bin/bash

set -e

compare_and_exit_if_required() {
	if [[ "$1" != "$2" ]]; then
		echo "Mismatch: $1 vs. $2"
		exit 1
	fi
}

compare() {
	readonly LATEST_VERSION=$(curl -s https://product-details.mozilla.org/1.0/firefox_versions.json | jq -r .LATEST_FIREFOX_VERSION)
	readonly VERSION=$(docker run -v ${PWD}:/ansible-firefox utrecht/go-yq:2.1.0 .firefox_version /ansible-firefox/defaults/main.yml)
	readonly LATEST_CHECKSUM=sha512:$(curl https://ftp.mozilla.org/pub/firefox/releases/${LATEST_VERSION}/SHA512SUMS | grep linux-x86_64/en-US/firefox-${VERSION}.tar.bz2 | sed -e "s|  linux-x86_64/en-US/firefox-${LATEST_VERSION}.tar.bz2$||g")
	readonly CHECKSUM=$(docker run -v ${PWD}:/ansible-firefox utrecht/go-yq:2.1.0 .firefox_checksum /ansible-firefox/defaults/main.yml)

	compare_and_exit_if_required $LATEST_VERSION $VERSION
	compare_and_exit_if_required $LATEST_CHECKSUM $CHECKSUM
}

main() {
	compare
}

main
