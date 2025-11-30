{
  mgr = {
    prepend_keymap = [
      {
        on = [
          "g"
          "i"
        ];
        run = "plugin gitui";
        desc = "run gitui";
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

      # For dupes.yazi: find the duplicates
      {
        on = [
          "<A-J>"
          "i"
        ];
        run = "plugin dupes interactive";
        desc = "Run dupes interactive";
      }
      {
        on = [
          "<A-J>"
          "o"
        ];
        run = "plugin dupes override";
        desc = "Run dupes override";
      }
      {
        on = [
          "<A-J>"
          "d"
        ];
        run = "plugin dupes dry";
        desc = "Run dupes dry";
      }
      {
        on = [
          "<A-J>"
          "a"
        ];
        run = "plugin dupes apply";
        desc = "Run dupes apply";
      }

      # For recycle-bin.yazi
      {
        on = [
          "R"
          "b"
        ];
        run = "plugin recycle-bin";
      }
    ];
  };
}
