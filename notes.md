# Convert JSON files to Nix files

We can [nix-converter](https://github.com/theobori/nix-converter), but
recently it's been writing double quotes around nix keys. So we can use
native nix tooling as well.

```shell
$nix-instantiate --eval --expr "builtins.fromJSON (builtins.readFile ./file.json)"
```

Just place the name of the json file in place of `file.json`.

Better still use the new `nix eval` commands.

```bash
$nix eval --impure --expr "builtins.fromJSON (builtins.readFile ./file.json)"
```

# Foot Wrapper

(yeah I get the name) The systemd services and sockets have to be
enabled.

## Post-Config Changes

The already running server needs to be disabled and then re-enabled

```bash
$systemctl --user disable --now foot-server
$systemctl --user enable --now foot-server
```

# Dprint Plugins (Formattet plugins)

To get the newest version of plugins or the plugin link, just run this:

```bash
$dprint config add <plugin author>/<plugin name> --config <path to new dprint.json that's not in nix store>
```

It will get the plugin's link. Now simply put that link in [dprint.nix](./modules/wrappedPackages/dprint.nix)

# Eyes on These

## Cavasik

[Cavasik](https://github.com/TheWisker/Cavasik) is a great replacement
for cava.
