# zsh-proxy 插件

一个用于管理 Shell 环境中代理设置的 zsh 插件。

## 功能特性

- 支持通过交互式提示轻松配置代理
- 同时支持 HTTP 和 SOCKS5 代理
- 支持在 Shell 启动时自动启用代理（可选）
- 通过环境变量管理系统范围内的代理设置

## 安装

### 使用 [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

1. 将此仓库克隆到 `$ZSH_CUSTOM/plugins` 目录（默认路径为 `~/.oh-my-zsh/custom/plugins`）：

```zsh
git clone https://github.com/xooooooooox/zsh-proxy ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-proxy
```

2. 在你的 `.zshrc` 文件中将此插件加入插件列表：

```zsh
plugins=(... zsh-proxy)
```

### 使用 [zinit](https://github.com/zdharma-continuum/zinit)

在 `.zshrc` 文件中添加以下其中一种配置：

- 从 [GitCode](https://gitcode.com/xooooooooox/zsh-proxy):

```zsh
  zinit snippet 'https://raw.gitcode.com/xooooooooox/zsh-proxy/raw/main/zsh-proxy.plugin.zsh'
```

- 从 [GitHub](https://github.com/xooooooooox/zsh-proxy):

```zsh
zinit light xooooooooox/zsh-proxy
```

### 使用 Antigen

在 `.zshrc` 文件中添加以下内容：

```zsh
antigen bundle xooooooooox/zsh-proxy
```

### 使用 prezto

1. 将此仓库克隆到 Prezto 的 modules 目录：

```zsh
git clone https://github.com/xooooooooox/zsh-proxy ${ZDOTDIR:-~}/.zprezto/contrib/zsh-proxy
```

2. 在 `.zpreztorc` 文件中加入插件：

```zsh
zstyle ':prezto:load' pmodule \
  ... \
  'zsh-proxy' \
  ...
```

### 手动安装

1. 将此仓库克隆到本地任意位置，例如：

```zsh
git clone https://github.com/xooooooooox/zsh-proxy ~/.zsh/zsh-proxy
```

2. 在 .zshrc 文件中添加以下内容：

```zsh
source ~/.zsh/zsh-proxy/zsh-proxy.plugin.zsh
```

## 初始化配置

1. 初始化插件配置：

```zsh
init_zsh_proxy
```

2. 配置代理设置：

```zsh
config_zsh_proxy

```

此命令将会提示你输入：

- SOCKS5 代理地址（默认：127.0.0.1:6153）
- HTTP 代理地址（默认：127.0.0.1:6152）
- 不走代理（no-proxy）域名（默认：localhost,127.0.0.1）

## 使用方法

### 命令

| Command   | Description |
|-----------|-------------|
| `proxy`   | 启用代理设置      |
| `noproxy` | 禁用代理设置      |
| `lsproxy` | 显示当前代理设置    |

### 环境变量

该插件会管理以下环境变量：
• `http_proxy` / `HTTP_PROXY`
• `https_proxy` / `HTTPS_PROXY`
• `all_proxy` / `ALL_PROXY`
• `no_proxy` / `NO_PROXY`

### 自动代理（Auto Proxy）

如果想在 Shell 启动时自动启用代理，可以编辑文件 `${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/auto`：

```zsh
# 禁用自动代理（默认设置）
echo "0" >"${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/auto"

# 启用自动代理
echo "1" >"${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/auto"

```

## 配置文件位置

所有与该插件相关的配置文件都存储在 `${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/` 目录下：
• `auto`: 控制是否自动启用代理
• `http`: HTTP 代理地址
• `socks5`: SOCKS5 代理地址
• `no_proxy`: 需要绕过代理的域名列表（用逗号分隔）