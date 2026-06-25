return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.config").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"nix",
				}, -- Specify the languages you need
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true, -- Enable syntax highlighting
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true, disable = {"python", "css", "gdscript"} -- Enable and Disable indentation
				},
			})
		end,
	},
}
