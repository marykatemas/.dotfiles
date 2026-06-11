# television

![asset](../../assets/asset_television.png)

Config: `~/.config/television/config.toml`

- Default channels: `~/.config/television/cable/`
- Custom channels: `~/.config/television/custom-channels/`

To use custom channel - `tv --cable-dir ~/.config/television/custom-channels channelname`

Update default channels:

```sh
rm -rf ~/.config/television/cable && tv update-channels
```
