# zsh-proxy 插件

一个用于管理 Shell 环境中代理设置的 zsh 插件。

## 功能特性

- 通过交互式提示轻松配置代理
- 支持 `HTTP` 和 `SOCKS5` 代理协议
- 支持 Shell 启动时自动启用代理（可选）
- 开启自动代理时自动检测代理可用性
- 管理系统级代理环境变量
- 包含排除本地地址的不代理列表

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
zproxy init
```

2. 配置代理设置：

```zsh
zproxy config
```

此命令将会提示你输入：

- HTTP 代理地址（默认：127.0.0.1:6152）
- SOCKS5 代理地址（默认：127.0.0.1:6153）
- 不走代理（no-proxy）域名（默认：localhost,127.0.0.1）

## 使用方法

### 命令

所有功能都通过 `zproxy` 命令暴露：

| Command            | Description               |
|--------------------|----------------------------|
| `zproxy on`        | 启用代理环境变量（不检测可达性）  |
| `zproxy off`       | 禁用代理环境变量               |
| `zproxy ls`        | 列出当前代理环境变量            |
| `zproxy status`    | 显示配置路径、http/socks5/no-proxy、自动启动状态 |
| `zproxy auto`      | 显示自动启动状态               |
| `zproxy auto on`   | 启用新 Shell 的自动启动         |
| `zproxy auto off`  | 禁用新 Shell 的自动启动         |
| `zproxy config`    | 交互式配置代理                |
| `zproxy init`      | 创建默认配置文件               |
| `zproxy help`      | 显示用法说明                 |

默认情况下，插件还会创建一个更短的便捷命令 `proxy`，作为 `zproxy` 的别名——仅在 `proxy` 这个名字尚未被命令、函数或别名占用时才会创建（因此不会覆盖你已有的任何同名命令）。可以在插件加载前设置 `ZSH_PROXY_CMD` 来重命名它，或设置 `ZSH_PROXY_CMD=""` 来完全禁用它。`zproxy status` 会报告该便捷命令是已创建、已跳过还是已禁用。

### 环境变量

该插件会管理以下环境变量：
• `http_proxy` / `HTTP_PROXY`
• `https_proxy` / `HTTPS_PROXY`
• `all_proxy` / `ALL_PROXY`
• `no_proxy` / `NO_PROXY`

### 自动代理（Auto Proxy）

如果想在 Shell 启动时自动启用代理：

```zsh
zproxy auto on
```

```zsh
zproxy auto off  # 禁用（默认）
```

启用自动启动后，每个代理在启用前都会先检测可达性；不可达的代理会被跳过并给出警告，而不会阻塞 Shell 启动。`zproxy on` 始终无条件启用，不检测可达性。

## 配置

所有配置项都存放在单个文件 `${XDG_CONFIG_HOME:-$HOME/.config}/zsh-proxy/proxy.conf` 中，是一个可被 source 的 `KEY="value"` 文件：

```zsh
ZSH_PROXY_HTTP="127.0.0.1:6152"
ZSH_PROXY_SOCKS5="127.0.0.1:6153"
ZSH_PROXY_NO_PROXY="localhost,127.0.0.1"
ZSH_PROXY_AUTO="0"
```

`ZSH_PROXY_HTTP` 和 `ZSH_PROXY_SOCKS5` 是不带协议前缀的 `host:port` 值；导出环境变量时会自动补上 `http://` / `socks5://` 前缀。可通过 `zproxy init` / `zproxy config` 管理，也可以直接手动编辑该文件。

### 升级说明

旧版的四文件配置（`auto`/`http`/`socks5`/`no_proxy`）不再被读取。升级后请运行 `zproxy init`（或 `zproxy config`）以创建新的 `proxy.conf`。