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

`Window Manager Tweaks` > `Accessibility`

- [ ] Raise windows when any mouse button is pressed (per default this is checked)

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

### Fixes

If the (bottom) panel stops working like not showing the overlay on `WINDOWS` key or not audo hiding any more) run:

```sh
xfce4-panel -r
```

## Performance

### CPU

Set CPU scaling governor to performance instead of the default powersave:

```sh
$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
powersave
powersave
powersave
powersave
$ sudo sh -c "echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
$ sudo sh -c "echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor"
$ sudo sh -c "echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor"
$ sudo sh -c "echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor"
$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
performance
performance
performance
performance
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 
3600000
$ cpupower frequency-info
analyzing CPU 0:
  driver: intel_pstate
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 800 MHz - 3.60 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 800 MHz and 3.60 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 3.36 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
```

### GPU

```sh
$ sudo nvidia-settings
```

`X-Server Display Configuration` > `Advanced` > Enable `Force Full Composition Pipeline`



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

## Printing

If `cups` is not running (which has happened in the past numerous times) run the following commands:

```sh
sudo systemctl enable cups.service
sudo systemctl start cups.service
```
