#!/usr/bin/env zsh
source "${0:A:h}/lib.zsh"
_load_plugin

# ZSH_PROXY_HOME honors a pre-set value (so tests can sandbox it)
assert_ok  "home is the temp sandbox" '[[ -n $ZSH_PROXY_HOME && -d $ZSH_PROXY_HOME ]]'
assert_eq  "conf path derived from home" "$ZSH_PROXY_CONF" "$ZSH_PROXY_HOME/proxy.conf"

# output helpers: info -> stdout, warn -> stderr
assert_eq  "info writes to stdout" "$(__zp_info hi 2>/dev/null)" "zsh-proxy: hi"
assert_eq  "warn writes to stderr" "$(__zp_warn oops 2>&1 1>/dev/null)" "zsh-proxy: oops"

_summary
