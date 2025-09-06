{
  programs = {
    firefoxpwa = {
      enable = true;
      settings = {
        config = {
          always_patch = true;
          runtime_enable_wayland = true;
          use_linked_runtime = true;
        };
      };

      profiles = {
        krish = {
          name = "krish";
        };
      };
    };
  };
}
