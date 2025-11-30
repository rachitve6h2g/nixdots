{
  programs = {
    gh = {
      enable = true;
      settings = {
        version = 1;
        git_protocol = "ssh";
        editor = "nvim";
        prompt = "enabled";
        perfer_editor_prompt = "enabled";
        aliases = {
          co = "pr checkout";
        };
        color_labels = "enabled";
        accessible_colors = "enabled";
        accessible_prompter = "enabled";
        spinner = "enabled";
      };
    };

    gh-dash = {
      enable = true;
      # TODO: write the settings
      # settings = {};
    };
  };
}
