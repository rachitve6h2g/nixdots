#!/usr/bin/env nix-shell
#!nix-shell -i bash -p aria2 git

export NIX_CONFIG="experimental-features = nix-command flakes"

# if command -v nix &>/dev/null; then
# 	nix shell nixpkgs#{git,aria2}
# else
# 	echo "nix is not present"
# 	exit 1
# fi

DOWNLOAD_DIR="/tmp"
DISKO_CONFIG="disko-config.nix"
URL="https://raw.githubusercontent.com/rachitve6h2g/nixdots/refs/heads/main/nixos/${DISKO_CONFIG}"

cd "$DOWNLOAD_DIR"

if [[ ! -f "${DOWNLOAD_DIR}/${DISKO_CONFIG}" ]]; then
	echo "Downloading disko-config.nix from your github repo"
	aria2c "${URL}"
	echo "Disko config downloaded"
else
	echo "disko-config already present"
fi

echo "Running disko now"
nix run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko-config.nix
