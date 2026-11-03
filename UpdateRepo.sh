#!/bin/bash
# Rebuilds the package index from the .debs in debs/. Run after adding or replacing a package.
# Needs dpkg-scanpackages (MacPorts: sudo port install dpkg, Homebrew: brew install dpkg).
set -e
cd "$(dirname "$0")"

rm -f Packages Packages.gz Packages.bz2
dpkg-scanpackages -m debs /dev/null > Packages
# Cydia picks whichever it understands, old versions want bzip2 or gzip.
gzip -9 -k -n Packages
bzip2 -9 -k Packages

echo "Indexed $(grep -c '^Package:' Packages) package(s)"
