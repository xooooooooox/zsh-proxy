# zsh-proxy

## install

### zinit

```zsh
zinit snippet 'https://raw.gitcode.com/xooooooooox/zsh-proxy/raw/main/zsh-proxy.plugin.zsh'
```

OR

```zsh
zinit light xooooooooox/zsh-proxy
```

## configure

After [install](#install), you need execute `init_zsh_proxy` and then execute `config_zsh_proxy`

- `init_zsh_proxy`: will auto create plugin config dir `${XDG_CONFIG_HOME-${HOME}}/zsh-proxy` and files`${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/{auto,http,socks,no_proxy}`
- `config_zsh_proxy`: prompt input like bellow

