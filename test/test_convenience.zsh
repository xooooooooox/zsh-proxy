#!/usr/bin/env zsh
source "${0:A:h}/lib.zsh"
_load_plugin

# free name -> alias created
unset ZSH_PROXY_CMD
unalias proxy 2>/dev/null
__zp_create_convenience_alias
assert_ok "alias created when free"  '[[ ${aliases[proxy]-} == zproxy ]]'
assert_ok "status reports created"   '[[ $ZSH_PROXY_CMD_STATUS == created* ]]'

# name already in use -> not overwritten
unalias proxy 2>/dev/null
functions[proxy]='print taken'
__zp_create_convenience_alias
assert_ok "existing name not aliased" '[[ -z ${aliases[proxy]-} ]]'
assert_ok "status reports skipped"    '[[ $ZSH_PROXY_CMD_STATUS == skipped* ]]'
unfunction proxy 2>/dev/null

# empty ZSH_PROXY_CMD -> disabled, nothing created
unalias px 2>/dev/null
ZSH_PROXY_CMD=""
__zp_create_convenience_alias
assert_eq "disabled status" "$ZSH_PROXY_CMD_STATUS" "disabled"

# custom name honored
unalias px 2>/dev/null
ZSH_PROXY_CMD="px"
__zp_create_convenience_alias
assert_ok "custom name aliased" '[[ ${aliases[px]-} == zproxy ]]'

_summary
