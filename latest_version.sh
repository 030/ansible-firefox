#!/bin/bash

set -e

goyq() {
	wget https://github.com/030/go-yq/releases/download/1.0.0/go-yg-1.0.0-linux
	chmod +x go-yg-1.0.0-linux
}

compare() {
	readonly LATEST_VERSION=$(curl -s https://product-details.mozilla.org/1.0/firefox_versions.json | jq -r .LATEST_FIREFOX_VERSION)
	readonly VERSION=$(./go-yg-1.0.0-linux -yamlFile defaults/main.yml -key firefox_version)
	
	if [[ "$LATEST_VERSION" != "$VERSION" ]]; then
		echo "A newer version of Firefox is available ($LATEST_VERSION vs. $VERSION)!"
		exit 1
	fi
}

main() {
	goyq
        compare
}

main
