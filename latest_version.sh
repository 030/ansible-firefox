#!/bin/bash -e

update() {
	readonly LATEST_VERSION=$(curl -s https://product-details.mozilla.org/1.0/firefox_versions.json | jq -r .LATEST_FIREFOX_VERSION)
	readonly VERSION=$(docker run -v ${PWD}:/ansible-firefox utrecht/go-yq:2.1.0 .firefox_version /ansible-firefox/defaults/main.yml)
	readonly LATEST_CHECKSUM=sha512:$(curl https://ftp.mozilla.org/pub/firefox/releases/${LATEST_VERSION}/SHA512SUMS | grep linux-x86_64/en-US/firefox-${LATEST_VERSION}.tar.bz2 | sed -e "s|  linux-x86_64/en-US/firefox-${LATEST_VERSION}.tar.bz2$||g")
	readonly CHECKSUM=$(docker run -v ${PWD}:/ansible-firefox utrecht/go-yq:2.1.0 .firefox_checksum /ansible-firefox/defaults/main.yml)

	git checkout master
	git pull origin master

	sed -i "s|firefox_version: \".*\"|firefox_version: \"${LATEST_VERSION}\"|" defaults/main.yml
	sed -i "s|firefox_checksum: sha512:.*|firefox_checksum: ${LATEST_CHECKSUM}  # yamllint disable-line rule:line-length|" defaults/main.yml

	git config user.name 030
	git config user.email chocolatey030@gmail.com

	git add defaults/main.yml
	git commit -m "Updated checksum and version to respectively '${LATEST_CHECKSUM}' and '${LATEST_VERSION}'"
	git push origin master
}

tag() {
	echo "Create new tag"
	bash <(curl -s https://gist.githubusercontent.com/030/db4d7c5495d751a1001fc425e1f14302/raw/5e375c4b7c5bc74614207796e62a8c4c7d1f39c5/increment_tag.sh)
}

main() {
	update
	tag
}

main
