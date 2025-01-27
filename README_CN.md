# zsh-proxy

一个用于管理 shell 环境代理设置的 zsh 插件。

## 安装

### 使用 [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

1. 克隆此仓库到 `$ZSH_CUSTOM/plugins` 目录（默认为 `~/.oh-my-zsh/custom/plugins`）：

```zsh
git clone https://github.com/xooooooooox/zsh-proxy ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-proxy
```

2. 在 `.zshrc` 文件中添加插件：

```zsh
plugins=(... zsh-proxy)
```

### 使用 [zinit](https://github.com/zdharma-continuum/zinit)

在 `.zshrc` 文件中添加以下任一配置：

从 [GitCode](https://gitcode.com/xooooooooox/zsh-proxy) 安装：
```zsh
zinit snippet 'https://raw.gitcode.com/xooooooooox/zsh-proxy/raw/main/zsh-proxy.plugin.zsh'
```

从 [GitHub](https://github.com/xooooooooox/zsh-proxy) 安装：
```zsh
zinit light xooooooooox/zsh-proxy
```

### 使用 [Antigen](https://github.com/zsh-users/antigen)

在 `.zshrc` 文件中添加以下配置：

```zsh
antigen bundle xooooooooox/zsh-proxy
```

### 使用 [prezto](https://github.com/sorin-ionescu/prezto)

1. 克隆此仓库到 Prezto 模块目录：

```zsh
git clone https://github.com/xooooooooox/zsh-proxy ${ZDOTDIR:-~}/.zprezto/contrib/zsh-proxy
```

2. 在 `.zpreztorc` 文件中添加插件：

```zsh
zstyle ':prezto:load' pmodule \
  ... \
  'zsh-proxy' \
  ...
```

### 手动安装

1. 克隆此仓库到本地：

```zsh
git clone https://github.com/xooooooooox/zsh-proxy ~/.zsh/zsh-proxy
```

2. 在 `.zshrc` 文件中添加以下配置：

```zsh
source ~/.zsh/zsh-proxy/zsh-proxy.plugin.zsh
```

## 配置

在[安装](#安装)之后，你需要执行 `init_zsh_proxy` 然后执行 `config_zsh_proxy`

- `init_zsh_proxy`: 将自动创建插件配置目录 `${XDG_CONFIG_HOME-${HOME}}/zsh-proxy` 和配置文件 `${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/{auto,http,socks,no_proxy}`
- `config_zsh_proxy`: 按提示输入以下配置信息：
    - socks5 代理地址（默认为 127.0.0.1:6153）
    - http 代理地址（默认为 127.0.0.1:6152）
    - 无需代理的域名（默认为 localhost,127.0.0.1）

## 使用方法

### 命令

- `proxy`: 启用代理设置
- `noproxy`: 禁用代理设置
- `lsproxy`: 显示当前代理设置

### 环境变量

插件会设置以下环境变量：

- `http_proxy` / `HTTP_PROXY`
- `https_proxy` / `HTTPS_PROXY`
- `all_proxy` / `ALL_PROXY`
- `no_proxy` / `NO_PROXY`

### 自动代理

你可以通过编辑 `${XDG_CONFIG_HOME-${HOME}}/zsh-proxy/auto` 文件来控制是否在 shell 启动时自动启用代理：

- `0`: 禁用自动代理（默认）
- `1`: 启用自动代理