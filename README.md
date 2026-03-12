<div style="text-align: center">
  <h1>Rachit's NixOS System Configuration</h1>

<p>
    <a href="https://nixos.org">
      <img src="./.github/images/nixos.svg" width="95" alt="NixOS Logo">
    </a>
    <a href="https://neovim.io/">
      <img
        src="./.github/images/nvim.png"
        width="90"
        alt="Neovim Logo"
      >
    </a>
  </p>

<p>
    <a href="https://nixos.org">
      <img
        src="https://img.shields.io/static/v1?style=for-the-badge&label=NixOS&message=unstable&colorA=1e1e2e&colorB=89b4fa&logo=NixOS&logoColor=f9e2af"
        alt="NixOS Unstable Badge"
      >
    </a>
    <a href="https://github.com/rachitvrma/nixdots/blob/master/LICENSE">
      <img
        src="https://img.shields.io/static/v1?style=for-the-badge&label=License&message=GPL&colorA=1e1e2e&colorB=f38ba8&logo=gnu&logoColor=f9e2af"
        alt="GPL License Badge"
      >
    </a>
  </p>

<p><i>Declarative. Reproducible. Minimal.</i></p>
</div>

# 📔 Instructions for installation

I am presuming that a bootable USB is already prepared. Boot into the
computer.

## 🧪Enable Experimental Features

Experimental features are not enabled in NixOS by default. It can be
enabled by exporting the `NIX_CONFIG` variable. It can also be enabled
by passing the `--extra-experimental-features` flag to `nix` command
utility in NixOS.

First enter into a root shell.

```bash
$ sudo -i
```

Run this to enable flakes and the nix-command utility.

```bash
$ export NIX_CONFIG="experimental-features = nix-command flakes"
```

## ↙️ Clone this Repo

Clone it into `/tmp`.

```bash
$ mkdir -p /tmp
$ cd /tmp
$ git clone --depth=1 https://github.com/rachitvrma/nixdots.git
```

## 💾 Run Disko to Prepare Disks

Disko is available in the [nixpkgs](https://github.com/NixOS/nixpkgs)
repository. But it is advisable to run the latest commit from the
[nix-community](https://github.com/nix-community/disko) github repo.
This repository has the ability to support multiple users and hosts.
Make sure that the `disko-config.nix` belongs to the correct host. By
default, it's for
[nixpavilion](./modules/nixosModules/hosts/nixpavilion/), the default host
machine that I use. Every host has a `disko-config.nix` file, which is a
hard-coded disk layout configuration for each host. There may be a
future configuration where I might enable multiple disk layouts. But
it's not a very common thing that users choose different disk layouts
for the same host every time they re-install for the same host.

```bash
$ cd /tmp/nixdots/modules/nixosModules/hosts/nixpavilion
```

For now, use the [disko-config for nixpavilion](./modules/nixosModules/hosts/nixpavilion/disko-config.nix)
for installation.

```bash
$ nix run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko-config.nix
```

This will prompt for a password for the disk encryption set in the
`disko-config.nix`.

## 🐧 OS Installation

Copy the cloned repo into `/mnt/etc/nixos`.

```bash
$ mkdir -p /mnt/etc
$ cp -r /tmp/nixdots /mnt/etc/nixos
```

Run the `nixos-install` command. It can be run with many flags. See
`nixos-install --help` for useful flags. It is advisable to enable the
`--no-root-passwd` in `nixos-install` if
`users.users.<username>.initialPassword` option is set in
`configuration.nix`.

```bash
$ nixos-install --no-root-passwd --root /mnt --cores 8 --max-jobs 1 --flake /mnt/etc/nixos#nixpavilion
```

It will not prompt for the password. Reboot after unmounting.

```bash
$ umount -R /mnt
$ reboot
```

You will land on the greeter. Follow the instructions further down.

## 💻 Post-OS-Installation

### 🔒 Change user password

Remember that the password is global and hasn't changed. There's no root
user yet. Change the current user password

```bash
$ passwd $USER
```

It will prompt for the current user password and for the new ones.

### 🏠 Bring `/etc/nixos` to `$HOME/nixdots`

```bash
$ cp -r /etc/nixos $HOME/nixdots
$ sudo rm -rf /etc/nixos
$ sudo ln -sf /home/$USER/nixdots /etc/nixos
```

### 🚶‍♂️ Further Steps.

1. Git actions

   Change the link from <https://github.com/rachitvrma/nixdots.git> to
   git@github.com:rachitvrma/nixdots.

2. Firefox

   Some Firefox extensions need to enabled manually. Some features are
   still not implemented by me. For example the Nord Extension has to
   be enabled manually.

# Common issues

- On changing git repo, it may just stop working. Don't worry, remove
  all backup files and just rebuild.
- My NixOS bootloader malfunctioned once. I put up a query on [NixOS discourse](https://discourse.nixos.org/). Here's [the solution](https://discourse.nixos.org/t/nixos-could-not-sync-boot-after-rebuild/74333/2?u=woodenallen).

# 🚧 Work In Progress

- [ ] Manage themes from one place. \[DEPRECATE not using stylix anymore\]
  - [ ] Place conditionals:
  - [ ] Wallpaper
  - [ ] Icon Theme
  - [ ] Cursor Theme
- [ ] NEXT: Write systemd user services
  - [ ] noctalia shell
  - [ ] poweralertd
- [ ] Move to using wrappers.
  - [ ] [taskwarrior](https://taskwarrior.org/)
    - [ ] Also integrate taskwarrior with neovim
  - [ ] Set up [xplr](https://github.com/sayanarijit/xplr)
    - [ ] Key for bookmarks
    - [ ] For visiting history
  - [ ] Set preferences options to make font, icon and theme name globally available
  - [x] aria2
  - [x] yt-dlp
  - [x] btop
  - [ ] [bottom](https://github.com/ClementTsang/bottom)
  - [x] cava
  - [x] firefox
  - [ ] Wezterm
    - [ ] Configure plugins
    - [ ] [bar.wezterm](https://github.com/adriankarlen/bar.wezterm)
    - [ ] [Tab Bar plugins for aesthetics](https://github.com/michaelbrusegard/awesome-wezterm?tab=readme-ov-file#tab-bar)
    - [ ] When using neovim: [smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim) and [wezterm-config.nvim](https://github.com/mrjones2014/smart-splits.nvim)
  - [x] niri
  - [ ] Swayidle
    - [ ] wrap the config around the binary
    - [ ] create a systemd service to run the binary
  - [x] mpv
  - [x] Zathura pdf reader
  - [x] noctalia \[PARTIAL\]
    - [ ] Use Stylix's base16 modules to integrate with own theme set
  - [ ] shell tools
    - [ ] nh wrapper
    - [ ] fish
      - [ ] Set up useful fish plugins
      - [ ] Set up useful fish functions
    - [ ] Zoxide
    - [ ] Fzf
    - [x] Git
      - [x] Global Ignore file
      - [x] Global Config
      - [ ] gitui
      - [ ] gh
        - [ ] gh-dash
    - [ ] Ripgrep
    - [ ] bat
    - [ ] rmpc music player
    - [ ] [kew music player](https://codeberg.org/ravachol/kew)
    - [ ] [iamb](https://github.com/ulyssa/iamb)
    - [ ] [feedo](https://github.com/ricardodantas/feedo)
    - [ ] [discordo](https://github.com/ayn2op/discordo) and [endcord](https://github.com/sparklost/endcord)
  - [x] Set GTK Theme using NixOS configuration module
  - [x] Set Fonts using NixOS module
    - [x] Remove Home-Manager stylix font modules
- [x] Use import-tree and flake-parts to manage config as flake modules.

## Todo

- [ ] Move all shell tools into a package called in environment (like in [Vimjoyer's Configuration](https://github.com/goxore/nixconf)). And use it in `users.users.krish.shell`
- [ ] Learn [jj](https://github.com/jj-vcs/jj) and move to [jjui](https://github.com/idursun/jjui)

# 📚 Resources

- [Wallpapers Repo by krishna4a6av](https://github.com/krishna4a6av/Wallpapers)
- [Wrapper Configurations](https://tangled.org/ladas552.me/Flake-ocean/blob/master/modules/wrappers/fish/flake-outputs.nix)
- [List of TUIs for the terminally addicted](https://github.com/rothgar/awesome-tuis)

# 📃 License

This project is licensed under the GNU General Public License v3.0. See
the [LICENSE](./LICENSE) file for details
