#!/usr/bin/env zsh
typeset -g __T_PASS=0 __T_FAIL=0

_pass() { __T_PASS=$(( __T_PASS + 1 )); print -r -- "  ok: $1"; }
_fail() { __T_FAIL=$(( __T_FAIL + 1 )); print -r -u2 -- "  FAIL: $1"; }

assert_eq()   { [[ "$2" == "$3" ]] && _pass "$1" || _fail "$1 (want '$3' got '$2')"; }
assert_ok()   { if eval "$2"; then _pass "$1"; else _fail "$1 (expected success: $2)"; fi; }
assert_fail() { if eval "$2"; then _fail "$1 (expected failure: $2)"; else _pass "$1"; fi; }

_summary() { print -r -- "PASS=$__T_PASS FAIL=$__T_FAIL"; (( __T_FAIL == 0 )); }

# Source the plugin into an isolated temp home with bootstrap suppressed.
_load_plugin() {
  export ZSH_PROXY_HOME="$(mktemp -d)"
  export ZSH_PROXY_NO_BOOTSTRAP=1
  source "${${(%):-%x}:A:h}/../zsh-proxy.plugin.zsh"
}
