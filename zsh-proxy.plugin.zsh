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

# __zp_split HOST:PORT  -> sets reply=(host port), brackets stripped
__zp_split() {
  local hp=${1-} host port
  if [[ $hp == *:* ]]; then
    host=${hp%:*}; port=${hp##*:}
  else
    host=$hp; port=""
  fi
  host=${host#\[}; host=${host%\]}
  reply=("$host" "$port")
}

# __zp_probe_ztcp HOST PORT
__zp_probe_ztcp() {
  zmodload -e zsh/net/tcp 2>/dev/null || zmodload zsh/net/tcp 2>/dev/null || return 2
  if ztcp "$1" "$2" 2>/dev/null; then
    ztcp -c $REPLY 2>/dev/null
    return 0
  fi
  return 1
}

# __zp_probe_nc HOST PORT  (bounded by timeout/gtimeout when present)
__zp_probe_nc() {
  (( ${+commands[nc]} )) || return 2
  local -a t
  if (( ${+commands[timeout]} ));  then t=(timeout 1)
  elif (( ${+commands[gtimeout]} )); then t=(gtimeout 1)
  fi
  $t nc -z -w1 "$1" "$2" >/dev/null 2>&1 && return 0
  return 1
}

# __zp_probe HOST PORT -> 0 reachable / 1 unreachable / 2 no tool
__zp_probe() {
  local method=${ZSH_PROXY_PROBE:-auto} host=$1 port=$2
  case $method in
    ztcp) __zp_probe_ztcp "$host" "$port" ;;
    nc)   __zp_probe_nc   "$host" "$port" ;;
    auto)
      __zp_probe_ztcp "$host" "$port"
      local rc=$?
      if (( rc == 2 )); then
        __zp_probe_nc "$host" "$port"
      else
        return $rc
      fi
      ;;
    *) __zp_warn "unknown ZSH_PROXY_PROBE='$method'"; return 2 ;;
  esac
}

# ---- bootstrap (defined fully in later tasks; guard added now) ----
__zp_bootstrap() { : ; }   # placeholder, replaced in Task 9
[[ -n ${ZSH_PROXY_NO_BOOTSTRAP-} ]] || __zp_bootstrap
