## Unreleased

### Changed
- Rewrote the plugin around a single `proxy.conf` and a `zproxy <subcommand>` dispatcher.
- Reachability probing now uses zsh-native `ztcp` (no `nc` dependency) and never blocks shell startup.
- Manual `zproxy on` enables unconditionally; probing only guards autostart.

### Added
- `zproxy auto on|off`, `zproxy status`, `zproxy help`.
- Optional convenience command (`proxy` by default, `ZSH_PROXY_CMD` to rename/disable), created only when the name is free.
- Input validation for `host:port` in `zproxy config`; `test/` smoke suite.

### Removed
- The four-file config layout (`auto`/`http`/`socks5`/`no_proxy`) and its backward compatibility. Run `zproxy init` after upgrading.
