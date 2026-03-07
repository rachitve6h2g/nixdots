{
  flake.wrappers.xplr =
    { wlib, config, ... }:
    let
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
      luaEnv = lp: with lp; [ inspect ];

      luaInit.helpers = {
        before = [ "MAIN_INIT" ];
        data = /* fennel */ ''
          (set _G.nix-info (require "nix-info"))
          (set _G.nix-info.debug-print (fn [...] (let [ args [...] ]
             (for [i 1 (select "#" ...)]
               (print (.. i ":\n" ((require :inspect) (. args i))))
             )
           )))
           (set _G.nix-info.call-setup (λ [mod opts]
             ((. (require mod) :setup) opts)
           ))
        '';
      };
    };
}
