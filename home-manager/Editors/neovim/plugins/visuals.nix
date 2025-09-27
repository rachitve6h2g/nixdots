{
  vim = {
    visuals = {
      nvim-cursorline = {
        enable = true;
        setupOpts = {
          cursorline = {
            enable = true;
            number = true;
            cursorword = {
              enable = true;
              hl.underline = true;
            };
          };
        };
      };

      indent-blankline = {
        enable = true;

        setupOpts = {
          indent = {
            char = "│";
          };
        };
      };

      rainbow-delimiters = {
        enable = true;
      };

      nvim-web-devicons.enable = true;
      fidget-nvim.enable = true;
    };
  };
}
