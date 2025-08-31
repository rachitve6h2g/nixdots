<p align="center">
    <img src="./.codeberg/assets/nixos-logo.png" width="150px"/>
    <h2 align="center"><br>Chris's flake for NixOS<br></h2>
</p>

>[!NOTE]
>I'll move to sway after my exam (most probably 2 weeks after 10/09/2025).


# Installation Notes:

- For disk partioning (using [disko](https://github.com/nix-community/disko))
- Post installation run:
    ```bash
    $nix-index
    ```
    to create a database of all packages.

# Notes:

- Use this to download the dots with the wallpapers.
    ```bash
    $git --recurse-submodules https://codeberg.org/rachitve6h2g/dotfiles.git
    ```

    If it's necessary to download the git repo fast (coz it takes too much time to download)
    ```bash
    $git submodule init
    $git submodule update
    ```


# TODO:
- [ ] Have one directory for lock icons, wallpapers, etc.
- [ ] Write an event for pausing song/video on earphone unplug, resume on plug-in
- [ ] Move to treefmt-nix from nixfmt
- [ ] Move to xdg-desktop-portal-termfilechooser
- [ ] Learn difference between focus-ring and border (read the wiki properly)
- [ ] Move to SwayWM

# License

This project is licensed under the GNU General Public License v3.0.
See the [LICENSE](./LICENSE) file for details.
