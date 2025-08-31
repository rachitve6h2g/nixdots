{ config, ... }: let 
  theme = config.colorscheme.palette;
in {
  programs.wofi = {
    enable = if (config.programs.fuzzel.enable == true ) 
      then false
      else true;

    settings = {
      allow_images = true;
      width = "30%";
      insensitive = true;
      allow_markup = true;

      key_up = "Ctrl-k";
      key_down = "Ctrl-j";
      key_expand = "Ctrl-l";
      key_hide_search = "Ctrl-KP_Space";
    };

    style =
      # css
      ''
        window {
          margin: 0px;
          background-color: #${theme.base00};
          border-radius: 0px;
          border: 2px solid #${theme.base08};
          color: #${theme.base05};
          font-family: 'monospace';
          font-size: 14px;
        }
        #input {
          margin: 5px;
          border-radius: 0px;
          border: none;
          border-radius: 0px;;
          color: #${theme.base08};
          background-color: #${theme.base02};
        }

        #inner-box {
          margin: 5px;
          border: none;
          background-color: #${theme.base02};
          color: #${theme.base00};
          border-radius: 0px;
        }

        #outer-box {
          margin: 15px;
          border: none;
          background-color: #${theme.base00};
        }

        #scroll {
          margin: 0px;
          border: none;
        }

        #text {
          margin: 5px;
          border: none;
          color: #${theme.base05};
        }

        #entry:selected {
          background-color: #${theme.base08};
          color: #${theme.base00};
          border-radius: 0px;;
          outline: none;
        }

        #entry:selected * {
          background-color: #${theme.base08};
          color: #${theme.base00};
          border-radius: 0px;;
          outline: none;
        }
      '';
  };
}
