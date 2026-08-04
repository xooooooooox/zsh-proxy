#!/usr/bin/env zsh
source "${0:A:h}/lib.zsh"
_load_plugin
zmodload zsh/net/tcp

__zp_init

# AUTO=0 -> nothing exported, no probing
ZSH_PROXY_AUTO=0; __zp_save_config; __zp_load_config
__zp_disable
__zp_autostart
assert_eq "auto off exports nothing" "$http_proxy$all_proxy" ""

# AUTO=1, reachable http listener -> exported; unreachable socks -> skipped
local lport=54331
ztcp -l $lport 2>/dev/null; local lfd=$REPLY
ZSH_PROXY_AUTO=1
ZSH_PROXY_HTTP="127.0.0.1:$lport"
ZSH_PROXY_SOCKS5="127.0.0.1:54332"   # nothing listening
ZSH_PROXY_NO_PROXY="localhost"
__zp_save_config
__zp_disable
__zp_autostart 2>/dev/null
assert_eq "reachable http exported"    "$http_proxy" "http://127.0.0.1:$lport"
assert_eq "unreachable socks skipped"  "$all_proxy"  ""
assert_eq "noproxy always set on auto" "$no_proxy"   "localhost"
ztcp -c $lfd 2>/dev/null

_summary
