{ inputs, self, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];
  perSystem =
    { pkgs, ... }:
    let
      sources = pkgs.callPackage ./_sources/generated.nix { };
      mkPlugin =
        name: source:
        pkgs.stdenv.mkDerivation {
          pname = name;
          version = source.version or "dev";
          src = source.src;
          installPhase = ''
            mkdir -p $out
            cp -r * $out
          '';
        };
      plugins = pkgs.lib.filterAttrs (n: v: pkgs.lib.isDerivation v) (pkgs.lib.mapAttrs mkPlugin sources);
    in
    {
      packages = plugins;
      overlayAttrs = {
        xplrPlugins = plugins;
      };
    };
  flake.wrappers.xplr =
    {
      wlib,
      config,
      pkgs,
      lib,
      ...
    }:
    let
      xplrPlugins = self.packages.${pkgs.stdenv.hostPlatform.system};
      mkPluginCfg =
        cfg:
        cfg
        // {
          after = [ "MAIN_INIT" ] ++ cfg.after or [ ];
          data =
            (
              if cfg.type or config.defaultConfigLang == "fnl" then
                "(local (opts name) ...)\n"
              else
                "local opts, name = ...\n"
            )
            + cfg.data or "";
          before = [ "AFTER_PLUGINS" ] ++ cfg.before or [ ];
        };
    in
    {
      imports = [ wlib.wrapperModules.xplr ];
      defaultConfigLang = "fnl";
      luaEnv =
        lp: with lp; [
          inspect
        ];

      luaInit = {
        helpers = {
          before = [ "MAIN_INIT" ];
          data = /* fennel */ ''
            (set _G.nix-info (require :nix-info))
            (set _G.nix-info.debug-print
                 (fn [...]
                   (let [args [...]]
                     (for [i 1 (select "#" ...)]
                       (print (.. i ":\n" ((require :inspect) (. args i))))))))

            (set _G.nix-info.call-setup
                 (λ [mod opts]
                   ((. (require mod) :setup) opts)))
          '';
        };
        general = {
          opts = { };
          data = /* fennel */ "";
        };
        MAIN_INIT = {
          opts = { };
          data = /* fennel */ ''
            (local xplr _G.xplr)
            (set xplr.config.modes.builtin.go_to
                 {:name "go to"
                  :layout :HelpMenu
                  :key_bindings {:on_key {:f {:help "follow symlink"
                                              :messages [:FollowSymlink :PopMode]}
                                          :g {:help :top :messages [:FocusFirst :PopMode]}
                                          :p {:help :path
                                              :messages [:PopMode
                                                         {:SwitchModeBuiltin :go_to_path}
                                                         {:SetInputBuffer ""}]}
                                          :i {:help "initial $PWD"
                                              :messages [:PopMode
                                                         {:BashExecSilently0 (.. :$XPLR
                                                                                 " -m 'ChangeDirectory: %q' \"''${XPLR_INITIAL_PWD:?}\"")}]}
                                          :x {:help "open in gui"
                                              :messages [{:BashExecSilently0 "if [ -z \"$OPENER\" ]; then
                                                      if command -v xdg-open; then
                                                        OPENER=xdg-open
                                                      elif command -v open; then
                                                        OPENER=open
                                                      else
                                                        \"$XPLR\" -m 'LogError: %q' \"$OPENER not found\"
                                                        exit 1
                                                      fi
                                                    fi
                                                    while IFS= read -r -d \'\' PTH; do
                                                      $OPENER \"''${PTH:?}\" > /dev/null 2>&1
                                                    done < \"''${XPLR_PIPE_RESULT_OUT:?}\""}
                                                         :ClearScreen
                                                         :PopMode]}}}})
          '';
        };
        zoxide = mkPluginCfg {
          plugin = xplrPlugins.zoxide;
          opts = {
            key = "Z";
            mode = "default";
            bin = lib.getExe pkgs.zoxide;
          };
          data = /* fennel */ ''
            (_G.nix-info.call-setup :zoxide opts)
            nil
          '';
        };

        # For tree view
        tree-view = {
          plugin = xplrPlugins.tree-view;
          opts = {
            mode = "switch_layout";
            key = "T";

            # If you feel slowness, you might want to toggle back to the default view
            toggle_layout_mode = "default";
            toggle_layout_key = "esc";

            close_all_and_back_mode = "default";
            close_all_and_back_key = "backspace";

            toggle_expansion_mode = "default";
            toggle_expansion_key = "o";

            toggle_expansion_all_mode = "default";
            toggle_expansion_all_key = "O";
          };
          data = ''

          '';
        };
      };
    };
}
