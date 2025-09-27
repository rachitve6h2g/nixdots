


-- SECTION: theme

-- Base16 theme
require('base16-colorscheme').setup({["base00"] = "#1d2021",["base01"] = "#3c3836",["base02"] = "#504945",["base03"] = "#665c54",["base04"] = "#bdae93",["base05"] = "#d5c4a1",["base06"] = "#ebdbb2",["base07"] = "#fbf1c7",["base08"] = "#fb4934",["base09"] = "#fe8019",["base0A"] = "#fabd2f",["base0B"] = "#b8bb26",["base0C"] = "#8ec07c",["base0D"] = "#83a598",["base0E"] = "#d3869b",["base0F"] = "#d65d0e"})




-- SECTION: globalsScript
vim.g.editorconfig = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- SECTION: basic
vim.cmd("syntax on")








vim.o.smartcase = false
vim.o.ignorecase = false



-- SECTION: optionsScript
vim.o.autoindent = true
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 1
vim.o.confirm = true
vim.o.cursorlineopt = "line"
vim.o.encoding = "utf-8"
vim.o.errorbells = false
vim.o.expandtab = true
vim.o.hidden = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 0
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.tm = 500
vim.o.undodir = vim.fn.stdpath('state') .. '/undo'
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.visualbell = false
vim.o.wrap = false
vim.o.writebackup = false


-- SECTION: lazyConfigs
require('lz.n').load({{"blink-cmp",["after"] = function()
  
  require("blink.cmp").setup({["appearance"] = {["kind_icons"] = require("lspkind").symbol_map
},["cmdline"] = {["keymap"] = {["<C-Space>"] = {"show","fallback"},["<C-d>"] = {"scroll_documentation_up","fallback"},["<C-e>"] = {"hide","fallback"},["<C-f>"] = {"scroll_documentation_down","fallback"},["<C-n>"] = {"select_next","show","fallback"},["<C-p>"] = {"select_prev","fallback"},["preset"] = "none"}},["completion"] = {["documentation"] = {["auto_show"] = true,["auto_show_delay_ms"] = 200},["menu"] = {["auto_show"] = true}},["fuzzy"] = {["implementation"] = "prefer_rust",["prebuilt_binaries"] = {["download"] = false}},["keymap"] = {["<C-Space>"] = {"show","fallback"},["<C-d>"] = {"scroll_documentation_up","fallback"},["<C-e>"] = {"hide","fallback"},["<C-f>"] = {"scroll_documentation_down","fallback"},["<C-n>"] = {"select_next","snippet_forward",function(cmp)
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  has_words_before = col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil

  if has_words_before then
    return cmp.show()
  end
end
,"fallback"},["<C-p>"] = {"select_prev","snippet_backward","fallback"},["<C-y>"] = {"accept","fallback"},["preset"] = "none"},["sources"] = {["default"] = {"lsp","path","snippets","buffer","emoji","ripgrep","spell"},["providers"] = {["emoji"] = {["module"] = "blink-emoji",["name"] = "emoji"},["ripgrep"] = {["module"] = "blink-ripgrep",["name"] = "ripgrep"},["spell"] = {["module"] = "blink-cmp-spell",["name"] = "spell"}}}})
  

end
},{"fidget-nvim",["after"] = function()
  
  require("fidget").setup({["integration"] = {["nvim-tree"] = {["enable"] = false},["xcodebuild-nvim"] = {["enable"] = true}},["logger"] = {["float_precision"] = 0.010000,["level"] = vim.log.levels.WARN,["max_size"] = 10000,["path"] = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache"))
},["notification"] = {["configs"] = {["default"] = require('fidget.notification').default_config},["filter"] = vim.log.levels.INFO,["history_size"] = 128,["override_vim_notify"] = false,["poll_rate"] = 10,["redirect"] = function(msg, level, opts)
  if opts and opts.on_open then
    return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
  end
end
,["view"] = {["group_separator"] = "---",["group_separator_hl"] = "Comment",["icon_separator"] = " ",["render_message"] = function(msg, cnt)
  return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
end
,["stack_upwards"] = true},["window"] = {["align"] = "bottom",["border"] = "rounded",["max_height"] = 0,["max_width"] = 0,["normal_hl"] = "Comment",["relative"] = "editor",["winblend"] = 100,["x_padding"] = 1,["y_padding"] = 0,["zindex"] = 45}},["progress"] = {["display"] = {["done_icon"] = "✓",["done_style"] = "Constant",["done_ttl"] = 3,["format_annote"] = function(msg) return msg.title end
,["format_group_name"] = function(group) return tostring(group) end
,["format_message"] = require("fidget.progress.display").default_format_message
,["group_style"] = "Title",["icon_style"] = "Question",["overrides"] = {},["priority"] = 30,["progress_icon"] = {["pattern"] = "dots",["period"] = 1},["progress_style"] = "WarningMsg",["progress_ttl"] = 99999,["render_limit"] = 16,["skip_history"] = true},["ignore"] = {},["ignore_done_already"] = false,["ignore_empty_message"] = false,["lsp"] = {["log_handler"] = false,["progress_ringbuf_size"] = 100},["notification_group"] = function(msg)
  return msg.lsp_client.name
end
,["poll_rate"] = 0,["suppress_on_insert"] = false}})
  
end
,["event"] = "LspAttach"},{"gitlinker-nvim",["after"] = function()
  
  require("gitlinker").setup({})
  
end
,["cmd"] = {"GitLink"}},{"hunk-nvim",["after"] = function()
  
  require("hunk").setup({})
  
end
},{"lspsaga-nvim",["after"] = function()
  
  require("lspsaga").setup({["border_style"] = "rounded"})
  
end
,["event"] = {"LspAttach"}},{"neo-tree-nvim",["after"] = function()
  
  require("neo-tree").setup({["add_blank_line_at_top"] = false,["auto_clean_after_session_restore"] = false,["default_source"] = "filesystem",["enable_cursor_hijack"] = true,["enable_diagnostics"] = true,["enable_git_status"] = true,["enable_modified_markers"] = true,["enable_opened_markers"] = true,["enable_refresh_on_write"] = true,["filesystem"] = {["hijack_netrw_behavior"] = "open_default"},["git_status_async"] = false,["hide_root_node"] = false,["log_level"] = "info",["log_to_file"] = false,["open_files_do_not_replace_types"] = {"terminal","Trouble","qf","edgy"},["open_files_in_last_window"] = true,["retain_hidden_root_indent"] = false})
  
end
,["cmd"] = {"Neotree"}},{"toggleterm-nvim",["after"] = function()
  
  require("toggleterm").setup({["direction"] = "horizontal",["enable_winbar"] = true,["size"] = function(term)
  if term.direction == "horizontal" then
    return 15
  elseif term.direction == "vertical" then
    return vim.o.columns * 0.4
  end
end
,["winbar"] = {["enable"] = true,["enabled"] = true,["name_formatter"] = function(term)
  return term.name
end
}})
  local terminal = require 'toggleterm.terminal'
local lazygit = terminal.Terminal:new({
  cmd = '/nix/store/vagzw1wlfdjqd9v61c74jzq0k6jdl30v-lazygit-0.55.1/bin/lazygit',
  direction = 'float',
  hidden = true,
  on_open = function(term)
    vim.cmd("startinsert!")
  end
})

vim.keymap.set('n', "<leader>gg", function() lazygit:toggle() end, {silent = true, noremap = true, desc = 'Open lazygit [toggleterm]'})

end
,["cmd"] = {"ToggleTerm","ToggleTermSendCurrentLine","ToggleTermSendVisualLines","ToggleTermSendVisualSelection","ToggleTermSetName","ToggleTermToggleAll"},["keys"] = {{"<c-t>","<Cmd>execute v:count . \"ToggleTerm\"<CR>",["desc"] = "Toggle terminal",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>gg",["desc"] = "Open lazygit [toggleterm]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false}}},{"trouble",["after"] = function()
  
  require("trouble").setup({})
  
end
,["cmd"] = "Trouble",["keys"] = {{"<leader>lwd","<cmd>Trouble toggle diagnostics<CR>",["desc"] = "Workspace diagnostics [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>ld","<cmd>Trouble toggle diagnostics filter.buf=0<CR>",["desc"] = "Document diagnostics [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>lr","<cmd>Trouble toggle lsp_references<CR>",["desc"] = "LSP References [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>xq","<cmd>Trouble toggle quickfix<CR>",["desc"] = "QuickFix [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>xl","<cmd>Trouble toggle loclist<CR>",["desc"] = "LOCList [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>xs","<cmd>Trouble toggle symbols<CR>",["desc"] = "Symbols [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false}}}})
require('lzn-auto-require').enable()


-- SECTION: pluginConfigs
-- SECTION: autopairs
require('nvim-autopairs').setup({})


-- SECTION: lsp-setup
vim.g.formatsave = true;

local attach_keymaps = function(client, bufnr)
  vim.keymap.set('n', '<leader>lgD', vim.lsp.buf.declaration, {buffer=bufnr, noremap=true, silent=true, desc='Go to declaration'})
  vim.keymap.set('n', '<leader>lgd', vim.lsp.buf.definition, {buffer=bufnr, noremap=true, silent=true, desc='Go to definition'})
  vim.keymap.set('n', '<leader>lgt', vim.lsp.buf.type_definition, {buffer=bufnr, noremap=true, silent=true, desc='Go to type'})
  vim.keymap.set('n', '<leader>lgi', vim.lsp.buf.implementation, {buffer=bufnr, noremap=true, silent=true, desc='List implementations'})
  vim.keymap.set('n', '<leader>lgr', vim.lsp.buf.references, {buffer=bufnr, noremap=true, silent=true, desc='List references'})
  vim.keymap.set('n', '<leader>lgn', vim.diagnostic.goto_next, {buffer=bufnr, noremap=true, silent=true, desc='Go to next diagnostic'})
  vim.keymap.set('n', '<leader>lgp', vim.diagnostic.goto_prev, {buffer=bufnr, noremap=true, silent=true, desc='Go to previous diagnostic'})
  vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, {buffer=bufnr, noremap=true, silent=true, desc='Open diagnostic float'})
  vim.keymap.set('n', '<leader>lH', vim.lsp.buf.document_highlight, {buffer=bufnr, noremap=true, silent=true, desc='Document highlight'})
  vim.keymap.set('n', '<leader>lS', vim.lsp.buf.document_symbol, {buffer=bufnr, noremap=true, silent=true, desc='List document symbols'})
  vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, {buffer=bufnr, noremap=true, silent=true, desc='Add workspace folder'})
  vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, {buffer=bufnr, noremap=true, silent=true, desc='Remove workspace folder'})
  vim.keymap.set('n', '<leader>lwl', function() vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, {buffer=bufnr, noremap=true, silent=true, desc='List workspace folders'})
  vim.keymap.set('n', '<leader>lws', vim.lsp.buf.workspace_symbol, {buffer=bufnr, noremap=true, silent=true, desc='List workspace symbols'})
  vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, {buffer=bufnr, noremap=true, silent=true, desc='Trigger hover'})
  vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, {buffer=bufnr, noremap=true, silent=true, desc='Signature help'})
  vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, {buffer=bufnr, noremap=true, silent=true, desc='Rename symbol'})
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {buffer=bufnr, noremap=true, silent=true, desc='Code action'})
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {buffer=bufnr, noremap=true, silent=true, desc='Format'})
  vim.keymap.set('n', '<leader>ltf', function() vim.b.disableFormatSave = not vim.b.disableFormatSave end, {buffer=bufnr, noremap=true, silent=true, desc='Toggle format on save'})
end

local navic = require("nvim-navic")
default_on_attach = function(client, bufnr)
  attach_keymaps(client, bufnr)
  -- let navic attach to buffers
if client.server_capabilities.documentSymbolProvider then
  navic.attach(client, bufnr)
end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()


capabilities = require('blink.cmp').get_lsp_capabilities()



-- SECTION: lspconfig
local lspconfig = require('lspconfig')

require('lspconfig.ui.windows').default_options.border = "rounded"



-- SECTION: bash-lsp
lspconfig.bashls.setup{
  capabilities = capabilities;
  on_attach = default_on_attach;
  cmd = { "/nix/store/rr3inljnjalfa7gqbx08k4k26yh5690n-bash-language-server-5.6.0/bin/bash-language-server", "start" };
}


-- SECTION: breadcrumbs

local navic = require("nvim-navic")
require("nvim-navic").setup {
  highlight = true
}





-- SECTION: c-header
vim.g.c_syntax_for_h = 1

-- SECTION: nvim-dap
local dap = require("dap")
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "ErrorMsg", linehl = "", numhl = "" })


-- SECTION: clang-debugger
dap.adapters.lldb = {
  type = 'executable',
  command = '/nix/store/kbc27w69l4gf8ajqk2n5gmvi9gl4c91i-lldb-19.1.7/bin/lldb-dap',
  name = 'lldb'
}
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp


-- SECTION: clang-lsp
local clangd_cap = capabilities
-- use same offsetEncoding as null-ls
clangd_cap.offsetEncoding = {"utf-16"}
lspconfig.clangd.setup{
  capabilities = clangd_cap;
  on_attach=default_on_attach;
  cmd = { "/nix/store/57b6pxhalrm113ghzp1yxd7sr0k6pscb-clang-tools-19.1.7/bin/clangd" };
  
}


-- SECTION: colorizer
require('colorizer').setup({["filetypes"] = {},["user_default_options"] = {}})


-- SECTION: conform-nvim
require("conform").setup({["default_format_opts"] = {["lsp_format"] = "fallback"},["format_after_save"] = function()
  if not vim.g.formatsave or vim.b.disableFormatSave then
    return
  else
    return {["lsp_format"] = "fallback"}
  end
end
,["format_on_save"] = function()
  if not vim.g.formatsave or vim.b.disableFormatSave then
    return
  else
    return {lsp_format = "fallback", timeout_ms = 500}
  end
end
,["formatters"] = {["shfmt"] = {["command"] = "/nix/store/zsr06yh5kbsrahwxbi3mx0cjsbwaf7la-shfmt-3.12.0/bin/shfmt"}},["formatters_by_ft"] = {["sh"] = {"shfmt"}}})


-- SECTION: git-conflict
require('git-conflict').setup({["default_mappings"] = false})


-- SECTION: gitsigns
require('gitsigns').setup({})


-- SECTION: indent-blankline
require("ibl").setup({["debounce"] = 200,["indent"] = {["char"] = "│",["priority"] = 1,["repeat_linebreak"] = true,["smart_indent_cap"] = true},["scope"] = {["char"] = "│",["enabled"] = true,["exclude"] = {["language"] = {},["node_type"] = {["*"] = {"source_file","program"},["lua"] = {"chunk"},["python"] = {"module"}}},["highlight"] = {"RainbowRed","RainbowYellow","RainbowBlue","RainbowOrange","RainbowGreen","RainbowViolet","RainbowCyan"},["include"] = {["node_type"] = {}},["injected_languages"] = true,["priority"] = 1024,["show_end"] = false,["show_exact_scope"] = false,["show_start"] = false},["viewport_buffer"] = {["max"] = 500,["min"] = 30},["whitespace"] = {["remove_blankline_trail"] = true}})


-- SECTION: lightbulb
local nvim_lightbulb = require("nvim-lightbulb")
nvim_lightbulb.setup({})
vim.api.nvim_create_autocmd({"CursorHold","CursorHoldI"}, {
  pattern = "*",
  callback = function()
    nvim_lightbulb.update_lightbulb()
  end,
})



-- SECTION: lualine
local lualine = require('lualine')
lualine.setup {["extensions"] = {"neo-tree"},["inactive_sections"] = {["lualine_a"] = {},["lualine_b"] = {},["lualine_c"] = {'filename'},["lualine_x"] = {'location'},["lualine_y"] = {},["lualine_z"] = {}},["options"] = {["always_divide_middle"] = true,["component_separators"] = {["left"] = "",["right"] = ""},["globalstatus"] = true,["icons_enabled"] = true,["refresh"] = {["statusline"] = 1000,["tabline"] = 1000,["winbar"] = 1000},["section_separators"] = {["left"] = "",["right"] = ""},["theme"] = "base16"},["sections"] = {["lualine_a"] = {{
  "mode",
  icons_enabled = true,
  separator = {
    left = '▎',
    right = ''
  },
}
,{
  "",
  draw_empty = true,
  separator = { left = '', right = '' }
}
},["lualine_b"] = {{
  "filetype",
  colored = true,
  icon_only = true,
  icon = { align = 'left' }
}
,{
  "filename",
  symbols = {modified = ' ', readonly = ' '},
  separator = {right = ''}
}
,{
  "",
  draw_empty = true,
  separator = { left = '', right = '' }
}
},["lualine_c"] = {{
  "diff",
  colored = false,
  diff_color = {
    -- Same color values as the general color option can be used here.
    added    = 'DiffAdd',    -- Changes the diff's added color
    modified = 'DiffChange', -- Changes the diff's modified color
    removed  = 'DiffDelete', -- Changes the diff's removed color you
  },
  symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the diff symbols
  separator = {right = ''}
}
},["lualine_x"] = {{
  -- Lsp server name
  function()
    local buf_ft = vim.bo.filetype
    local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

    if excluded_buf_ft[buf_ft] then
      return ""
      end

    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if vim.tbl_isempty(clients) then
      return "No Active LSP"
    end

    local active_clients = {}
    for _, client in ipairs(clients) do
      table.insert(active_clients, client.name)
    end

    return table.concat(active_clients, ", ")
  end,
  icon = ' ',
  separator = {left = ''},
}
,{
  "diagnostics",
  sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'},
  symbols = {error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 '},
  colored = true,
  update_in_insert = false,
  always_visible = false,
  diagnostics_color = {
    color_error = { fg = 'red' },
    color_warn = { fg = 'yellow' },
    color_info = { fg = 'cyan' },
  },
}
},["lualine_y"] = {{
  "",
  draw_empty = true,
  separator = { left = '', right = '' }
}
,{
  'searchcount',
  maxcount = 999,
  timeout = 120,
  separator = {left = ''}
}
,{
  "branch",
  icon = ' •',
  separator = {left = ''}
}
},["lualine_z"] = {{
  "",
  draw_empty = true,
  separator = { left = '', right = '' }
}
,{
  "progress",
  separator = {left = ''}
}
,{"location"}
,{
  "fileformat",
  color = {fg='black'},
  symbols = {
    unix = '', -- e712
    dos = '',  -- e70f
    mac = '',  -- e711
  }
}
}},["winbar"] = {["lualine_c"] = {{"navic",draw_empty = true}}}}


-- SECTION: neo-tree
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("load_neo_tree", {}),
  desc = "Loads neo-tree when opening a directory",
  callback = function(args)
    local stats = vim.uv.fs_stat(args.file)

    if not stats or stats.type ~= "directory" then
      return
    end

    require("lz.n").trigger_load("neo-tree-nvim")

    return true
  end,
})


-- SECTION: nix-lsp
lspconfig.nixd.setup{
  capabilities = capabilities,
on_attach = default_on_attach,
  cmd = {"/nix/store/hvhiy4f7h95a5hkawy5x01d85aki7rbp-nixd-2.6.4/bin/nixd"},
  settings = {["nixd"] = {["formatting"] = {["command"] = {"/nix/store/l9pdm182h3qsp259j8yj7kyakrmblrx1-nixfmt-1.0.1/bin/nixfmt"}}}},
}


-- SECTION: noice-nvim
require("noice").setup({["format"] = {["cmdline"] = {["icon"] = "",["lang"] = "vim",["pattern"] = "^:"},["filter"] = {["icon"] = "",["lang"] = "bash",["pattern"] = "^:%s*!"},["help"] = {["icon"] = "󰋖",["pattern"] = "^:%s*he?l?p?%s+"},["lua"] = {["icon"] = "",["lang"] = "lua",["pattern"] = "^:%s*lua%s+"},["search_down"] = {["icon"] = " ",["kind"] = "search",["lang"] = "regex",["pattern"] = "^/"},["search_up"] = {["icon"] = " ",["kind"] = "search",["lang"] = "regex",["pattern"] = "^%?"}},["lsp"] = {["override"] = {["cmp.entry.get_documentation"] = false,["vim.lsp.util.convert_input_to_markdown_lines"] = true,["vim.lsp.util.stylize_markdown"] = true},["signature"] = {["enabled"] = false}},["presets"] = {["bottom_search"] = true,["command_palette"] = true,["inc_rename"] = false,["long_message_to_split"] = true,["lsp_doc_border"] = true},["routes"] = {{["filter"] = {["event"] = "msg_show",["find"] = "written",["kind"] = ""},["opts"] = {["skip"] = true}}}})


-- SECTION: nvim-cursorline
require("nvim-cursorline").setup({["cursorline"] = {["cursorword"] = {["enable"] = true,["hl"] = {["underline"] = true}},["enable"] = true,["number"] = true,["timeout"] = 1000},["cursorword"] = {["enable"] = false,["hl"] = {["underline"] = true},["min_length"] = 3,["timeout"] = 1000}})


-- SECTION: nvim-notify
local notify = require("notify")
notify.setup({["background_colour"] = "NotifyBackground",["icons"] = {["DEBUG"] = "",["ERROR"] = "",["INFO"] = "",["TRACE"] = "",["WARN"] = ""},["position"] = "top_right",["render"] = "compact",["stages"] = "fade_in_slide_out",["timeout"] = 1000})
vim.notify = notify.notify


-- SECTION: nvim-web-devicons
require("nvim-web-devicons").setup({["color_icons"] = true,["override"] = {}})


-- SECTION: nvimBufferline
require("bufferline").setup({["highlights"] = {},["options"] = {["always_show_bufferline"] = true,["auto_toggle_bufferline"] = true,["buffer_close_icon"] = " 󰅖 ",["close_command"] = function(bufnum)
  require("bufdelete").bufdelete(bufnum, false)
end
,["close_icon"] = "  ",["color_icons"] = true,["diagnostics"] = "nvim_lsp",["diagnostics_indicator"] = function(count, level, diagnostics_dict, context)
  local s = " "
    for e, n in pairs(diagnostics_dict) do
      local sym = e == "error" and "   "
        or (e == "warning" and "   " or "  " )
      s = s .. n .. sym
    end
  return s
end
,["diagnostics_update_in_insert"] = false,["duplicates_across_groups"] = true,["enforce_regular_tabs"] = false,["hover"] = {["delay"] = 200,["enabled"] = true,["reveal"] = {"close"}},["indicator"] = {["style"] = "underline"},["left_mouse_command"] = "buffer %d",["left_trunc_marker"] = "",["max_name_length"] = 18,["max_prefix_length"] = 15,["mode"] = "buffers",["modified_icon"] = "● ",["move_wraps_at_ends"] = false,["numbers"] = function(opts)
  return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
end
,["offsets"] = {{["filetype"] = "NvimTree",["highlight"] = "Directory",["separator"] = true,["text"] = "File Explorer"},{["filetype"] = "neo-tree",["highlight"] = "Directory",["separator"] = true,["text"] = "File Explorer"},{["filetype"] = "snacks_layout_box",["highlight"] = "Directory",["separator"] = true,["text"] = "File Explorer"}},["persist_buffer_sort"] = true,["right_mouse_command"] = "vertical sbuffer %d",["right_trunc_marker"] = "",["separator_style"] = "thin",["show_buffer_close_icons"] = true,["show_buffer_icons"] = true,["show_close_icon"] = true,["show_duplicate_prefix"] = true,["show_tab_indicators"] = true,["sort_by"] = "extension",["style_preset"] = require('bufferline').style_preset.default,["tab_size"] = 18,["themable"] = true,["truncate_names"] = true}})


-- SECTION: rainbow-delimiters
vim.g.rainbow_delimiters = {}


-- SECTION: treesitter
require('nvim-treesitter.configs').setup {
  -- Disable imperative treesitter options that would attempt to fetch
  -- grammars into the read-only Nix store. To add additional grammars here
  -- you must use the `config.vim.treesitter.grammars` option.
  auto_install = false,
  sync_install = false,
  ensure_installed = {},

  -- Indentation module for Treesitter
  indent = {
    enable = true,
    disable = {},
  },

  -- Highlight module for Treesitter
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },

  -- Indentation module for Treesitter
  -- Keymaps are set to false here as they are
  -- handled by `vim.maps` entries calling lua
  -- functions achieving the same functionality.
  incremental_selection = {
    enable = true,
    disable = {},
    keymaps = {
      init_selection = false,
      node_incremental = false,
      scope_incremental = false,
      node_decremental = false,

    },
  },
}


-- SECTION: treesitter-context
require("treesitter-context").setup({["line_numbers"] = true,["max_lines"] = 0,["min_window_height"] = 0,["mode"] = "cursor",["multiline_threshold"] = 20,["separator"] = "-",["trim_scope"] = "outer",["zindex"] = 20})


-- SECTION: whichkey
local wk = require("which-key")
wk.setup ({["notify"] = true,["preset"] = "modern",["replace"] = {["<cr>"] = "RETURN",["<leader>"] = "SPACE",["<space>"] = "SPACE",["<tab>"] = "TAB"},["win"] = {["border"] = "rounded"}})
wk.add({{{ '<leader>b', desc = '+Buffer' }},{{ '<leader>bm', desc = 'BufferLineMove' }},{{ '<leader>bs', desc = 'BufferLineSort' }},{{ '<leader>bsi', desc = 'BufferLineSortById' }},{{ '<leader>h', desc = '+Gitsigns' }},{{ '<leader>lw', desc = '+Workspace' }},{{ '<leader>x', desc = '+Trouble' }}})




-- SECTION: augroups
local nvf_autogroups = {}
for _, group in ipairs({{["clear"] = true,["enable"] = true,["name"] = "nvf_lazy_file_hooks"},{["clear"] = true,["enable"] = true,["name"] = "nvf_lsp"}}) do
  if group.name then
    nvf_autogroups[group.name] = { clear = group.clear }
  end
end

for group_name, options in pairs(nvf_autogroups) do
  vim.api.nvim_create_augroup(group_name, options)
end


-- SECTION: autocmds
local nvf_autocommands = {{["command"] = "doautocmd User LazyFile",["enable"] = true,["event"] = {"BufReadPost","BufNewFile","BufWritePre"},["group"] = "nvf_lazy_file_hooks",["nested"] = false,["once"] = true},{["callback"] = function(event)
  local bufnr = event.buf
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end
end
,["desc"] = "LSP on-attach enable inlay hints autocmd",["enable"] = true,["event"] = {"LspAttach"},["group"] = "nvf_lsp",["nested"] = false,["once"] = false}}
for _, autocmd in ipairs(nvf_autocommands) do
  vim.api.nvim_create_autocmd(
    autocmd.event,
    {
      group     = autocmd.group,
      pattern   = autocmd.pattern,
      buffer    = autocmd.buffer,
      desc      = autocmd.desc,
      callback  = autocmd.callback,
      command   = autocmd.command,
      once      = autocmd.once,
      nested    = autocmd.nested
    }
  )
end



-- SECTION: indent-blankline-post
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)


-- SECTION: indent-blankline-pre
-- A precursor Lua module that defines Lua locals that can be accessed in
-- ibl's setup function. All Lua locals defined here will be made available
-- to the DAG node in which ibl's setup is handled.
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
-- This Lua chunk will be placed *after* ibl's setup is done.
local ibl_hooks = require "ibl.hooks"

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
ibl_hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)
vim.g.rainbow_delimiters = { highlight = highlight }


-- SECTION: lsp-servers
-- Individual LSP configurations managed by nvf.
vim.lsp.config["*"] = {["capabilities"] = capabilities,["enable"] = true,["on_attach"] = default_on_attach}



-- Enable configured LSPs explicitly
vim.lsp.enable({})


-- SECTION: mappings
vim.keymap.set("i", "jj", "<Esc>", {["desc"] = "Just Escape",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>e", "<CMD>Neotree toggle right<CR>", {["desc"] = "Open filetree",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dc", require('dap').continue, {["desc"] = "Continue",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dR", require('dap').restart, {["desc"] = "Restart",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dq", require('dap').terminate, {["desc"] = "Terminate",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>d.", require('dap').run_last, {["desc"] = "Re-run Last Debug Session",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dr", require('dap').repl.toggle, {["desc"] = "Toggle Repl",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dh", require('dap.ui.widgets').hover, {["desc"] = "Hover",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>db", require('dap').toggle_breakpoint, {["desc"] = "Toggle breakpoint",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dgc", require('dap').run_to_cursor, {["desc"] = "Continue to the current cursor",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dgi", require('dap').step_into, {["desc"] = "Step into function",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dgo", require('dap').step_out, {["desc"] = "Step out of function",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dgj", require('dap').step_over, {["desc"] = "Next step",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dgk", require('dap').step_back, {["desc"] = "Step back",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dvo", require('dap').up, {["desc"] = "Go up stacktrace",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set("n", "<leader>dvi", require('dap').down, {["desc"] = "Go down stacktrace",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bc", ":BufferLinePick<CR>", {["desc"] = "Pick buffer",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bmn", ":BufferLineMoveNext<CR>", {["desc"] = "Move next buffer",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bmp", ":BufferLineMovePrev<CR>", {["desc"] = "Move previous buffer",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bn", ":BufferLineCycleNext<CR>", {["desc"] = "Next buffer",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bp", ":BufferLineCyclePrev<CR>", {["desc"] = "Previous buffer",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bsd", ":BufferLineSortByDirectory<CR>", {["desc"] = "Sort buffers by directory",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bse", ":BufferLineSortByExtension<CR>", {["desc"] = "Sort buffers by extension",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bsi", function() require("bufferline").sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end) end, {["desc"] = "Sort buffers by ID",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>c0", "<Plug>(git-conflict-none)", {["desc"] = "Choose None [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>cb", "<Plug>(git-conflict-both)", {["desc"] = "Choose Both [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>co", "<Plug>(git-conflict-ours)", {["desc"] = "Choose Ours [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>ct", "<Plug>(git-conflict-theirs)", {["desc"] = "Choose Theirs [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hD", function() package.loaded.gitsigns.diffthis('~') end, {["desc"] = "Diff project [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hP", package.loaded.gitsigns.preview_hunk, {["desc"] = "Preview hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hR", package.loaded.gitsigns.reset_buffer, {["desc"] = "Reset buffer [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hS", package.loaded.gitsigns.stage_buffer, {["desc"] = "Stage buffer [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hb", function() package.loaded.gitsigns.blame_line{full=true} end, {["desc"] = "Blame line [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hd", package.loaded.gitsigns.diffthis, {["desc"] = "Diff this [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hr", package.loaded.gitsigns.reset_hunk, {["desc"] = "Reset hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hs", package.loaded.gitsigns.stage_hunk, {["desc"] = "Stage hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hu", package.loaded.gitsigns.undo_stage_hunk, {["desc"] = "Undo stage hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>tb", package.loaded.gitsigns.toggle_current_line_blame, {["desc"] = "Toggle blame [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>td", package.loaded.gitsigns.toggle_deleted, {["desc"] = "Toggle deleted [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "[c", function()
  if vim.wo.diff then return "[c" end

  vim.schedule(function() package.loaded.gitsigns.prev_hunk() end)

  return '<Ignore>'
end
, {["desc"] = "Previous hunk [Gitsigns]",["expr"] = true,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "[x", "<Plug>(git-conflict-next-conflict)", {["desc"] = "Go to the next Conflict [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "]c", function()
  if vim.wo.diff then return "]c" end

  vim.schedule(function() package.loaded.gitsigns.next_hunk() end)

  return '<Ignore>'
end
, {["desc"] = "Next hunk [Gitsigns]",["expr"] = true,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "]x", "<Plug>(git-conflict-prev-conflict)", {["desc"] = "Go to the previous Conflict [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "gnn", ":lua require('nvim-treesitter.incremental_selection').init_selection()<CR>", {["desc"] = "Init selection [treesitter]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"v"}, "<leader>hr", function() package.loaded.gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {["desc"] = "Reset hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"v"}, "<leader>hs", function() package.loaded.gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {["desc"] = "Stage hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n","x"}, "grc", "<cmd>lua require('nvim-treesitter.incremental_selection').scope_incremental()<CR>", {["desc"] = "Increment selection by scope [treesitter]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n","x"}, "grm", "<cmd>lua require('nvim-treesitter.incremental_selection').node_decremental()<CR>", {["desc"] = "Decrement selection by node [treesitter]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n","x"}, "grn", "<cmd>lua require('nvim-treesitter.incremental_selection').node_incremental()<CR>", {["desc"] = "Increment selection by node [treesitter]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
