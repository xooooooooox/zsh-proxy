#!/usr/bin/env zsh
source "${0:A:h}/lib.zsh"
_load_plugin
zmodload zsh/datetime

# __zp_split
__zp_split "127.0.0.1:6152"
assert_eq "split host"  "$reply[1]" "127.0.0.1"
assert_eq "split port"  "$reply[2]" "6152"
__zp_split "[::1]:6153"
assert_eq "split ipv6 host strips brackets" "$reply[1]" "::1"
assert_eq "split ipv6 port"                 "$reply[2]" "6153"

# probe: open a real listener, expect reachable
zmodload zsh/net/tcp
local lport=54329
ztcp -l $lport 2>/dev/null
local lfd=$REPLY
assert_ok "probe reaches open port" '__zp_probe 127.0.0.1 '$lport
ztcp -c $lfd 2>/dev/null

# probe: closed port -> unreachable AND fast (< 1s), guards against the nc hang regression
local t0=$EPOCHREALTIME
assert_fail "probe rejects closed port" '__zp_probe 127.0.0.1 54330'
local dt=$(( EPOCHREALTIME - t0 ))
assert_ok "probe fails fast (<1s)" '(( '$dt' < 1.0 ))'

_summary
