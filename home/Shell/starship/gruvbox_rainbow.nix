{
  git_status = {
    style = "bg:color_aqua";
    format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
  };
  c = {
    symbol = " ";
    style = "bg:color_blue";
    format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
  };
  python = {
    symbol = "";
    style = "bg:color_blue";
    format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
  };
  username = {
    format = "[ $user ]($style)";
    show_always = true;
    style_user = "bg:color_orange fg:color_fg0";
    style_root = "bg:color_orange fg:color_fg0";
  };
  git_branch = {
    symbol = "";
    style = "bg:color_aqua";
    format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
  };
  php = {
    symbol = "";
    style = "bg:color_blue";
    format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
  };
  java = {
    format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
    symbol = " ";
    style = "bg:color_blue";
  };
  lua = {
    format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
    symbol = "  ";
    style = "bg:color_blue";
  };
  docker_context = {
    symbol = "";
    style = "bg:color_bg3";
    format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
  };
  character = {
    vimcmd_visual_symbol = "[](bold fg:color_yellow)";
    disabled = false;
    success_symbol = "[](bold fg:color_green)";
    error_symbol = "[](bold fg:color_red)";
    vimcmd_symbol = "[](bold fg:color_green)";
    vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
    vimcmd_replace_symbol = "[](bold fg:color_purple)";
  };
  golang = {
    symbol = "";
    style = "bg:color_blue";
    format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
  };
  "$schema" = "https://starship.rs/config-schema.json";
  palette = "gruvbox_dark";
  palettes = {
    gruvbox_dark = {
      color_bg3 = "#665c54";
      color_blue = "#458588";
      color_aqua = "#689d6a";
      color_yellow = "#d79921";
      color_bg1 = "#3c3836";
      color_green = "#98971a";
      color_orange = "#d65d0e";
      color_purple = "#b16286";
      color_red = "#cc241d";
      color_fg0 = "#fbf1c7";
    };
  };
  os = {
    symbols = {
      Macos = "󰀵";
      Alpine = "";
      Artix = "󰣇";
      Redhat = "󱄛";
      Manjaro = "";
      Linux = "󰌽";
      Gentoo = "󰣨";
      Android = "";
      Arch = "󰣇";
      Debian = "󰣚";
      RedHatEnterprise = "󱄛";
      Windows = "󰍲";
      Fedora = "󰣛";
      Ubuntu = "󰕈";
      Mint = "󰣭";
      Amazon = "";
      CentOS = "";
      Pop = "";
      SUSE = "";
      Raspbian = "󰐿";
      NixOS = " ";
    };
    disabled = false;
    style = "bg:color_orange fg:color_fg0";
  };
  nodejs = {
    format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
    symbol = "";
    style = "bg:color_blue";
  };
  rust = {
    symbol = "";
    style = "bg:color_blue";
    format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
  };
  time = {
    disabled = false;
    time_format = "%R";
    style = "bg:color_bg1";
    format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
  };
  format = "[](color_orange)$os$username[](bg:color_yellow fg:color_orange)$directory[](fg:color_yellow bg:color_aqua)$git_branch$git_status[](fg:color_aqua bg:color_blue)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:color_blue bg:color_bg3)$docker_context[](fg:color_bg3 bg:color_bg1)$time[ ](fg:color_bg1)$line_break$character";
  directory = {
    style = "fg:color_fg0 bg:color_yellow";
    format = "[ $path ]($style)";
    truncation_length = 3;
    truncation_symbol = "…/";
    substitutions = {
      Pictures = " ";
      Developer = "󰲋 ";
      Documents = "󰈙 ";
      Downloads = " ";
      Music = "󰝚 ";
    };
  };
  kotlin = {
    symbol = "";
    style = "bg:color_blue";
    format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
  };
  haskell = {
    symbol = "";
    style = "bg:color_blue";
    format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
  };
  line_break = {
    disabled = false;
  };
}
