#!/usr/bin/env zsh
# zsh-proxy — manage shell proxy environment variables via a single config file.

: ${ZSH_PROXY_HOME:="${XDG_CONFIG_HOME:-$HOME/.config}/zsh-proxy"}
typeset -gx ZSH_PROXY_HOME
typeset -g  ZSH_PROXY_CONF="${ZSH_PROXY_HOME}/proxy.conf"

__zp_info() { print -r -- "zsh-proxy: $*"; }
__zp_warn() { print -r -u2 -- "zsh-proxy: $*"; }

# __zp_validate_hostport HOST:PORT  -> 0 valid / 1 invalid
__zp_validate_hostport() {
  local hp=${1-} host port
  if [[ $hp == \[*\]:* ]]; then          # [ipv6]:port
    host=${hp%:*}; port=${hp##*:}
  elif [[ $hp == *:* ]]; then            # host:port (split on last colon)
    host=${hp%:*}; port=${hp##*:}
  else
    return 1
  fi
  host=${host#\[}; host=${host%\]}
  [[ -n $host ]] || return 1
  [[ $port == <1-65535> ]] || return 1
  return 0
}

# ---- bootstrap (defined fully in later tasks; guard added now) ----
__zp_bootstrap() { : ; }   # placeholder, replaced in Task 9
[[ -n ${ZSH_PROXY_NO_BOOTSTRAP-} ]] || __zp_bootstrap
