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

- Bootstrapped by AeroSpace via `~/.config/aerospace/aerospace.toml`.
- skhd also started by AeroSpace and used for keybindings that invoke SketchyBar click scripts.

**External palette** — `~/.dotfiles/styles/palette.sh` must exist (sourced by `colors.sh`)

```
├── sketchybarrc  # entry point
├── sourcefile.sh  # shared source of everything
├── colors.sh
├── icons.sh
├── paths.sh
├── assets/  # some .png files
├── items/itemname.sh
├── plugins/pluginname/
│           ├── plugin.sh
│           ├── click.sh    # optional
│           └── watcher.sh  # optional
└── helpers/
    ├── rainbow.py  # creating rainbow brackets
    └── event_providers/
        ├── makefile
        ├── sketchybar.h
        ├── cpu_load/  # felixkratz helper
        │   ├── makefile
        │   ├── cpu_load.c
        │   ├── cpu.h
        │   └── bin/  # in .gitignore
        └── network_load/  # felixkratz helper
            ├── makefile
            ├── network_load.c
            ├── network.h
            └── bin/  # in .gitignore
```

## Reload SketchyBar

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
