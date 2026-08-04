#!/usr/bin/env zsh
source "${0:A:h}/lib.zsh"
_load_plugin

# load with no config file -> fails cleanly
assert_fail "load fails when no conf" '__zp_load_config'

# init seeds defaults and writes a sourceable file
assert_ok "init succeeds" '__zp_init'
assert_ok "conf file created" '[[ -f $ZSH_PROXY_CONF ]]'
assert_eq "default http"    "$ZSH_PROXY_HTTP"     "127.0.0.1:6152"
assert_eq "default socks5"  "$ZSH_PROXY_SOCKS5"   "127.0.0.1:6153"
assert_eq "default noproxy" "$ZSH_PROXY_NO_PROXY" "localhost,127.0.0.1"
assert_eq "default auto"    "$ZSH_PROXY_AUTO"     "0"

# round-trip: change, save, reload in a clean shell state
ZSH_PROXY_HTTP="10.0.0.1:3128"; __zp_save_config
unset ZSH_PROXY_HTTP
__zp_load_config
assert_eq "reload reflects saved value" "$ZSH_PROXY_HTTP" "10.0.0.1:3128"

# atomic write leaves no temp file behind
assert_ok "no temp leftover" '[[ -z "$(print -r -- ${ZSH_PROXY_CONF}.tmp.*(N))" ]]'

_summary
