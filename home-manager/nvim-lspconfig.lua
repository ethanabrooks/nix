-- Define some helpers for auto-formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name ~= "pyright"
		end,
		bufnr = bufnr,
	})
end
-- Trigger autoformatting on save for supported LSPs
local function on_attach(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

local config = function()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local lspconfig = require("lspconfig")

	-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
	local servers = {
		"rnix",
		"jsonls",
		"texlab",
		"dockerls",
		"html",
		"cssls",
		"eslint",
	}
	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			python = { analysis = { autoImportCompletions = false } }
		}
	})

	lspconfig.lua_ls.setup {
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = { enable = false },
				format = {
					enable = true,
					defaultConfig = {
						indent_style = "space",
						indent_size = "2",
					}
				}
			},
		},
	}


	vim.g.markdown_fenced_languages = { "ts=typescript" }

	-- Styling
	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end
end

local null_ls_config = function()
	local null_ls = require("null-ls")

	null_ls.setup({
		on_attach = on_attach,
		sources = {
			-- --shell
			-- null_ls.builtins.diagnostics.shellcheck,
			-- null_ls.builtins.code_actions.shellcheck,
			-- null_ls.builtins.formatting.shfmt,

			-- python
			null_ls.builtins.formatting.black,
			-- -- null_ls.builtins.formatting.ruff,
			-- -- null_ls.builtins.diagnostics.ruff,

			-- -- nix
			null_ls.builtins.formatting.alejandra,
			-- null_ls.builtins.diagnostics.statix,
			-- null_ls.builtins.code_actions.statix,

			-- -- rust
			-- null_ls.builtins.formatting.rustfmt,

			-- -- web
			-- null_ls.builtins.formatting.prettier.with({
			--   filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
			-- }),
		},
	})
end

config()
null_ls_config()
