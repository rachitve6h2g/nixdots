{ self, ... }:
let
  inherit (self) theme;
in
{
  perSystem = {
    wrappers.control_type = "build";
    wrappers.packages.btop = true;
  };
  flake.wrappers.btop =
    {
      wlib,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.btop ];
      themes = {
        my-theme = with theme; ''
          	   theme[main_bg]="${base00}"
                      theme[main_fg]="${base05}"
                      theme[title]="${base05}"
                      theme[hi_fg]="${base0D}"
                      theme[selected_bg]="${base03}"
                      theme[selected_fg]="${base0D}"
                      theme[inactive_fg]="${base04}"
                      theme[graph_text]="${base06}"
                      theme[meter_bg]="${base03}"
                      theme[proc_misc]="${base06}"
                      theme[cpu_box]="${base0E}"
                      theme[mem_box]="${base0B}"
                      theme[net_box]="${base0C}"
                      theme[proc_box]="${base0D}"
                      theme[div_line]="${base01}"
                      theme[temp_start]="${base0B}"
                      theme[temp_mid]="${base0A}"
                      theme[temp_end]="${base08}"
                      theme[cpu_start]="${base0B}"
                      theme[cpu_mid]="${base0A}"
                      theme[cpu_end]="${base08}"
                      theme[free_start]="${base0A}"
                      theme[free_mid]="${base0B}"
                      theme[free_end]="${base0B}"
                      theme[cached_start]="${base0C}"
                      theme[cached_mid]="${base0C}"
                      theme[cached_end]="${base0A}"
                      theme[available_start]="${base08}"
                      theme[available_mid]="${base0A}"
                      theme[available_end]="${base0B}"
                      theme[used_start]="${base0A}"
                      theme[used_mid]="${base09}"
                      theme[used_end]="${base08}"
                      theme[download_start]="${base0B}"
                      theme[download_mid]="${base0A}"
                      theme[download_end]="${base08}"
                      theme[upload_start]="${base0B}"
                      theme[upload_mid]="${base0A}"
                      theme[upload_end]="${base08}"
                      theme[process_start]="${base0B}"
                      theme[process_mid]="${base0A}"
                      theme[process_end]="${base08}"
          	'';
      };
      settings = {
        theme_background = false;
        vim_keys = true;
        rounded_corners = true;
        color_theme = "my-theme";
      };
      addFlag = [ "--force-utf" ];
    };
}
