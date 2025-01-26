#!/bin/zsh

__check_whether_init() {
  if [ ! -f "${ZSH_PROXY_HOME}/auto" ] || [ ! -f "${ZSH_PROXY_HOME}/http" ] || [ ! -f "${ZSH_PROXY_HOME}/socks5" ] || [ ! -f "${ZSH_PROXY_HOME}/no_proxy" ]; then
    echo "----------------------------------------"
    echo "You should run following command first:"
    echo "$ init_zsh_proxy"
    echo "----------------------------------------"
  else
    __read_proxy_config
  fi
}

__read_proxy_config() {
  __ZSH_PROXY_AUTO=$(cat "${ZSH_PROXY_HOME}/auto")
  __ZSH_PROXY_SOCKS5=$(cat "${ZSH_PROXY_HOME}/socks5")
  __ZSH_PROXY_HTTP=$(cat "${ZSH_PROXY_HOME}/http")
  __ZSH_PROXY_NO_PROXY=$(cat "${ZSH_PROXY_HOME}/no_proxy")
}

__is_proxy_available() {
  local proxy=${1:?}
  local str proxy_ip proxy_port
  str=${proxy#*://}
  proxy_ip=${str%:*}
  proxy_port=${str#*:}
  proxy_port=${proxy_port%*/}
  # Use nc (netcat) to check if the port is listening
  nc -z "$proxy_ip" "$proxy_port" >/dev/null 2>&1
}

__enable_proxy_all() {
  # http_proxy
  if __is_proxy_available "${__ZSH_PROXY_HTTP}"; then
    export http_proxy="${__ZSH_PROXY_HTTP}"
    export HTTP_PROXY="${__ZSH_PROXY_HTTP}"
    # https_proxy
    export https_proxy="${__ZSH_PROXY_HTTP}"
    export HTTPS_PROXY="${__ZSH_PROXY_HTTP}"
  fi
  if __is_proxy_available "${__ZSH_PROXY_SOCKS5}"; then
    # all_proxy
    export ALL_PROXY="${__ZSH_PROXY_SOCKS5}"
    export all_proxy="${__ZSH_PROXY_SOCKS5}"
  fi
  # no_proxy
  export NO_PROXY="${__ZSH_PROXY_NO_PROXY}"
  export no_proxy="${__ZSH_PROXY_NO_PROXY}"
}

__auto_proxy() {
  if [ "${__ZSH_PROXY_AUTO}" = "1" ]; then
    __enable_proxy_all
  fi
}

__list_proxy() {
  echo "HTTP_PROXY=\"${HTTP_PROXY}\""
  echo "HTTPS_PROXY=\"${HTTPS_PROXY}\""
  echo "ALL_PROXY=\"${ALL_PROXY}\""
  echo "NO_PROXY=\"${NO_PROXY}\""
}

__disable_proxy() {
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
  unset all_proxy
  unset ALL_PROXY
  unset no_proxy
  unset NO_PROXY
}

__config_proxy() {
  echo "========================================"
  echo "ZSH Proxy Plugin Config"
  echo "----------------------------------------"

  echo -n "[socks5 proxy] {Default as 127.0.0.1:6153}
(address:port): "
  read -r __read_socks5

  echo -n "[http proxy]   {Default as 127.0.0.1:6152}
(address:port): "
  read -r __read_http

  echo -n "[no proxy domain] {Default as 'localhost,127.0.0.1'}
(comma separate domains): "
  read -r __read_no_proxy

  if [ -z "${__read_socks5}" ]; then
    __read_socks5="127.0.0.1:6153"
  fi
  if [ -z "${__read_http}" ]; then
    __read_http="127.0.0.1:6152"
  fi
  if [ -z "${__read_no_proxy}" ]; then
    __read_no_proxy="localhost,127.0.0.1"
  fi

  echo "http://${__read_http}" >"${ZSH_PROXY_HOME}/http"
  echo "socks5://${__read_socks5}" >"${ZSH_PROXY_HOME}/socks5"
  echo "${__read_no_proxy}" >"${ZSH_PROXY_HOME}/no_proxy"
  __read_proxy_config
}

init_zsh_proxy() {
  mkdir -p "$ZSH_PROXY_HOME"
  touch "${ZSH_PROXY_HOME}"/auto
  touch "${ZSH_PROXY_HOME}"/http
  touch "${ZSH_PROXY_HOME}"/socks5
  touch "${ZSH_PROXY_HOME}"/no_proxy
  echo "0" >"${ZSH_PROXY_HOME}/auto"
  echo "----------------------------------------"
  echo "Great! The zsh-proxy is initialized"
  echo "----------------------------------------"
  echo "Now you might want to run following command:"
  echo "$ config_zsh_proxy"
  echo "----------------------------------------"
}

config_zsh_proxy() {
  __config_proxy
}

typeset -gx ZSH_PROXY_HOME="${XDG_CONFIG_HOME:-${HOME}}"/zsh-proxy
__check_whether_init
__auto_proxy

# Aliases for backward compatibility
alias proxy=__enable_proxy_all
alias lsproxy=__list_proxy
alias noproxy=__disable_proxy
