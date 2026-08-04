# zsh-proxy plugin

A zsh plugin for managing shell environment proxy settings.

## Features

- Easy proxy configuration through interactive prompts
- Support for both HTTP and SOCKS5 proxies
- Automatic proxy activation on shell startup (optional)
- Automatic proxy availability check when auto-start is enabled
- Environment variable management for system-wide proxy settings
- No-proxy list for excluding local addresses

## Installation

### Using [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

1. Clone this repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)

```zsh
git clone https://github.com/xooooooooox/zsh-proxy ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-proxy
```

2. Add the plugin to the list of plugins in your `.zshrc` file:

```zsh
plugins=(... zsh-proxy)
```

### Using [zinit](https://github.com/zdharma-continuum/zinit)

Add one of the following to your `.zshrc` file:

From [GitCode](https://gitcode.com/xooooooooox/zsh-proxy):

```zsh
zinit snippet 'https://raw.gitcode.com/xooooooooox/zsh-proxy/raw/main/zsh-proxy.plugin.zsh'
```

From [GitHub](https://github.com/xooooooooox/zsh-proxy):

```zsh
zinit light xooooooooox/zsh-proxy
```

### Using [Antigen](https://github.com/zsh-users/antigen)

Add the following to your `.zshrc` file:

```zsh
antigen bundle xooooooooox/zsh-proxy
```

### Using [prezto](https://github.com/sorin-ionescu/prezto)

1. Clone this repository into your Prezto modules directory:

```zsh
git clone https://github.com/xooooooooox/zsh-proxy ${ZDOTDIR:-~}/.zprezto/contrib/zsh-proxy
```

2. Add the plugin to your `.zpreztorc` file:

```zsh
zstyle ':prezto:load' pmodule \
  ... \
  'zsh-proxy' \
  ...
```

### Manual Installation

1. Clone this repository somewhere on your machine:

```zsh
git clone https://github.com/xooooooooox/zsh-proxy ~/.zsh/zsh-proxy
```

2. Add the following to your `.zshrc` file:

```zsh
source ~/.zsh/zsh-proxy/zsh-proxy.plugin.zsh
```

## Setup

1. Initialize the plugin configuration:

```zsh
zproxy init
```

2. Configure proxy settings:

```zsh
zproxy config
```

This will prompt you to enter:

- HTTP proxy address (default: 127.0.0.1:6152)
- SOCKS5 proxy address (default: 127.0.0.1:6153)
- No-proxy domains (default: localhost,127.0.0.1)

## Usage

### Commands

All functionality is exposed through the `zproxy` command:

| Command           | Description                                      |
|-------------------|---------------------------------------------------|
| `zproxy on`       | Enable proxy env vars (no reachability check)     |
| `zproxy off`      | Disable proxy env vars                            |
| `zproxy ls`       | List current proxy env vars                       |
| `zproxy status`   | Show config path, http/socks5/no-proxy, auto state |
| `zproxy auto`     | Show autostart state                               |
| `zproxy auto on`  | Enable autostart on new shells                    |
| `zproxy auto off` | Disable autostart on new shells                   |
| `zproxy config`   | Interactive proxy configuration                    |
| `zproxy init`     | Create the default config file                     |
| `zproxy help`     | Show usage                                          |

By default the plugin also creates a shorter convenience command, `proxy`, as an alias for `zproxy` — it is only created when the name `proxy` isn't already a command, function, or alias in your shell (so it never overwrites anything of yours). Set `ZSH_PROXY_CMD` before the plugin loads to rename it, or set `ZSH_PROXY_CMD=""` to disable it entirely. `zproxy status` reports whether the convenience command was created, skipped, or disabled.

### Environment Variables

The plugin manages the following environment variables:

- `http_proxy` / `HTTP_PROXY`
- `https_proxy` / `HTTPS_PROXY`
- `all_proxy` / `ALL_PROXY`
- `no_proxy` / `NO_PROXY`

### Auto Proxy

To enable automatic proxy activation on shell startup:

```zsh
zproxy auto on
```

```zsh
zproxy auto off  # disable (default)
```

When autostart is enabled, each proxy is reachability-checked before being enabled; an unreachable proxy is skipped with a warning instead of blocking shell startup. `zproxy on` always enables unconditionally, without a reachability check.

## Configuration

All settings live in a single file, `${XDG_CONFIG_HOME:-$HOME/.config}/zsh-proxy/proxy.conf`, a sourceable `KEY="value"` file:

```zsh
ZSH_PROXY_HTTP="127.0.0.1:6152"
ZSH_PROXY_SOCKS5="127.0.0.1:6153"
ZSH_PROXY_NO_PROXY="localhost,127.0.0.1"
ZSH_PROXY_AUTO="0"
```

`ZSH_PROXY_HTTP` and `ZSH_PROXY_SOCKS5` are bare `host:port` values; the `http://` / `socks5://` scheme is added automatically when the env vars are exported. Manage it with `zproxy init` / `zproxy config`, or hand-edit it directly.

### Upgrading

The old four-file config (`auto`/`http`/`socks5`/`no_proxy`) is no longer read. After upgrading, run `zproxy init` (or `zproxy config`) to create the new `proxy.conf`.
