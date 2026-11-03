#!/bin/bash
set -eu

cd "$(dirname "$0")/.."
source ./init.sh help >/dev/null
check_dir="$(mktemp -d)"
trap 'rm -rf "$check_dir"' EXIT
export HERDR_CONFIG_PATH="$check_dir/config.toml"
herdr() {
    if [ "$1" = server ]; then
        return 0
    fi
    command herdr "$@"
}

setup_herdr_keys
herdr config check
cp "$HERDR_CONFIG_PATH" "$check_dir/first.toml"
setup_herdr_keys
cmp "$HERDR_CONFIG_PATH" "$check_dir/first.toml"

cat > "$HERDR_CONFIG_PATH" <<'CONFIG'
onboarding = false
[keys] # custom keys
prefix = "ctrl+b"
next_agent = "prefix+j"
help = "prefix+?"
[ui]
CONFIG
setup_herdr_keys
herdr config check
rg -Fx 'prefix = "ctrl+t"' "$HERDR_CONFIG_PATH"
rg -Fx 'previous_agent = "prefix+["' "$HERDR_CONFIG_PATH"
rg -Fx 'next_agent = "prefix+]"' "$HERDR_CONFIG_PATH"
rg -Fx 'previous_workspace = "prefix+{"' "$HERDR_CONFIG_PATH"
rg -Fx 'next_workspace = "prefix+}"' "$HERDR_CONFIG_PATH"
rg -Fx 'help = "prefix+?"' "$HERDR_CONFIG_PATH"
rg -Fx 'onboarding = false' "$HERDR_CONFIG_PATH"
cp "$HERDR_CONFIG_PATH" "$check_dir/custom.toml"
setup_herdr_keys
cmp "$HERDR_CONFIG_PATH" "$check_dir/custom.toml"

printf '%s\n' '[keys' > "$HERDR_CONFIG_PATH"
cp "$HERDR_CONFIG_PATH" "$check_dir/invalid.toml"
if setup_herdr_keys; then
    echo 'Invalid config unexpectedly accepted' >&2
    exit 1
fi
cmp "$HERDR_CONFIG_PATH" "$check_dir/invalid.toml"
echo 'Herdr key setup checks passed'
