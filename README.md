<h1 align="center">
<div align="center">
<img src="./.github/images/nixos.svg" width="100px" />
<a href="https://www.gnu.org/software/emacs/">
<img src="./.github/images/emacs.svg" width="100px" />
</a>
</div>
<br>
<p>Rachit's NixOS System Configuration</p>
<div align="center">
<p></p>
<div align="center">
<a href="https://orgmode.org/">
<img src="https://img.shields.io/badge/org_mode-9.7-blue.svg?style=for-the-badge&labelColor=1e1e2e&logo=org&logoColor=a6e3a1&color=1e1e2e">
</a>
<a href="https://nixos.org">
<img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=1e1e2e&logo=NixOS&logoColor=89b4fa&color=1e1e2e">
</a>
<a href="https://github.com/rachitve6h2g/nixdots/blob/master/LICENSE">
<img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=GPL&colorA=1e1e2e&colorB=f38ba8&logo=unlicense&logoColor=f9e2af&%22"/>
</a>
</div>
<br>
</div>
</h1>

>[!note]
>See the [steps to install niri using binary
cache.](#when-using-the-niri-wm) This repo uses niri from the
[nixpkgs](https://github.com/NixOS/nixpkgs) repository.

# 📔 Instructions for installation

I am presuming that a bootable USB is already prepared. Boot into the
computer.

## 🧪Enable Experimental Features

Experimental features are not enabled in NixOS by default. It can be
enabled by exporting the `NIX_CONFIG` variable. It can also
be enabled by passing the `--extra-experimental-features`
flag to `nix` command utility in NixOS.

First enter into a root shell.

``` bash
$ sudo -i
```

Run this to enable flakes and the nix-command utitlity.

``` bash
$ export NIX_CONFIG="experimental-features = nix-command flakes"
```

## ↙️ Clone this Repo

Clone it into `/tmp`.

``` bash
$ mkdir -p /tmp
$ cd /tmp
$ git clone --depth=1 https://github.com/rachitve6h2g/nixdots.git
```

## 💾 Run Disko to Prepare Disks

Disko is available in the [nixpkgs](https://github.com/NixOS/nixpkgs)
repository. But it is advisable to run the latest commit from the
[nix-community](https://github.com/nix-community/disko) github repo.
This repository has the ability to support multiple users and hosts.
Make sure that the `disko-config.nix` belongs to the correct
host. By default it\'s for [nixpavilion](modules/nixosModules/hosts/nixpavilion/), the
default host machine that I use. Every host has a
`disko-config.nix` file, which is a hard-coded disk layout
configuration for each host. There may be a future configuration where I
might enable multiple disk layouts. But it\'s not a very common thing
that users choose different disk layouts for the same host every time
they re-install for the same host.

``` bash
$ cd /tmp/nixdots/modules/nixosModules/hosts/nixpavilion
```

For now, use the [disko-config for
nixpavilion](modules/nixosModules/hosts/nixpavilion/disko-config.nix) for installation.

``` bash
$ nix run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko-config.nix
```

This will prompt for a password for the disk encryption set in the
`disko-config.nix`.

## 🐧 OS Installation

Copy the cloned repo into `/mnt/etc/nixos`.

``` bash
$ mkdir -p /mnt/etc
$ cp -r /tmp/nixdots /mnt/etc/nixos
```

Run the `nixos-install` command. It can be run with many
flags. See `nixos-install --help` for useful flags. It is
advisable to enable the `--no-root-passwd` in nixos-install
if `users.users.<username>.initialPassword` option is set in
`configuration.nix`.

``` bash
$ nixos-install --no-root-passwd --root /mnt --cores 8 --max-jobs 1 --flake /mnt/etc/nixos#nixpavilion
```

It will not prompt for the password. Reboot after unmounting.

``` bash
$ umount -R /mnt
$ reboot
```

You will land on the greeter. Follow the instructions further down.

## 💻 Post-OS-Installation

Home-Manager needs to be run first. Use `nh home switch` for
installing our `user` level packages and dotfiles. In my
personal experience, starting a desktop environment or a window manager
(Hyprland in my default case) creates files that conflict with
home-manager\'s generated files later on. It can be fixed instantly,
either by running `nh home switch -- -b backup` or by
manually deleting the conflicting files. I like to just jump to another
tty, login and run `nh home switch` from there. However,
follow these instructions in sequence.

### 🔒 Change user password

Remember that the password is global and hasn\'t changed. There\'s no
root user yet. Change the current user password

``` bash
$ passwd $USER
```

It will prompt for the current user password and for the new ones.

### 🏠 Bring `/etc/nixos` to `$HOME/nixdots`

`nh home switch` or `home-manager switch` will not
run if the flake directory does not have user permission. By default
it\'s `root:root`. Link `$HOME/nixdots` to
`/etc/nixos` so that the canonical structure is followed
without being a hindrance.

``` bash
$ cp -r /etc/nixos $HOME/nixdots
$ sudo rm -rf /etc/nixos
$ sudo ln -sf /home/$USER/nixdots /etc/nixos
```

Link `$HOME/nixdots` to
`$HOME/.config/home-manager` so that it follows the canonical
structure for `home-manager` commands like
`home-manager news`, which is very handy for seeing new
modules and options and stuff.

``` bash
$ ln -sf $HOME/nixdots $HOME/.config/home-manager
```

Make sure that the home-manager option for `nh` i.e.
`programs.nh.homeFlake` is still `/home/krish/nixdots`.

### Run the `nh home switch` command

Now that it is set up, run the `nh home switch` command to
set up our `$HOME`.

``` bash
$ nh home switch
```

Reboot for the environment variables to set. (In my experience,
environment variables were never sourced when I logged out and just
logged in).

### 🚶‍♂️ Further Steps.

1. Git actions

    Change the link from https://github.com/rachitve6h2g/nixdots.git to
    git@github.com:rachitve6h2g/nixdots.

2.  Firefox

    Some firefox extensions need to enabled manually. Some features are
    still not implemented by me. For example the Nord Extension has to
    be enabled manually.

## When Using the Niri WM

For niri I use [niri-flake](https://github.com/sodiboo/niri-flake) by
[sodiboo](https://github.com/sodiboo). It\'s popular and works well. To
use niri-stable package from the binary cache of the author [these
instructions](https://github.com/sodiboo/niri-flake#binary-cache) must
be followed.

# Common issues

- On changing git repo, it may just stop working. Don\'t worry, remove
  all backup files and just rebuild.
- My NixOS bootloader borked once. I put up a query on [NixOS
  discourse](https://discourse.nixos.org/). Here\'s [the
  solution](https://discourse.nixos.org/t/nixos-could-not-sync-boot-after-rebuild/74333/2?u=woodenallen).

# 🚧 Work In Progress

- [X] Manage stylix themes from one place. Only
things that need to be centralized is `stylix.base16Scheme`,
so that it\'s not written. \[The way it\'s done is weird, but it\'s
done. See [instructions](#-changing-user-and-host-(and-possibly-theme))
in installation section\].

- [ ] Manage DE/WM

- [ ] Managing desktop environment and window manager from one place.

- [ ] Move to using wrappers.

- [ ] Use import-tree and flake-parts to manage config as flake modules.

- [ ] Create fzf scripts for powermenu, emoji selector, and launcher.

- [ ] Move to dired once setup and remove yazi

# 👀 Eyes on These

- [Hyprlauncher](https://github.com/hyprwm/hyprlauncher): App launcher
  for hyprland.

# 📃 License

This project is licensed under the GNU General Public License v3.0. See
the [LICENSE](LICENSE) file for details
