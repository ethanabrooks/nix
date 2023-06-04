local telescope = require("telescope")
telescope.setup({})
-- telescope.load_extension("fzf") -- TODO: renable, see below

-- Keybindings
local builtin = require("telescope.builtin")
require("which-key").register({
	g = {
		d = { builtin.lsp_definitions, "Go to definition" },
		r = { builtin.lsp_references, "Find references" },
	},
	["<Leader>"] = {
		b = { builtin.buffers, "Find buffers" },
		D = { builtin.diagnostics, "Workspace diagnostics" },
		f = { builtin.find_files, "Find files" },
		h = { builtin.help_tags, "Find help" },
		["/"] = { builtin.live_grep, "Live GREP" },
		["?"] = { builtin.commands, "Find commands" },
	},
}, { mode = "n", noremap = true })

-- Theme
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "TelescopeNormal" })
-- vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "TelescopeNormal" })
-- vim.api.nvim_set_hl(0, "TelescopeMultiIcon", { link = "TelescopeNormal" })
