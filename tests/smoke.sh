#!/bin/sh
set -eu
log=$(mktemp)
trap 'rm -f "$log"' EXIT
image=${1:?image reference required}
platform=${2:?platform required}
config=$(docker image inspect "$image" --format '{{json .Config.Cmd}} {{json .Config.Shell}}')
test "$config" = '["/bin/bash"] ["/bin/bash","-c"]'
docker run --rm --platform "$platform" "$image" /bin/bash -euc '
  test -n "$BASH_VERSION"
  cat /etc/alpine-release
  apk info -v
  bash --version
  curl --version
  vim --version
  jq --version
  test "$(printf "{\"ok\":true}" | jq -r .ok)" = true
  printf "debug-ok" > /tmp/input
  test "$(curl --fail --silent file:///tmp/input)" = debug-ok
  vim -Nu NONE -n -es /tmp/input -c "%s/debug-ok/vim-ok/" -c wq
  test "$(cat /tmp/input)" = vim-ok
'
docker run --rm -i --platform "$platform" "$image" /bin/bash -ic \
  'test -n "$BASH_VERSION" && [[ $- == *i* ]] && echo interactive-ok' > "$log" 2>&1
cat "$log"
grep -q '^interactive-ok$' "$log"
