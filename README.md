# BackupScriptsLinuxManjaro

Scripts with which you can easily backup data on Linux PCs (Manjaro 18.1 in this case).

- [`backup_home_directory.sh`](backup_home_directory.sh) uses `rsync` to backup a (for example the home) directory
- [`get_installed_programs_pacman.sh`](get_installed_programs_pacman.sh) reads explicitly installed `pacman` packages and converts them into a `.csv` file

## Customized shortcuts

### XFCE

`Window Manager` > `Keyboard`

| Description  | Shortcut      |
| ------------ | ------------- |
| Show Desktop | `Super` + `D` |

### General

`Keyboard` > `Application Shortcuts`

| Description  | Command | Shortcut          |
| ------------ | ------- | ----------------- |
| File search overlay | `catfish` | `Super` + `Space` |
| App search overlay | `xfce4-appfinder` | `Super` + `A` |
| Screenshot | `xfce4-screenshooter -fd 1 -s Pictures` | `Print` |
| Screenshot of area | `xfce4-screenshooter -r -s Pictures` | `Ctrl` + `Shift` + `Print` |
| Start menu | `xfce4-popup-whiskermenu` | `Super` + `S` |
| Display settings | `xfce4-display-settings` | `Super` + `P` |
| Lock screen | `xflock4` | `Super` + `L` |

## Debug boot problems (`[Failed] Message...`)

To see what went wrong run the command:

```sh
systemctl --state=failed
# UNIT                         LOAD   ACTIVE SUB    DESCRIPTION
# ● systemd-modules-load.service loaded failed failed Load Kernel Modules
# LOAD   = Reflects whether the unit definition was properly loaded.
# ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
# SUB    = The low-level unit activation state, values depend on unit type.
#
# 1 loaded units listed.
```

If a service failed this can be even further debugged by looking at the logs:

```sh
sudo journalctl -u systemd-modules-load.service
# ...
# -- Reboot --
# Feb 13 15:36:31 niklas-pc systemd-modules-load[288]: Inserted module 'crypto_user'
# Feb 13 15:36:31 niklas-pc systemd-modules-load[288]: Failed to find module 'vboxdrv'
# Feb 13 15:36:31 niklas-pc systemd-modules-load[288]: Failed to find module # 'vboxnetadp'
# Feb 13 15:36:31 niklas-pc systemd-modules-load[288]: Failed to find module 'vboxnetflt'
# Feb 13 15:36:31 niklas-pc systemd-modules-load[288]: Inserted module 'nvidia'
# Feb 13 15:36:31 niklas-pc systemd-modules-load[288]: Inserted module 'nvidia_drm'
# Feb 13 15:36:31 niklas-pc systemd-modules-load[288]: Inserted module 'uinput'
```
