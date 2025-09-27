{
  vim = {
    ui = {
      colorizer = {
        enable = true;
      };

      noice = {
        enable = true;
      };

      breadcrumbs = {
        enable = true;
        lualine.winbar = {
          enable = true;
          alwaysRender = true;
        };
      };

      borders = {
        enable = true;
        globalStyle = "rounded";
        plugins = {
          lspsaga = {
            enable = true;
          };
          which-key = {
            enable = true;
          };
        };
      };
    };
  };
}
