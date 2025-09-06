require("mini.diff").setup()
local format_summary = function(data)
  local summary = vim.b[data.buf].minidiff_summary
  local t = {}
  if summary.add > 0 then
    table.insert(t, "+" .. summary.add)
  end
  if summary.change > 0 then
    table.insert(t, "~" .. summary.change)
  end
  if summary.delete > 0 then
    table.insert(t, "-" .. summary.delete)
  end
  vim.b[data.buf].minidiff_summary_string = table.concat(t, " ")
end
local au_opts = { pattern = "MiniDiffUpdated", callback = format_summary }
vim.api.nvim_create_autocmd("User", au_opts)
