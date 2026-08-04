#!/usr/bin/env zsh
source "${0:A:h}/lib.zsh"
_load_plugin

# empty input takes the default
assert_eq "prompt uses default on empty" \
  "$(printf '\n' | __zp_prompt_hostport 'http' '127.0.0.1:6152' 2>/dev/null)" \
  "127.0.0.1:6152"

# first (invalid) line rejected, second (valid) accepted
assert_eq "prompt loops until valid" \
  "$(printf 'bogus\n10.0.0.9:8080\n' | __zp_prompt_hostport 'http' '1.1.1.1:1' 2>/dev/null)" \
  "10.0.0.9:8080"

# full interactive flow: http, socks5, no_proxy (auto preserved)
__zp_init
ZSH_PROXY_AUTO=1; __zp_save_config
printf '10.0.0.1:3128\n10.0.0.1:1080\nlocalhost\n' | __zp_config_interactive >/dev/null 2>&1
unset ZSH_PROXY_HTTP ZSH_PROXY_SOCKS5 ZSH_PROXY_NO_PROXY ZSH_PROXY_AUTO
__zp_load_config
assert_eq "config saved http"    "$ZSH_PROXY_HTTP"     "10.0.0.1:3128"
assert_eq "config saved socks5"  "$ZSH_PROXY_SOCKS5"   "10.0.0.1:1080"
assert_eq "config saved noproxy" "$ZSH_PROXY_NO_PROXY" "localhost"
assert_eq "config preserved auto" "$ZSH_PROXY_AUTO"    "1"

_summary
