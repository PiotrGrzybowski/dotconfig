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
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope.nvim', tag = '0.1.2', dependencies = { 'nvim-lua/plenary.nvim' } },
    "folke/tokyonight.nvim",
    "github/copilot.vim",
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    "theprimeagen/harpoon",
    "numToStr/Comment.nvim",
    "tpope/vim-fugitive",
    "lervag/vimtex",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
    { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }},
    "nvim-telescope/telescope-media-files.nvim",
    { 'kristijanhusak/vim-dadbod-ui',
      dependencies = { 
          { 'tpope/vim-dadbod', lazy = true },
          { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
      },
      cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
      },
      init = function()
        vim.g.db_ui_use_nerd_fonts = 1
      end,
    }
})
