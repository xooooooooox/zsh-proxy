#!/usr/bin/env zsh
source "${0:A:h}/lib.zsh"
_load_plugin

assert_ok   "ipv4 host:port valid"    '__zp_validate_hostport 127.0.0.1:6152'
assert_ok   "hostname:port valid"     '__zp_validate_hostport proxy.local:8080'
assert_ok   "ipv6 [::1]:port valid"   '__zp_validate_hostport "[::1]:6153"'
assert_fail "missing port"            '__zp_validate_hostport 127.0.0.1'
assert_fail "empty host"              '__zp_validate_hostport :6152'
assert_fail "port 0"                  '__zp_validate_hostport 127.0.0.1:0'
assert_fail "port over range"         '__zp_validate_hostport 127.0.0.1:70000'
assert_fail "non-numeric port"        '__zp_validate_hostport 127.0.0.1:abc'
assert_fail "empty input"             '__zp_validate_hostport ""'

_summary
