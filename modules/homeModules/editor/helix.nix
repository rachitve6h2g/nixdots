{
  flake.homeModules.helix =
    { pkgs, lib, ... }:
    {
      programs = {
        bash.bashrcExtra = "set -o vi";
        helix = {
          enable = true;
          defaultEditor = true;

          extraPackages = with pkgs; [
            # For bash
            bash-language-server
            shfmt
            shellcheck

            # For markdown
            ltex-ls-plus
            marksman
            mpls

            # For nix files
            nixd
            nixfmt
          ];

          settings = {
            editor = {
              line-number = "relative";
              mouse = false;
              cursor-shape = {
                normal = "block";
                insert = "bar";
                select = "underline";
              };
            };
          };

          languages = {
            language = [
              # For nix
              {
                name = "nix";
                auto-format = true;
                formatter.command = lib.getExe pkgs.nixfmt;
              }

              # For markdown
              {
                name = "markdown";
                formatter = {
                  command = lib.getExe pkgs.prettier;
                  args = [
                    "--parser"
                    "markdown"
                    "--prose-wrap"
                    "never"
                  ];
                  auto-format = true;
                };
                language-servers = [
                  "marksman"
                  "mpls"
                  "ltex-ls-plus"
                ];
                soft-wrap = {
                  enable = true;
                  wrap-at-text-width = true;
                };
              }

              # For Bash
              {
                name = "bash";
                auto-format = true;
              }
            ];

            language-server = {
              mpls = {
                command = lib.getExe pkgs.mpls;
                args = [
                  "--theme"
                  "tokyonight"
                  "--enable-emoji"
                ];
              };
              ltex-ls-plus = {
                config = {
                  ltex = {
                    diagnosticSeverity = "warning";
                    ltex-ls.logLevel = "warning";
                    disabledRules = {
                      "en-US" = [ "PROFANITY" ];
                    };
                    dictionary = {
                      "en-US" = [ "builtin" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
}
