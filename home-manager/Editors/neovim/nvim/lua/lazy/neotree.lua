return {
	{
		"neo-tree.nvim",
		keys = {
			{ "<leader>e", "<CMD>Neotree toggle<CR>", desc = "Toggle neotree" },
		},
		after = function()
			require("neo-tree").setup({
				window = {
					mappings = {
						["P"] = {
							"toggle_preview",
							config = {
								use_float = true,
								use_snacks_image = true,
								title = "Neo-tree Preview",
							},
						},
					},
				},
			})
			vim.keymap.set("n", "-", function()
				local reveal_file = vim.fn.expand("%:p")
				if reveal_file == "" then
					reveal_file = vim.fn.getcwd()
				else
					local f = io.open(reveal_file, "r")
					if f then
						f.close(f)
					else
						reveal_file = vim.fn.getcwd()
					end
				end
				require("neo-tree.command").execute({
					action = "focus", -- OPTIONAL, this is the default value
					source = "filesystem", -- OPTIONAL, this is the default value
					position = "right", -- OPTIONAL, this is the default value
					reveal_file = reveal_file, -- path to file or folder to reveal
					reveal_force_cwd = true, -- change cwd without asking if needed
				})
			end, { desc = "Open neo-tree at current file or working directory" })
		end,
	},
}
