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
            ltex-ls-plus
            marksman
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
              {
                name = "nix";
                auto-format = true;
                formatter.command = lib.getExe pkgs.nixfmt;
              }

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
                  "ltex-ls-plus"
                ];
                soft-wrap = {
                  enable = true;
                  wrap-at-text-width = true;
                };
              }
            ];

            language-server = {
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
