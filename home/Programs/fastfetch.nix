{
  programs.fastfetch = {
    enable = true;

    settings = {
      type = "kitty";
      source = "nixos_small";
      padding = {
        top = 2;
      };

      modules = [
        {
          type = "custom";
          format = "┌──────────────────────────────────────────┐";
        }
        {
          type = "chassis";
          key = "  󰇺 Chassis";
          format = "{1} {2} {3}";
        }
        {
          type = "os";
          key = "   OS";
          format = "{2}";
          keyColor = "red";
        }
        {
          type = "kernel";
          key = "   Kernel";
          format = "{2}";
          keyColor = "red";
        }
        {
          type = "packages";
          key = "  󰏗 Packages";
          keyColor = "green";
        }
        {
          type = "display";
          key = "  󰍹 Display";
          format = "{1}x{2} @ {3}Hz [{7}]";
          keyColor = "green";
        }
        {
          type = "terminal";
          key = "   Terminal";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "  󱗃 WM";
          format = "{2}";
          keyColor = "yellow";
        }
        {
          type = "custom";
          format = "└──────────────────────────────────────────┘";
        }
        "break"
        {
          type = "title";
          key = "  ";
          format = "{6} {7} {8}";
        }
        {
          type = "custom";
          format = "┌──────────────────────────────────────────┐";
        }
        {
          type = "cpu";
          format = "{1} @ {7}";
          key = "   CPU";
          keyColor = "blue";
        }
        {
          type = "gpu";
          format = "{1} {2}";
          key = "  󰊴 GPU";
          keyColor = "blue";
        }
        {
          type = "gpu";
          format = "{3}";
          key = "   GPU Driver";
          keyColor = "magenta";
        }
        {
          type = "memory";
          key = "    Memory ";
          keyColor = "magenta";
        }
        {
          type = "disk";
          key = "  󱦟 OS Age ";
          folders = "/";
          keyColor = "red";
          format = "{days} days";
        }
        {
          type = "uptime";
          key = "  󱫐 Uptime ";
          keyColor = "red";
        }
        {
          type = "custom";
          format = "└──────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
        "break"
      ];
    };
  };
}
