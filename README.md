<h1 align="center">
<div align="center">
<img src="./.github/images/nixos.svg" width="100px" />
<img src="./.github/images/emacs.svg" width="100px" />
</div>
<br>
<p>Rachit's NixOS System Configuration</p>
<div align="center">
<p></p>
<div align="center">
<a href="https://orgmode.org/index.html">
<img src="https://img.shields.io/badge/org_mode-9.7-blue.svg?style=for-the-badge&labelColor=1e1e2e&logo=org&logoColor=a6e3a1&color=1e1e2e">
</a>
<a = href="https://nixos.org">
<img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=1e1e2e&logo=NixOS&logoColor=89b4fa&color=1e1e2e">
</a>
<a = href="https://www.gnu.org/software/emacs/">
<img src="https://img.shields.io/badge/emacs-30-blue.svg?style=for-the-badge&labelColor=1e1e2e&logo=gnuemacs&logoColor=cba6f7&color=1e1e2e">
</a>
<a href="https://github.com/rachitve6h2g/nixos-config/blob/master/LICENSE">
<img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=GPL&colorA=1e1e2e&colorB=f38ba8&logo=unlicense&logoColor=f9e2af&%22"/>
</a>
</div>
<br>
</div>
</h1>

# ⚠️ Important Notes:

## Changing the host or the user

The host, user and theme can be configured using the
[globals.nix](globals.nix) file. As of now, there\'s only
`krish` user, `nixpavilion` host, and
`nord` colorscheme configuration.

## When installing Niri as your WM.

See the [steps to install niri using binary
cache.](#when-using-the-niri-wm) This repo uses niri from the
[nixpkgs](https://github.com/NixOS/nixpkgs) repository.

## To set up emacs, use GNU stow for the [emacs](emacs/) directory in this repo

The initial idea was to use home-manager for complete configuration. I
found [twixt.nix](https://github.com/emacs-twist/twist.nix) for bundling
emacs. (See [WIP Section](#-work-in-progress) for progress.

``` bash
$nix run nixpkgs#stow -- --dotfiles emacs
```

## Using wrappers.

I find wrappers way better and simple than home-manager. My aim is to
move to using wrappers while using the NixOS modules system. For that I
will be using the
[Lassalus/wrappers](https://github.com/Lassulus/wrappers) and
[vimjoyer\'s nixconf](https://github.com/vimjoyer/nixconf) as a
reference. I have created a very simple wrapper for
[btop](users/krish/Programs/btop.nix).

## Using FlakeModules and import-tree

I want to move my config from the default thing that it is to using
[flake-parts](https://github.com/hercules-ci/flake-parts) modules and
using [import-tree](https://github.com/vic/import-tree).

# 📔 Instructions for installation

I am presuming that a bootable USB is already prepared. Boot into the
computer.

## 🧪Enable Experimental Features

Experimental features are not enabled in NixOS by default. It can be
enabled by exporting the `NIX_CONFIG`{.verbatim} variable. It can also
be enabled by passing the `--extra-experimental-features`{.verbatim}
flag to `nix`{.verbatim} command utility in NixOS.

First enter into a root shell.

``` bash
sudo -i
```

Run this to enable flakes and the nix-command utitlity.

``` shell
export NIX_CONFIG="experimental-features = nix-command flakes"
```

## ↙️ Clone this Repo

Clone it into `/tmp`{.verbatim} .

``` bash
mkdir -p /tmp
cd /tmp
git clone --depth=1 https://github.com/rachitve6h2g/nixos-config.git
```

## 🖥️ Changing User and Host (and possibly theme)

The host and the user configs can be changed using the
[globals.nix](globals.nix) file. The default user is `krish`{.verbatim},
the default hostname is `nixpavilion`{.verbatim} and the default theme
is `nord`{.verbatim}. **NOTE**: A WindowManager/DesktopEnvironment
module is on it\'s way.

## 💾 Run Disko to Prepare Disks

Disko is available in the [nixpkgs](https://github.com/NixOS/nixpkgs)
repository. But it is advisable to run the latest commit from the
[nix-community](https://github.com/nix-community/disko) github repo.
This repository has the ability to support multiple users and hosts.
Make sure that the `disko-config.nix`{.verbatim} belongs to the correct
host. By default it\'s for [nixpavilion](hosts/nixpavilion/), the
default host machine that I use. Every host has a
`disko-config.nix`{.verbatim} file, which is a hard-coded disk layout
configuration for each host. There may be a future configuration where I
might enable multiple disk layouts. But it\'s not a very common thing
that users choose different disk layouts for the same host every time
they re-install for the same host.

``` bash
cd /tmp/nixos-config/hosts/nixpavilion
```

For now, use the [disko-config for
nixpavilion](hosts/nixpavilion/disko-config.nix) for installation.

``` bash
nix run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko-config.nix
```

This will prompt for a password for the disk encryption set in the
`disko-config.nix`{.verbatim}.

## 🐧 OS Installation

Copy the cloned repo into `/mnt/etc/nixos`{.verbatim}.

``` bash
mkdir -p /mnt/etc
cp -r /tmp/nixos-config /mnt/etc/nixos
```

Run the `nixos-install`{.verbatim} command. It can be run with many
flags. See `nixos-install --help`{.verbatim} for useful flags. It is
advisable to enable the `--no-root-passwd`{.verbatim} in nixos-install
if `users.users.<username>.initialPassword`{.verbatim} option is set in
`configuration.nix`{.verbatim}.

``` bash
nixos-install --no-root-passwd --root /mnt --cores 8 --max-jobs 1 --flake /mnt/etc/nixos#nixpavilion
```

It will not prompt for the password. Reboot after unmounting.

``` bash
umount -R /mnt
reboot
```

You will land on the greeter. Follow the instructions further down.

## 💻 Post-OS-Installation

Home-Manager needs to be run first. Use `nh home switch`{.verbatim} for
installing our `user`{.verbatim} level packages and dotfiles. In my
personal experience, starting a desktop environment or a window manager
(Hyprland in my default case) creates files that conflict with
home-manager\'s generated files later on. It can be fixed instantly,
either by running `nh home switch -- -b backup`{.verbatim} or by
manually deleting the conflicting files. I like to just jump to another
tty, login and run `nh home switch`{.verbatim} from there. However,
follow these instructions in sequence.

### 🔒 Change user password

Remember that the password is global and hasn\'t changed. There\'s no
root user yet. Change the current user password

``` bash
passwd $USER
```

It will prompt for the current user password and for the new ones.

### 🏠 Bring `/etc/nixos`{.verbatim} to `$HOME/.nixos-config`{.verbatim}

`nh home switch`{.verbatim} or `home-manager switch`{.verbatim} will not
run if the flake directory does not have user permission. By default
it\'s `root:root`{.verbatim}. Link `$HOME/.nixos-config`{.verbatim} to
`/etc/nixos`{.verbatim} so that the canonical structure is followed
without being a hindrance.

``` bash
cp -r /etc/nixos $HOME/.nixos-config
sudo rm -rf /etc/nixos
sudo ln -sf /home/$USER/.nixos-config /etc/nixos
```

Link `$HOME/.nixos-config`{.verbatim} to
`$HOME/.config/home-manager`{.verbatim} so that it follows the canonical
structure for `home-manager`{.verbatim} commands like
`home-manager news`{.verbatim}, which is very handy for seeing new
modules and options and stuff.

``` bash
ln -sf $HOME/.nixos-config $HOME/.config/home-manager
```

Make sure that the home-manager option for `nh`{.verbatim} i.e.
`programs.nh.homeFlake`{.verbatim} is still `/etc/nixos`{.verbatim}.

### Run the `nh home switch`{.verbatim} command

Now that it is set up, run the `nh home switch`{.verbatim} command to
set up our `$HOME`{.verbatim}.

``` bash
nh home switch
```

Reboot for the environment variables to set. (In my experience,
environment variables were never sourced when I logged out and just
logged in).

### 🚶‍♂️ Further Steps.

1.  Emacs Config

    Use emacs by using GNU Stow. Emacs config is now in this repo. Is
    not fully reproducible (see [WIP Section](#-work-in-progress)). Just
    stow the [emacs](emacs/) directory, and it\'s done

    ``` bash
    nix run nixpkgs#stow -- --dotfiles emacs
    ```

    Restart emacs, and you\'re set.

2.  Git actions.

    This is a personal note to me, the author of the repo. Please change
    the git remote of the important repos namely
    `$HOME/.nixos-config`{.verbatim} and `$HOME/.emacs.d`{.verbatim} to
    my ssh. Use `magit-status`{.verbatim} and
    `magit-remote-configure`{.verbatim} to do so, after creating the ssh
    keys.

3.  Firefox

    Some firefox extensions need to enabled manually. Some features are
    still not implemented by me. For example the Nord Extension has to
    be enabled manually.

## When Using the Niri WM {#niri-flake-installation-steps}

For niri I use [niri-flake](https://github.com/sodiboo/niri-flake) by
[sodiboo](https://github.com/sodiboo). It\'s popular and works well. To
use niri-stable package from the binary cache of the author [these
instructions](https://github.com/sodiboo/niri-flake#binary-cache) must
be followed.

# ◽ Common issues

- On changing git repo, it may just stop working. Don\'t worry, remove
  all backup files and just rebuild.
- My NixOS bootloader borked once. I put up a query on [NixOS
  discourse](https://discourse.nixos.org/). Here\'s [the
  solution](https://discourse.nixos.org/t/nixos-could-not-sync-boot-after-rebuild/74333/2?u=woodenallen).
- [ ] Ashell is not following niri\'s place-within-backdrop.

# 🚧 Work In Progress {#wip}

[TODO]{.todo .TODO} \[ \] Set up Emacs to be completely reproducible
using the [twist.nix](https://github.com/emacs-twist/twist.nix).

- [X] Bring emacs configuration under same repo.

[TODO]{.todo .TODO} \[X\] Manage stylix themes from one place. Only
things that need to be centralized is `stylix.base16Scheme`{.verbatim},
so that it\'s not written. \[The way it\'s done is weird, but it\'s
done. See [instructions](#-changing-user-and-host-(and-possibly-theme))
in installation section\].

1.  [TODO]{.todo .TODO} Create modules for base16Scheme and img for
    nord, gruvbox, catppuccin and tokyo-night.

[TODO]{.todo .TODO} Manage DE/WM

Managing desktop environment and window manager from one place.

Move to using wrappers.

Use import-tree and flake-parts to manage config as flake modules.

# 👀 Eyes on These

- [Hyprlauncher](https://github.com/hyprwm/hyprlauncher): App launcher
  for hyprland.

# 📃 License

This project is licensed under the GNU General Public License v3.0. See
the [LICENSE](LICENSE) file for details
