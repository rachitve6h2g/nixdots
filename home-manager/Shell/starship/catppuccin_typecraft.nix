{ lib, ... }:
{
  "$schema" = "https://starship.rs/config-schema.json";

  format = lib.concatStrings [
    "[](base02)"
    "$os"
    "$username"
    "[](bg:orange fg:base02)"
    "$directory"
    "[](fg:orange bg:green)"
    "$git_branch"
    "$git_status"
    "[](fg:green bg:cyan)"
    "$c"
    "$python"
    "[](fg:cyan bg:blue)"
    "$docker_context"
    "[](fg:blue bg:purple)"
    "$time"
    "[ ](fg:purple)"
    "$line_break$character"
  ];

  os = {
    disabled = false;
    style = "bg:base02 fg:white";

    symbols = {
      NixOS = " ";
    };
  };

  username = {
    show_always = true;
    style_user = "bg:base02 fg:white";
    style_root = "bg:base02 fg:white";
    format = "[ $user ]($style)";
  };

  directory = {
    style = "fg:base01 bg:orange";
    format = "[ $path ]($style)";
    truncation_length = 3;
    truncation_symbol = "../";
    substitutions = {
      Documents = "󰈙 ";
      Downloads = " ";
      Music = "󰝚 ";
      Pictures = " ";
      Development = "󰲋 ";
    };
  };

  git_branch = {
    symbol = "";
    style = "bg:cyan";
    format = "[[ $symbol $branch ](fg:black bg:green)]($style)";
  };

  git_status = {
    style = "bg:cyan";
    format = "[[($all_status$ahead_behind )](fg:black bg:green)]($style)";
  };

  c = {
    symbol = " ";
    style = "bg:cyan";
    format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
  };

  python = {
    symbol = " ";
    style = "bg:cyan";
    format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
  };

  time = {
    disabled = false;
    time_format = "%R";
    style = "bg:orange";
    format = "[[  $time ](fg:base01 bg:purple)]($style)";
  };

  line_break = {
    disabled = false;
  };

  character = {
    disabled = false;
    success_symbol = "[](bold fg:green)";
    error_symbol = "[](bold fg:red)";
  };

  cmd_duration = {
    format = "[$duration]($style) ";
    style = "yellow";
  };
}
