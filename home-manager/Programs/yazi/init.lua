-- For full-border plugin
require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

-- for git.yazi
require("git"):setup()
-- Modifications of color
th.git = th.git or {}
th.git.modified = ui.Style():fg("#9ccfd8")
th.git.deleted = ui.Style():fg("#eb6f92")

-- ~/.config/yazi/init.lua
function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end

-- starship prompt
require("starship"):setup({
	hide_flags = false,
	flags_after_prompt = true,
	config_file = "~/.config/starship.toml",
})

-- -- eza-preview
require("eza-preview"):setup({
	-- Set the tree preview to be default (default: true)
	default_tree = true,

	-- Directory depth level for tree preview (default: 3)
	level = 3,

	-- Follow symlinks when previewing directories (default: false)
	follow_symlinks = false,

	-- Show target file info instead of symlink info (default: false)
	dereference = false,

	-- Show hidden files (default: true)
	all = true,

	-- Ignore files matching patterns (default: {})
	-- ignore_glob = "*.log"
	-- ignore_glob = { "*.tmp", "node_modules", ".git", ".DS_Store" }
	-- SEE: https://www.linuxjournal.com/content/pattern-matching-bash to learn about glob patterns
	ignore_glob = {},
})

-- restore yazi plugin
require("restore"):setup({
	-- Set the position for confirm and overwrite prompts.
	-- Don't forget to set height: `h = xx`
	-- https://yazi-rs.github.io/docs/plugins/utils/#ya.input
	position = { "center", w = 70, h = 40 }, -- Optional

	-- Show confirm prompt before restore.
	-- NOTE: even if set this to false, overwrite prompt still pop up
	show_confirm = true, -- Optional

	-- Suppress success notification when all files or folder are restored.
	suppress_success_notification = true, -- Optional

	-- colors for confirm and overwrite prompts
	theme = { -- Optional
		-- Default using style from your flavor or theme.lua -> [confirm] -> title.
		-- If you edit flavor or theme.lua you can add more style than just color.
		-- Example in theme.lua -> [confirm]: title = { fg = "blue", bg = "green"  }
		title = "blue", -- Optional. This value has higher priority than flavor/theme.lua

		-- Default using style from your flavor or theme.lua -> [confirm] -> content
		-- Sample logic as title above
		header = "green", -- Optional. This value has higher priority than flavor/theme.lua

		-- header color for overwrite prompt
		-- Default using color "yellow"
		header_warning = "yellow", -- Optional
		-- Default using style from your flavor or theme.lua -> [confirm] -> list
		-- Sample logic as title and header above
		list_item = { odd = "blue", even = "blue" }, -- Optional. This value has higher priority than flavor/theme.lua
	},
})
