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

-- Or use default settings
-- require("eza-preview"):setup({})
