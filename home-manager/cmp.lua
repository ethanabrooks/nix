local config = function()
	local cmp = require("cmp")
	cmp.setup({
		mapping = {
			["<C-j>"] = cmp.mapping(
				cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				{ "i", "c" }
			),
			["<C-k>"] = cmp.mapping(
				cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				{ "i", "c" }
			),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.config.disable, -- Remove the default `<C-y>` mapping.
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		},
		experimental = {
			ghost_text = true,
		},
		formatting = {
			format = function(entry, vim_item)
				-- vim_item.kind = kind_icons[vim_item.kind]
				-- Uncomment to see which sources provide each completion (useful for debugging)
				-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
				vim_item.menu = entry.source.name
				return vim_item
			end
		},
		sources = {
			{ name = "copilot" },
			{ name = "nvim_lsp" },
			{ name = "buffer" },
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
	})
end

config()
