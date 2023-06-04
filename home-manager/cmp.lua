local config = function()
	local cmp = require("cmp")
	local kind_icons = {
		Text = "",
		Method = "󰆧",
		Function = "",
		Constructor = "",
		Field = "󰇽",
		Variable = "󰂡",
		Class = "󰠱",
		Interface = "",
		Module = "",
		Property = "󰜢",
		Unit = "",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰏘",
		File = "󰈙",
		Reference = "",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰏿",
		Struct = "",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "󰅲",
	}
	cmp.setup({
		--    snippet = {
		--      expand = function(args)
		--        require("luasnip").lsp_expand(args.body)
		--      end,
		--    },
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
		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = kind_icons[vim_item.kind]
				-- Uncomment to see which sources provide each completion (useful for debugging)
				-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
				-- vim_item.menu = entry.source.name
				return vim_item
			end
		},
		experimental = {
			ghost_text = true,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			--      { name = "nvim_lsp_signature_help" },
			--      {
			--        name = "treesitter",
			--        entry_filter = function(entry)
			--          local kind = require('cmp.types').lsp.CompletionItemKind[entry:get_kind()]
			--          for _, v in ipairs({ 'Text', 'Comment' }) do
			--            if v == kind then
			--              return false
			--            end
			--          end
			--          return true
			--        end
			--      },
			--      { name = "path" },
			--      { name = "nvim_lua" },
			--      { name = "luasnip" },
			--      { name = "spell" },
		},
		window = {
			completion = cmp.config.window.bordered({
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			}),
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			}),
		},
	})

	--  -- Completion for search and command line
	--  cmp.setup.cmdline({ "/", "?" }, {
	--    mapping = cmp.mapping.preset.cmdline(),
	--    sources = {
	--      { name = "buffer" },
	--    },
	--  })
	--  cmp.setup.cmdline(":", {
	--    mapping = cmp.mapping.preset.cmdline(),
	--    sources = cmp.config.sources({
	--      { name = "path" },
	--    }, {
	--      { name = "cmdline" },
	--    }),
	--  })

	--  -- Separate settings for writing

	--  local writing_sources = {
	--    { name = "luasnip" },
	--    { name = "buffer" },
	--    { name = "spell" },
	--    { name = "emoji" },
	--    { name = "latex_symbols" },
	--  }
	--
	--  local writing_filetypes = {
	--    "markdown",
	--    "org",
	--    "neorg",
	--    "latex",
	--    "html",
	--  }
	--
	--  for _, t in pairs(writing_filetypes) do
	--    cmp.setup.filetype(t, {
	--      sources = cmp.config.sources(writing_sources),
	--    })
	--  end
end

config()
