<div align="center">
<p>
<a href="https://nixos.org">
<img src="./.github/images/nixos.svg" width="95" alt="NixOS Logo">
</a>
<a href="https://www.gnu.org/software/emacs/">
<img src="./.github/images/emacs.svg" width="90" alt="Emacs Logo">
</a>
</p>
&#10;<p>
<a href="https://nixos.org">
<img src="https://img.shields.io/static/v1?style=for-the-badge&label=NixOS&message=unstable&colorA=282828&colorB=a9b665&logo=NixOS&logoColor=d4be98" alt="NixOS Unstable Badge">
</a>
<a href="https://github.com/rachitvrma/nixdots/blob/master/LICENSE">
<img src="https://img.shields.io/static/v1?style=for-the-badge&label=License&message=GPLv3&colorA=282828&colorB=ea6962&logo=gnu&logoColor=d4be98" alt="GPL License Badge">
</a>
<a href="https://www.gnu.org/software/emacs/">
<img src="https://img.shields.io/static/v1?style=for-the-badge&label=Emacs&message=PGTK&colorA=282828&colorB=d3869b&logo=gnu&logoColor=d4be98" alt="Emacs PGTK Badge">
</a>
</p>
&#10;<p><i>Declarative. Reproducible. Minimal.</i></p>
&#10;<hr />
</div>

# 📔 Instructions for installation

I am presuming that a bootable USB is already prepared. Boot into the
computer.

## 🧪 Enable Experimental Features

Experimental features are not enabled in NixOS by default. They can be
enabled by exporting the `NIX_CONFIG` variable or by passing the
`--extra-experimental-features` flag to the `nix` command utility.

First, enter into a root shell:

```bash
sudo -i
```

Run this to enable flakes and the nix-command utility:

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```

## ↙️ Clone this Repo

Clone the repository into `/tmp`:

```bash
mkdir -p /tmp
cd /tmp
git clone --depth=1 https://github.com/rachitvrma/nixdots.git
```

## 💾 Run Disko to Prepare Disks

Disko is available in [nixpkgs](https://github.com/NixOS/nixpkgs), but
it is advisable to run the latest commit from the
[nix-community](https://github.com/nix-community/disko) repo. Make sure
the `disko-config.nix` belongs to the correct host. By default, it's set
for [nixpavilion](./modules/nixosModules/hosts/nixpavilion/).

```bash
cd /tmp/nixdots/modules/nixosModules/hosts/nixpavilion
nix run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko-config.nix
```

## 🐧 OS Installation

Copy the cloned repo into `/mnt/etc/nixos` and run the installation:

```bash
mkdir -p /mnt/etc
cp -r /tmp/nixdots /mnt/etc/nixos
nixos-install --no-root-passwd --root /mnt --cores 8 --max-jobs 1 --flake /mnt/etc/nixos#nixpavilion
```

Reboot after unmounting:

```bash
umount -R /mnt
reboot
```

## 💻 Post-OS-Installation

### 🔒 Change user password

```bash
passwd $USER
```

### 🏠 Bring `/etc/nixos` to `$HOME/nixdots`

```bash
cp -r /etc/nixos $HOME/nixdots
sudo rm -rf /etc/nixos
sudo ln -sf /home/$USER/nixdots /etc/nixos
```

# 🚧 Work In Progress

- [ ] **Systemd User Services**
  - [ ] noctalia shell
  - [ ] poweralertd
- [ ] **Wrappers & Tooling**
  - [x] yt-dlp, btop, cava, firefox
  - [x] niri, mpv, Zathura
  - [x] Git (Global ignore/config)

# 📚 Resources

- [Wallpapers Repo](https://github.com/krishna4a6av/Wallpapers) by
  krishna4a6av.
- [Awesome TUIs](https://github.com/rothgar/awesome-tuis) for the
  terminally addicted.

# 📃 License

This project is licensed under the GNU General Public License v3.0. See
the [LICENSE](./LICENSE) file for details.
