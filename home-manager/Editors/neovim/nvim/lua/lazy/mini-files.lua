return {
  {
    "mini.files",
    keys = {
      {
        "<leader>e",
        function(...)
          if not MiniFiles.close() then
            MiniFiles.open(...)
          end
        end,
        desc = "MiniFiles Toggle",
      },
    },
    after = function()
      require("mini.files").setup()
    end,
  },
}
