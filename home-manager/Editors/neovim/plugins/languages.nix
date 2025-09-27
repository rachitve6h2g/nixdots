{ pkgs, lib, ... }:
{
  vim = {
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableDAP = true;
      nix = {
        enable = true;
        format = {
          enable = true;
          package = pkgs.nixfmt;
          type = "nixfmt";
        };
        lsp = {
          enable = true;
          package = pkgs.nixd;
          server = "nixd";
        };
        treesitter.enable = true;
      };

      bash = {
        enable = true;
        format = {
          enable = true;
          type = "shfmt";
        };

        lsp = {
          enable = true;
          package = [
            (lib.getExe pkgs.bash-language-server)
            "start"
          ];
          server = "bash-ls";
        };

        treesitter.enable = true;
      };

      clang = {
        enable = true;
        cHeader = true;
        dap.enable = true;
        lsp.enable = true;
        treesitter = {
          enable = true;
        };
      };
    };
  };
}
