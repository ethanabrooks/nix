-- Basic LSP Setup
local nvim_lsp = require('lspconfig')

-- Example configuration for a Python LSP server (pyright)
nvim_lsp.pyright.setup {}

-- Autocompletion setup
local cmp = require('cmp')
cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert',
        autocomplete = {require('cmp.types').cmp.TriggerEvent.TextChanged}
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        })
    }),
    sources = cmp.config.sources({{
        name = 'nvim_lsp'
    } -- Other completion sources
    })
})

vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap('i', '<C-s>', '<C-c>:w<CR>', {
    noremap = true,
    silent = true
})


vim.cmd([[colorscheme OceanicNext]])
vim.opt.swapfile = false

-- Recognize typ files
vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.typ",
    command = "set filetype=typ"
})

-- Treat a-b as a single word in .typ files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typ",
    callback = function()
        vim.opt_local.iskeyword:append("-")
    end,
})
