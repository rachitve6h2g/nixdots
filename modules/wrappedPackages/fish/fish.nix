# This wrapper is largely inspired by
# https://tangled.org/ladas552.me/Flake-ocean/blob/master/modules/wrappers/fish/flake-outputs.nix
# Except I use BirdeeHub/nix-wrapper-module to wrap fish
{ inputs, self, ... }:
{
  perSystem =
    {
      lib,
      pkgs,
      ...
    }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
      inherit (pkgs) writeTextDir;
      vendorConf = "share/fish/vendor_conf.d";

      loadPlugin = writeTextDir "${vendorConf}/load.fish" /* fish */ ''
        function load_plugin
          if test (count $argv) -lt 1
            echo Failed to load plugin, incorrect number of arguments
            return 1
          end
          set -l __plugin_dir $argv[1]/share/fish
          if test -d $__plugin_dir/vendor_functions.d
            set -p fish_function_path $__plugin_dir/vendor_functions.d
          end
          if test -d $__plugin_dir/vendor_completions.d
            set -p fish_complete_path $__plugin_dir/vendor_completions.d
          end
          if test -d $__plugin_dir/vendor_conf.d
            for f in $__plugin_dir/vendor_conf.d/*.fish
              source $f
            end
          end
        end
      '';

      config = writeTextDir "${vendorConf}/config.fish" /* fish */ ''
        set fish_greeting # Disable greeting

        # Source local configuration files from the flake's conf.d directory
        # Nix will resolve ${./conf.d} to a /nix/store path automatically.
        if test -d ${./conf.d}
          for c in ${./conf.d}/*.fish
            source $c
          end
        end

        # Enable vim keybindings
        fish_vi_key_bindings

        # Fish prompt
        # function fish_prompt
        #   string join "" -- \
        #     (set_color red) "[" \
        #     (set_color yellow) $USER \
        #     (set_color green) "@" \
        #     (set_color blue) $hostname \
        #     (set_color magenta) " " \
        #     $(prompt_pwd) (set_color red) ']' \
        #     (set_color normal) "\$ "
        # end

        # Load plugins in fish shell
        ${lib.pipe
          (with pkgs.fishPlugins; [
            pure
            autopair-fish
            fzf-fish
          ])
          [
            (map (elem: "load_plugin ${elem}"))
            (lib.concatStringsSep "\n")
          ]
        }

        # Set LS_COLORS
        set -gx LS_COLORS (vivid generate gruvbox-dark-hard)

        # fenv source /etc/profile

        # Nix direnv integration
        set -gx direnv_config_dir ${pkgs.nix-direnv}/share/nix-direnv/direnvrc
        ${lib.getExe pkgs.direnv} hook fish | source

        # Zoxide integration
        ${lib.getExe pkgs.zoxide} init fish | source
      '';
    in
    {
      packages.fishWrapped = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.fish;
        extraPackages = [
          loadPlugin
          config
        ]
        ++ (with pkgs; [
          # For foreign-env (fenv) command
          fish
          # Common shell tools
          microfetch
          pandoc
          fd
          ripgrep
          ripgrep-all
          vivid
          eza
          fzf

          gophertube # Watch youtube in terminal

          # Github-cli
          gh
          gh-dash

          # Music player
          moc

          # Fetch sources for nix
          nvfetcher

          # Nix prefetchers
          nix-prefetch
          nix-prefetch-github

          # Zoxide of course
          zoxide
        ])
        ++ (with selfpkgs; [
          aria2 # A better terminal downloader
          btop # Python based system monitor
          bottom # Rust based system monitor
          kew # Music player (for trial)
          taskwarrior # Terminal to-do list manager

          # Git tools
          git
          gitui

          helix # TODO: move to neovim

          yt-dlp # youtube downloader
          xplr # terminal filemanager
        ]);
        prefixVar = [
          [
            "XDG_DATA_DIRS"
            ":"
            "${lib.makeSearchPathOutput "out" "share" [
              loadPlugin
              config
            ]}"
          ]
        ];
        wrapperImplementation = "binary";
        passthru.shellPath = "/bin/fish";
      };
    };
}
