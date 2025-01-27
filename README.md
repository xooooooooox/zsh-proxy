# zsh-proxy plugin

A zsh plugin for managing shell environment proxy settings.

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

## Features

- Easy proxy configuration through interactive prompts
- Support for both HTTP and SOCKS5 proxies
- Automatic proxy activation on shell startup (optional)
- Environment variable management for system-wide proxy settings
- No-proxy list for excluding local addresses

## Setup

1. Initialize the plugin configuration:
```zsh
init_zsh_proxy
```

2. Configure proxy settings:
```zsh
config_zsh_proxy
```

This will prompt you to enter:
- SOCKS5 proxy address (default: 127.0.0.1:6153)
- HTTP proxy address (default: 127.0.0.1:6152)
- No-proxy domains (default: localhost,127.0.0.1)

## Usage

### Commands

| Command | Description |
|---------|-------------|
| `proxy` | Enable proxy settings |
| `noproxy` | Disable proxy settings |
| `lsproxy` | Display current proxy settings |

### Environment Variables

The plugin manages the following environment variables:
- `http_proxy` / `HTTP_PROXY`
- `https_proxy` / `HTTPS_PROXY`
- `all_proxy` / `ALL_PROXY`
- `no_proxy` / `NO_PROXY`

### Auto Proxy

To enable automatic proxy activation on shell startup, edit `${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/auto`:
```zsh
# Disable auto proxy (default)
echo "0" > "${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/auto"

# Enable auto proxy
echo "1" > "${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/auto"
```

## Configuration Files

All configuration files are stored in `${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/`:
- `auto`: Controls automatic proxy activation
- `http`: HTTP proxy URL
- `socks5`: SOCKS5 proxy URL
- `no_proxy`: Comma-separated list of domains to bypass proxy

## Author

- [@xooooooooox](https://github.com/xooooooooox)
