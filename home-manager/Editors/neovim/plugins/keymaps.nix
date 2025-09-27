{
  vim = {
    keymaps = [
      {
        mode = "i";
        key = "jj";
        action = "<Esc>";
        desc = "Just Escape";
      }

      {
        mode = "n";
        key = "<leader>e";
        action = "<CMD>Neotree toggle right<CR>";
        desc = "Open filetree";
      }
    ];

    binds = {
      whichKey = {
        enable = true;
        setupOpts.win.border = "rounded";
      };
    };
  };
}
