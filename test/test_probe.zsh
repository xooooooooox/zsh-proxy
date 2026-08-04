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

# --- auto-mode dispatch return-code propagation (regression) ---
__zp_probe_ztcp() { return 2; }   # simulate ztcp unavailable
__zp_probe_nc()   { return 1; }   # simulate nc: port unreachable
ZSH_PROXY_PROBE=auto __zp_probe 1.2.3.4 9; rc=$?
assert_eq "auto: ztcp-absent + nc-unreachable propagates nc's 1" "$rc" "1"

__zp_probe_nc() { return 0; }     # nc: reachable
ZSH_PROXY_PROBE=auto __zp_probe 1.2.3.4 9; rc=$?
assert_eq "auto: ztcp-absent + nc-reachable propagates nc's 0" "$rc" "0"

__zp_probe_nc() { return 2; }     # nc also absent
ZSH_PROXY_PROBE=auto __zp_probe 1.2.3.4 9; rc=$?
assert_eq "auto: both tools absent returns 2" "$rc" "2"

__zp_probe_ztcp() { return 1; }   # ztcp actively reports unreachable
__zp_probe_nc()   { return 0; }   # nc would say reachable — must NOT be consulted
ZSH_PROXY_PROBE=auto __zp_probe 1.2.3.4 9; rc=$?
assert_eq "auto: ztcp unreachable short-circuits, nc not called" "$rc" "1"

_summary
