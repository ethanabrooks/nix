require("copilot").setup({
	suggestion = {
		enabled = false,
		auto_trigger = true,
	},
	panel = { enabled = false, },
	filetypes = {
		text = true,
		yaml = true,
		markdown = true,
		help = true,
		gitcommit = true,
		gitrebase = true,
		hgcommit = true,
		svn = true,
		cvs = true,
		["."] = true,
	}
})
