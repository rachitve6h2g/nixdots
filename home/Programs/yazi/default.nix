{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mediainfo # for mediainfo.yazi
    rich-cli
  ];

  programs = {
    yazi = {
      enable = true;
      shellWrapperName = "y";

      package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };

      plugins = {
        bypass = pkgs.yaziPlugins.bypass;
        full-border = pkgs.yaziPlugins.full-border;
        git = pkgs.yaziPlugins.git;
        lazygit = pkgs.yaziPlugins.lazygit;
        mediainfo = pkgs.yaziPlugins.mediainfo;
        rich-preview = pkgs.yaziPlugins.rich-preview;
        vcs-files = pkgs.yaziPlugins.vcs-files;
        smart-filter = pkgs.yaziPlugins.smart-filter;
        starship = pkgs.yaziPlugins.starship;

        eza-preview = (
          pkgs.fetchFromGitHub {
            owner = "ahkohd";
            repo = "eza-preview.yazi";
            rev = "43913fa9aa7e14ee0d2bbe5d2ccd7a4c8f753268";
            hash = "sha256-ckG6cg4SLklhqomjicMlfW6hXMsx4A0IBO6T2GXp4iw=";
          }
        );
      };

      settings = {
        log = {
          enabled = true;
        };

        mgr = {
          ratio = [
            1
            4
            3
          ];
          show_hidden = true;
          show_symlink = true;
          sort_reverse = false;
          sort_sensitive = true;
          sort_dir_first = true;
          sort_by = "natural";
          linemode = "size_and_mtime";
        };

        preview = {
          image_filter = "lanczos3";
          image_quality = 90;
          tab_size = 1;
          max_width = 600;
          max_height = 900;
          cache_dir = "";
          ueberzug_scale = 1;
          ueberzug_offset = [
            0
            0
            0
            0
          ];
        };

        tasks = {
          micro_workers = 5;
          macro_workers = 10;
          bizarre_retry = 5;
        };

        plugin = {
          prepend_fetchers = [
            {
              id = "git";
              name = "*";
              run = "git";
            }
            {
              id = "git";
              name = "*/";
              run = "git";
            }
          ];

          prepend_preloaders = [
            {
              mime = "{audio,video,image}/*";
              run = "mediainfo";
            }
            {
              mime = "application/subrip";
              run = "mediainfo";
            }
          ];

          prepend_previewers = [
            {
              mime = "{audio,video,image}/*";
              run = "mediainfo";
            }

            {
              mime = "application/subrip";
              run = "mediainfo";
            }

            {
              name = "*/";
              run = "eza-preview";
            }

            {
              name = "*.csv";
              run = "rich-preview";
            }
            {
              name = "*.md";
              run = "rich-preview";
            }
            {
              name = "*.rst";
              run = "rich-preview";
            }
            {
              name = "*.ipynb";
              run = "rich-preview";
            }
            {
              name = "*.json";
              run = "rich-preview";
            }
          ];
        };

      };
      keymap = {
        mgr = {
          prepend_keymap = [
            {
              on = [
                "g"
                "i"
              ];
              run = "plugin lazygit";
              desc = "run lazygit";
            }
            {
              on = [
                "g"
                "c"
              ];
              run = "plugin vcs-files";
              desc = "Show Git file changes";
            }

            {
              on = [ "<C-e>" ];
              run = "seek 5";
            }

            {
              on = [ "<C-y>" ];
              run = "seek -5";
            }

            {
              on = [ "L" ];
              run = "plugin bypass";
              desc = "Recursively enter the child directory, skipping children with only a single subdirectory";
            }

            {
              on = [ "H" ];
              run = "plugin bypass reverse";
              desc = "Recursively enter the child directory, skipping children with only a single subdirectory";
            }

            {
              on = [ "F" ];
              run = "plugin smart-filter";
              desc = "Smart Filter";
            }

            # For eza preview
            {
              on = [
                "E"
              ];
              run = "plugin eza-preview";
              desc = "Toggle tree/list dir preview";
            }
            {
              on = [
                "-"
              ];
              run = "plugin eza-preview inc-level";
              desc = "Increment tree level";
            }
            {
              on = [
                "_"
              ];
              run = "plugin eza-preview dec-level";
              desc = "Decrement tree level";
            }
            {
              on = [
                "$"
              ];
              run = "plugin eza-preview toggle-follow-symlinks";
              desc = "Toggle tree follow symlinks";
            }
            {
              run = "plugin eza-preview toggle-hidden";
              desc = "Toggle hidden files";
              on = [
                "*"
              ];
            }
          ];
        };
      };

      initLua = builtins.readFile ./init.lua;
    };
  };
}
