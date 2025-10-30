{
  "$schema" = "https://starship.rs/config-schema.json";
  os = {
    format = "[ $symbol ]($style)";
    style = "bg:color_wave_blue fg:color_fg0";
    symbols = {
      Fedora = "󰣛";
      Android = "";
      Artix = "󰣇";
      EndeavourOS = "";
      Windows = "󰍲";
      Raspbian = "󰐿";
      Macos = "󰀵";
      Manjaro = "";
      Linux = "󰌽";
      Amazon = "";
      CentOS = "";
      Debian = "󰣚";
      Pop = "";
      SUSE = "";
      Alpine = "";
      Arch = "󰣇";
      Redhat = "󱄛";
      RedHatEnterprise = "󱄛";
      Ubuntu = "󰕈";
      Mint = "󰣭";
      Gentoo = "󰣨";
      NixOS = " ";
    };
    disabled = false;
  };
  docker_context = {
    style = "bg:color_cyan fg:color_fg0";
    symbol = "󰡨";
    format = "[ $symbol $context ]($style)";
  };
  format = "[░▒▓](color_wave_blue)$os[](bg:color_purple fg:color_wave_blue)$username[](bg:color_blue fg:color_purple)$directory[](bg:color_wave_blue fg:color_blue)[ ](color_wave_blue)";
  username = {
    show_always = true;
    format = "[ $user ]($style)";
    style_user = "bg:color_purple fg:color_fg0";
    style_root = "bg:color_cyan fg:color_fg0 bold";
  };
  directory = {
    format = "[ $path ]($style)[$read_only]($read_only_style)";
    style = "bg:color_blue fg:color_fg0";
    read_only = "󰌾 ";
    read_only_style = "bg:color_blue fg:color_bright_red dimmed";
  };
  rust = {
    format = "[ $symbol ($version) ]($style)";
    style = "bg:color_orange fg:color_bg0";
    symbol = "󱘗";
  };
  time = {
    time_format = "%R";
    style = "bg:color_wave_blue fg:color_fg0";
    disabled = false;
    format = "[ $time ]($style)";
  };
  cmd_duration = {
    format = "[  $duration ]($style)";
    style = "bg:color_bg3 fg:color_fg0";
  };
  php = {
    style = "bg:color_purple fg:color_fg0";
    symbol = "";
    format = "[ $symbol ($version) ]($style)";
  };
  right_format = "[](bg:color_wave_blue fg:color_bg1)[█](color_wave_blue)$cmd_duration$git_branch$git_status$docker_context$nodejs$php$rust$time[▓▒░](color_wave_blue)";
  palette = "kanagawa_wave";
  palettes = {
    kanagawa_wave = {
      color_git_change = "#DCA561";
      color_git_delete = "#C34043";
      color_fg0 = "#DCD7BA";
      color_fg1 = "#C8C093";
      color_bg2 = "#2A2A37";
      color_yellow = "#C0A36E";
      color_cyan = "#6A9589";
      color_bright_cyan = "#7AA89F";
      color_git_add = "#76946A";
      color_wave_blue = "#2D4F67";
      color_bg1 = "#1F1F28";
      color_bright_green = "#98BB6C";
      color_bright_purple = "#938AA9";
      color_green = "#76946A";
      color_purple = "#957FB8";
      color_bright_red = "#E82424";
      color_bright_yellow = "#E6C384";
      color_bright_blue = "#7FB4CA";
      color_comment = "#727169";
      color_bg0 = "#16161D";
      color_bg3 = "#54546D";
      color_red = "#C34043";
      color_blue = "#7E9CD8";
      color_orange = "#FFA066";
    };
    kanagawa_dragon = {
      color_comment = "#737c73";
      color_cyan = "#8ea4a2";
      color_orange = "#b6927b";
      color_bright_purple = "#938AA9";
      color_bright_cyan = "#7AA89F";
      color_wave_blue = "#949fb5";
      color_bright_green = "#87a987";
      color_bright_blue = "#7FB4CA";
      color_git_delete = "#c4746e";
      color_fg0 = "#c5c9c5";
      color_fg1 = "#a6a69c";
      color_bg0 = "#0d0c0c";
      color_bg1 = "#181616";
      color_bg2 = "#282727";
      color_bg3 = "#625e5a";
      color_green = "#8a9a7b";
      color_yellow = "#c4b28a";
      color_red = "#c4746e";
      color_blue = "#8ba4b0";
      color_purple = "#a292a3";
      color_bright_red = "#E46876";
      color_bright_yellow = "#E6C384";
      color_git_add = "#87a987";
      color_git_change = "#c4b28a";
    };
    kanagawa_lotus = {
      color_bright_yellow = "#836f4a";
      color_bright_cyan = "#5e857a";
      color_git_delete = "#c84053";
      color_fg0 = "#545464";
      color_bg0 = "#f2ecbc";
      color_bg1 = "#e5ddb0";
      color_bg3 = "#c9cbd1";
      color_green = "#6f894e";
      color_bright_red = "#d7474b";
      color_git_add = "#6f894e";
      color_git_change = "#77713f";
      color_purple = "#b35b79";
      color_cyan = "#597b75";
      color_orange = "#e98a00";
      color_fg1 = "#43436c";
      color_bright_blue = "#6693bf";
      color_bright_purple = "#624c83";
      color_comment = "#8a8980";
      color_wave_blue = "#c7d7e0";
      color_bg2 = "#dcd5ac";
      color_red = "#c84053";
      color_yellow = "#77713f";
      color_blue = "#4d699b";
      color_bright_green = "#6e915f";
    };
  };
  git_branch = {
    format = "[ $symbol$branch(:$remote_branch)]($style)";
    style = "bg:color_yellow fg:color_bg0";
    symbol = "󰘬 ";
    truncation_length = 12;
  };
  git_status = {
    format = "[ $all_status$ahead_behind ]($style)";
    style = "bg:color_yellow fg:color_bg0";
  };
  nodejs = {
    style = "bg:color_green fg:color_fg0";
    not_capable_style = "bg:color_red fg:color_fg0";
    format = "[ $symbol($version) ]($style)";
  };
}
