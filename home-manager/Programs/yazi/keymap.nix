{
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

      # For restore.yazi
      {
        on = "u";
        run = "plugin restore -- --interactive";
        desc = "Restore last deleted files/folders";
      }
    ];
  };
}
