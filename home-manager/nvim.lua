-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 250
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.showmode = false -- lualine shows mode

-- Theme
vim.o.background = "light"
vim.cmd.colorscheme("NeoSolarized")

-- Treesitter
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
})

-- Telescope
local telescope = require("telescope")
local builtin = require("telescope.builtin")
telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/" },
  },
})
telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Grep project" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Help" })
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Search buffer" })

-- Neo-tree
require("neo-tree").setup({
  close_if_last_window = true,
  filesystem = {
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
  },
})
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File explorer" })

-- LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
})

-- LSP keybinds (only active when LSP attaches)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "gd", builtin.lsp_definitions, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "gr", builtin.lsp_references, vim.tbl_extend("force", opts, { desc = "References" }))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("n", "<leader>d", builtin.diagnostics, vim.tbl_extend("force", opts, { desc = "Diagnostics" }))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  end,
})

-- Common language servers (mason auto-installs these on first use)
local servers = { "lua_ls", "pyright", "ts_ls", "rust_analyzer" }
for _, server in ipairs(servers) do
  vim.lsp.config(server, { capabilities = capabilities })
  vim.lsp.enable(server)
end

-- Autocomplete
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Git signs
require("gitsigns").setup({
  current_line_blame = true,
})

-- Autopairs
require("nvim-autopairs").setup()

-- Comments (gcc to toggle line, gc in visual mode)
require("Comment").setup()

-- Which-key
require("which-key").setup()

-- Lualine
require("lualine").setup({
  options = {
    theme = "solarized_light",
  },
})

-- Bufferline (tabs)
require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    show_close_icon = false,
    show_buffer_close_icons = false,
  },
})
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev tab" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close tab" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
