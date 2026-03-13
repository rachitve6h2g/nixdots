{
  flake.wrappers.gh =
    {
      wlib,
      lib,
      pkgs,
      config,
      ...
    }:
    let
      yamlFmt = pkgs.formats.yaml { };
      inherit (lib) mkOption;
    in
    {
      imports = [ wlib.modules.default ];
      options = {
        config = mkOption {
          inherit (yamlFmt) type;
          default = {
            version = 1;
            git_protocol = "ssh";
            editor = "hx";
            prompt = "enabled";
            prefer_editor_prompt = "disabled";
            aliases = {
              co = "pr checkout";
            };
            color_labels = "enabled";
            spinner = "enabled";
          };
          description = ''
            Configuration that goes to {file}`config.yml`
          '';
        };
        hosts = mkOption {
          inherit (yamlFmt) type;
          default = { };
          description = ''
            Host specific configuration that goes to {file}`hosts.yml`
          '';
        };
      };
      config = {
        package = pkgs.gh;
        extraPackages = [ pkgs.gh-dash ];
        env = {
          GH_CONFIG_DIR = "${placeholder config.outputName}/gh-config";
        };
        drv = {
          configYml = yamlFmt.generate "config.yml" config.config;
          hostsYml = yamlFmt.generate "hosts.yml" config.hosts;

          passAsFile = [
            "configYml"
            "hostsYml"
          ];

          buildPhase = ''
            runHook preBuild
            mkdir -p "${placeholder config.outputName}/gh-config"
            cp "$(cat "$configYmlPath")" "${placeholder config.outputName}/gh-config/config.yml"
            cp "$(cat "$hostsYmlPath")" "${placeholder config.outputName}/gh-config/hosts.yml"
            runHook postBuild
          '';

        };
      };
    };
}
