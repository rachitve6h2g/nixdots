{ pkgs, ... }:
{
  bypass = pkgs.yaziPlugins.bypass;
  dupes = pkgs.yaziPlugins.dupes; # requires jdupes-cli which is self-contained
  # in the plugin
  full-border = pkgs.yaziPlugins.full-border;
  git = pkgs.yaziPlugins.git;
  lazygit = pkgs.yaziPlugins.lazygit;
  mediainfo = pkgs.yaziPlugins.mediainfo;
  recycle-bin = pkgs.yaziPlugins.recycle-bin;
  rich-preview = pkgs.yaziPlugins.rich-preview;
  vcs-files = pkgs.yaziPlugins.vcs-files;
  smart-filter = pkgs.yaziPlugins.smart-filter;
  starship = pkgs.yaziPlugins.starship;
  yatline = pkgs.yaziPlugins.yatline;

  eza-preview = (
    pkgs.fetchFromGitHub {
      owner = "ahkohd";
      repo = "eza-preview.yazi";
      rev = "43913fa9aa7e14ee0d2bbe5d2ccd7a4c8f753268";
      hash = "sha256-ckG6cg4SLklhqomjicMlfW6hXMsx4A0IBO6T2GXp4iw=";
    }
  );
}
