#!/bin/bash

# Exit on error
set -e

echo "Installing RoExtract..."
cargo build --release

# Set up variables
APP_NAME="roextract"
VERSION="1.0.4" # TODO: grep from Cargo.toml automatically
ARCH="amd64"
DEB_NAME="${APP_NAME}_${VERSION}_${ARCH}"

# Create a temporary staging area
STAGING_DIR="packages/debian/staging"
mkdir -p "$STAGING_DIR/usr/bin"
mkdir -p "$STAGING_DIR/DEBIAN"

echo "Copying binary..."
cp target/release/RoExtract "$STAGING_DIR/usr/bin/roextract"
chmod 755 "$STAGING_DIR/usr/bin/roextract"

echo "Copying control file..."
cp packages/debian/DEBIAN/control "$STAGING_DIR/DEBIAN/control"

# Enforce correct permissions for the package structure
chmod 0755 "$STAGING_DIR"
chmod 0755 "$STAGING_DIR/DEBIAN"
chmod 0644 "$STAGING_DIR/DEBIAN/control"

# Now build the package
dpkg-deb --build "$STAGING_DIR" "${DEB_NAME}.deb"

# and install it
sudo apt install "./${DEB_NAME}.deb"

# Cleanup
rm -rf "$STAGING_DIR"
