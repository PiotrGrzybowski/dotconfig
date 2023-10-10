local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed
vim.cmd [[packadd packer.nvim]]
-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end


return require('packer').startup(function()
  use('wbthomason/packer.nvim')
  use("gruvbox-community/gruvbox")
  use('shaunsingh/nord.nvim')
  use('folke/tokyonight.nvim')
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  
  use("nvim-telescope/telescope.nvim")
  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
  use({'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }})
  use("onsails/lspkind-nvim")

  use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
          require("trouble").setup {
              icons = false,
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
          }
      end
  })  

  use("christoomey/vim-tmux-navigator")
  use("theprimeagen/harpoon")
  use("theprimeagen/refactoring.nvim")
  use {
	  'VonHeikemen/lsp-zero.nvim', branch = 'v1.x', requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }
  use({
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
          require("null-ls").setup()
      end,
      requires = { "nvim-lua/plenary.nvim" },
  })  
  use("jay-babu/mason-null-ls.nvim")

  use("github/copilot.vim")
  use("lervag/vimtex")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("numToStr/Comment.nvim")
  use("rust-lang/rust.vim", { ft = "rust" })

  use("mfussenegger/nvim-dap")

  use({"mfussenegger/nvim-dap-python", ft = "python", 
      requires = {
          {"mfussenegger/nvim-dap"}, 
          {"rcarriga/nvim-dap-ui"}
      }, 
      config = function()
        require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/bin/venv/python")
      end
  })

  use({"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"},
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

  end})
  if packer_bootstrap then
    require('packer').sync()
  end

end)
