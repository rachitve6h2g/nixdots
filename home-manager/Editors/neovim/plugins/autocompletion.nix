{
  vim = {
    autocomplete = {
      blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;

        mappings = {
          confirm = "<C-y>";
          next = "<C-n>";
          previous = "<C-p>";
        };

        sourcePlugins = {
          emoji.enable = true;
          ripgrep.enable = true;
          spell.enable = true;
        };
      };
    };
  };
}
