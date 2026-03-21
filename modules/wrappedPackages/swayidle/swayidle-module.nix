{
  flake.wrappers.swayidle-module =
    {
      wlib,
      lib,
      config,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkOption types;

      timeoutModule = {
        options = {
          timeout = mkOption {
            type = types.ints.positive;
            description = "Timeout in seconds";
          };
          command = mkOption {
            type = wlib.types.stringable;
            description = "Command to run after timeout";
          };
          resumeCommand = mkOption {
            type = types.nullOr wlib.types.stringable;
            default = null;
            description = "Command to run on activity";
          };
        };
      };
    in
    {
      imports = [ wlib.modules.default ];

      options = {
        timeouts = mkOption {
          type = types.listOf (types.submodule timeoutModule);
          default = [ ];
          description = "List of idle timeout actions";
        };

        # NOTE: Changed from attrsOf submodule to just a direct submodule
        # This allows events.lock = "..." syntax directly.
        events = mkOption {
          type = types.submodule {
            options = {
              before-sleep = mkOption {
                type = types.nullOr wlib.types.stringable;
                default = null;
              };
              after-resume = mkOption {
                type = types.nullOr wlib.types.stringable;
                default = null;
              };
              lock = mkOption {
                type = types.nullOr wlib.types.stringable;
                default = null;
              };
              unlock = mkOption {
                type = types.nullOr wlib.types.stringable;
                default = null;
              };
              idlehint = mkOption {
                type = types.nullOr types.ints.positive;
                default = null;
                apply = v: if v == null then null else toString v;
                description = ''
                  Set IdleHint to indicate an idle logind/elogind session after <timeout>
                  seconds. Adding an idlehint event will also cause swayidle to call SetIdleHint(false) when run, on
                  resume, unlock, etc.
                '';
              };
            };
          };
          default = { };
        };

        extraArgs = mkOption {
          type = types.listOf wlib.types.stringable;
          default = [ "-w" ];
        };
      };

      config = {
        package = pkgs.swayidle;

        # We transform the module options into the flat list swayidle expects
        addFlag =
          let
            mkTimeout =
              t:
              [
                "timeout"
                (toString t.timeout)
                t.command
              ]
              ++ lib.optionals (t.resumeCommand != null) [
                "resume"
                t.resumeCommand
              ];

            # Filter out null values from the events submodule
            activeEvents = lib.filterAttrs (_: v: v != null) config.events;

            # Map the set into [ "event" "command" "event" "command" ]
            eventArgs = lib.concatLists (
              lib.mapAttrsToList (name: value: [
                name
                value
              ]) activeEvents
            );
          in
          config.extraArgs ++ (lib.concatMap mkTimeout config.timeouts) ++ eventArgs;
      };
    };
}
