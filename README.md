# .dotfiles

> [!WARNING]
> install.sh currently only for manual install.

![asset](assets/asset.png)



## .config/sketchybar/README.md

# sketchybar

> [!NOTE]
> SketchyBar config from .dotfiles repo.

![asset](https://raw.githubusercontent.com/marykatemas/.dotfiles/master/assets/asset_sketchybar.png)

![asset](https://raw.githubusercontent.com/marykatemas/.dotfiles/master/assets/asset_sketchybar_zen.png)
<kbd>⌃⌥⌘⇧ + Z</kbd> — toggle zen mode (via skhd).

Config: `~/.config/sketchybar/`

## Requirements

- **Rust** `cargo` — compiles `sbar-cpu_temp_helper` and `sbar-network_speed_helper`
- **C** `make` — compiles `sbar-cpu_usage_helper`
- **External palette** — `~/.dotfiles/styles/palette.sh` must exist (sourced by `colors.sh`)

```
├── sketchybarrc              # Entry: bar, defaults, helpers, items, events, brackets
├── sourcefile.sh             # Shared source (colors.sh + paths.sh)
├── colors.sh                 # Semantic color variables
├── paths.sh                  # CONFIG_DIR, ITEM_DIR, PLUGIN_DIR, STATE_DIR
├── icon_map.sh               # kvndrsslr/sketchybar-app-font (icon bundle)
├── items/*.sh                # Item definitions (add + set + subscribe)
├── plugins/pluginname/       # Item event handlers
│           ├── plugin.sh     # Event handler (sourced by sketchybar)
│           └── click.sh      # Optional: click action (standalone or sources plugin.sh)
└── helpers/                  # Compiled background daemons
    ├── sbar-cpu_usage_helper/     # C/Mach: pushes CPU graph via Mach IPC
    ├── sbar-cpu_temp_helper/      # Rust: polls temp, triggers cpu_temp_update
    └── sbar-network_speed_helper/ # Rust: polls net, triggers network_speed_update
```

- Bootstrapped by AeroSpace via `~/.config/aerospace/aerospace.toml`.
- skhd also started by AeroSpace and used for keybindings that invoke SketchyBar click scripts.

## Reload SketchyBar & Rebuild helpers

```sh
sketchybar --reload
```

## .config/tmux/README.md

# tmux

![asset](assets/asset_tmux.png)

Config: `~/.config/tmux/tmux.conf`

TPM auto-installs on tmux start if missing.

Inside tmux:

- Install plugins: `prefix + Shift+i` (capital I)
- Update plugins: `prefix + Shift+u` (capital U)
- Reload config: `prefix + r`

Prefix is `Ctrl + a`

## .config/television/README.md

# television

![asset](assets/asset_television.png)

Config: `~/.config/television/config.toml`

- Default channels: `~/.config/television/cable/`
- Custom channels: `~/.config/television/custom-channels/`

To use custom channel - `tv --cable-dir ~/.config/television/custom-channels channelname`

Update default channels:

```sh
rm -rf ~/.config/television/cable && tv update-channels
```
