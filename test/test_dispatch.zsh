#!/usr/bin/env zsh
source "${0:A:h}/lib.zsh"
_load_plugin
__zp_init

# on/off routed through the dispatcher
zproxy on  >/dev/null 2>&1
assert_eq "zproxy on enables"  "$http_proxy" "http://127.0.0.1:6152"
zproxy off >/dev/null 2>&1
assert_eq "zproxy off disables" "$http_proxy" ""

# auto toggle persists
zproxy auto on  >/dev/null 2>&1
unset ZSH_PROXY_AUTO; __zp_load_config
assert_eq "auto on persisted"  "$ZSH_PROXY_AUTO" "1"
zproxy auto off >/dev/null 2>&1
unset ZSH_PROXY_AUTO; __zp_load_config
assert_eq "auto off persisted" "$ZSH_PROXY_AUTO" "0"

# unknown subcommand -> non-zero
assert_fail "unknown subcommand fails" 'zproxy bogus >/dev/null 2>&1'

# help and status produce output and succeed
assert_ok "help prints"   '[[ -n "$(zproxy help 2>&1)" ]]'
assert_ok "status prints" '[[ -n "$(zproxy status 2>&1)" ]]'
assert_ok "ls prints"     '[[ -n "$(zproxy ls 2>&1)" ]]'

_summary
