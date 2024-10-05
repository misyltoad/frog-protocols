#!/usr/bin/env sh

set -o pipefail

GIT_ROOT=$(git rev-parse --show-toplevel)

rm --recursive --force "$GIT_ROOT/signatures"
mkdir --parents "$GIT_ROOT/signatures"
echo "*" > "$GIT_ROOT/signatures/.gitignore"

VERSION=$(grep "version:" meson.build | head --lines 1 | cut --delimiter "'" --fields 2)
GITHUB_RELURL="https://github.com/misyltoad/frog-protocols/archive/refs/tags"
GITHUB_ZIP="${VERSION}.zip"
GITHUB_GZTAR="${VERSION}.tar.gz"

for file in "$GITHUB_ZIP" "$GITHUB_GZTAR"; do
  wget --quiet "$GITHUB_RELURL/$file" --output-document "$GIT_ROOT/signatures/$file"
  gpg --armor --detach-sign "$GIT_ROOT/signatures/$file"
  gpg --verify "$GIT_ROOT/signatures/${file}.asc"
  rm --force "$GIT_ROOT/signatures/${file}"
done
