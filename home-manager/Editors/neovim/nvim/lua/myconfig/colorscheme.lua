vim.o.background = "dark"
-- values shown are defaults and will be used if not provided
local config = {
  gruvbox_material_enable_italic = true,
  gruvbox_material_background = "hard",
  gruvbox_material_better_performance = 1,
  gruvbox_material_foreground = "mix",
  gruvbox_material_transparent_background = 1,
  gruvbox_material_statusline_style = "mix",
}

for k, v in pairs(config) do
  vim.g[k] = v
end

vim.cmd.colorscheme("gruvbox-material")
