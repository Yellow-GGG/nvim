vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true

vim.lsp.set_log_level("off")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
--    {
--        "iamcco/markdown-preview.nvim",
--        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--        ft = { "markdown" },
--        build = function() vim.fn["mkdp#util#install"]() end,
--    },
    {'folke/tokyonight.nvim', lazy=false, priority=1000,
    config = function() vim.cmd([[colorscheme tokyonight-moon]]) end,},
    --'sainnhe/everforest'
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            local lualine_require = require("lualine_require")
            lualine_require.require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename', 'aerial'},
                    lualine_x = {'encoding', 'filetype', 'selectioncount'},
                    lualine_y = {'progress', 'filesize'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            })
        end
    },
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'romgrk/barbar.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-nvim-lua',
    {'kaarmu/typst.vim', ft='typst'},
    {'habamax/vim-godot', ft='gdscript, gsl'},
    -- {'williamboman/mason.nvim', config=function() require("mason").setup() end},
--    {'williamboman/mason-lspconfig.nvim',
--      config = function()require("mason-lspconfig").setup() end},
    'mfussenegger/nvim-dap',
    'neovim/nvim-lspconfig',
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    {
        'stevearc/aerial.nvim',
        on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
        opts = {
            backends = {'treesitter'},
            autojump = true
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
    {
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
        },

        -- see details below for full configuration options
        opts = {
            lsp = {
                on_attach = on_attach,
            },
            mappings = true,
        }
    },
	{
    'MeanderingProgrammer/markdown.nvim',
    main = "render-markdown",
    opts = {},
	name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
	ft = "markdown",
	}
})

require('lsp')
require('dapconfig')
require('config')

if vim.g.neovide then
    require('neovide')
end
