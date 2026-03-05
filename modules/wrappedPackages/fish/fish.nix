{
  flake.wrappers.fish =
    {
      wlib,
      pkgs,
      config,
      lib,
      ...
    }:
    {
      imports = [ wlib.modules.default ];
      options = {
        "config.fish" = lib.mkOption {
          default.content = /* fish */ ''
            fish_vi_key_bindings

            set fish_greeting

            function fish_prompt
                string join "" -- (set_color red) "[" (set_color yellow) $USER (set_color green) "@" (set_color blue) $hostname (set_color magenta) " " $(prompt_pwd) (set_color red) ']' (set_color normal) "\$ "
            end

            ${lib.getExe pkgs.zoxide} init fish | source
          '';
          type = wlib.types.file pkgs;
        };
      };
      config = {
        outputs = [
          "out"
          "doc"
        ];
        package = pkgs.fish;
        wrapperImplementation = "binary";
        passthru.shellPath = "/bin/fish";
        extraPackages = with pkgs; [
          microfetch
          pandoc
          fd
          ripgrep
          ripgrep-all
          eza
          fzf
          vivid
        ];
        flags = {
          "-C" =
            /* fish */ "
            source ${config."config.fish".path}
            set --local fish_conf_source_path ${./conf.d}
            for c in \$fish_conf_source_path/*; source \$c; end
            ";
        };

        # drv = {
        #   fishConfig = builtins.readFile config."config.fish".path;
        #   passAsFile = [ "fishConfig" ];
        #   buildPhase = ''
        #     runHook preBuild
        #     cp $fishConfigPath "$out/etc/fish/conf.d/fishy-fish.fish"
        #     runHook postBuild
        #   '';
        # };
      };
    };
}
