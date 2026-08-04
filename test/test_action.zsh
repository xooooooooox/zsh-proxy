#!/usr/bin/env zsh
source "${0:A:h}/lib.zsh"
_load_plugin

# enable before init -> clear error, non-zero
assert_fail "enable errors when uninitialized" '__zp_enable'

__zp_init
ZSH_PROXY_HTTP="127.0.0.1:6152"; ZSH_PROXY_SOCKS5="127.0.0.1:6153"
ZSH_PROXY_NO_PROXY="localhost"; __zp_save_config

__zp_enable
assert_eq "http_proxy set with scheme"  "$http_proxy"  "http://127.0.0.1:6152"
assert_eq "HTTPS_PROXY mirrors http"    "$HTTPS_PROXY" "http://127.0.0.1:6152"
assert_eq "all_proxy is socks5"         "$all_proxy"   "socks5://127.0.0.1:6153"
assert_eq "NO_PROXY set"                "$NO_PROXY"    "localhost"

__zp_disable
assert_eq "http_proxy unset"  "$http_proxy"  ""
assert_eq "ALL_PROXY unset"   "$ALL_PROXY"   ""
assert_eq "no_proxy unset"    "$no_proxy"    ""

_summary
