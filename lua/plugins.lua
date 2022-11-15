return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'andymass/vim-matchup' -- extended matching with %
  use 'simrat39/symbols-outline.nvim' -- symbols view
  -- better folds
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
  use "max397574/better-escape.nvim" -- faster jj / kshadowk
  use 'williamboman/mason-lspconfig.nvim' -- manage LSP binaries
  use 'overcache/NeoSolarized'
  use { 'kyazdani42/nvim-tree.lua', -- Filesystem navigation
    requires = 'kyazdani42/nvim-web-devicons' } -- Filesystem icons
  use { 'nvim-lualine/lualine.nvim', -- Statusline
    requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use {
    "windwp/nvim-autopairs", -- Autocomplete (), {}, []
    config = function() require("nvim-autopairs").setup {} end
  }
  use 'lewis6991/impatient.nvim' -- Makes neovim faster
  use 'tpope/vim-surround'
  use { 'phaazon/hop.nvim', branch = 'v2' } -- Navitage to any word in the file
  use 'onsails/lspkind.nvim' -- shows icons in cmp
  use 'j-hui/fidget.nvim' -- sho status of nvim-lsp progress
  use 'L3MON4D3/LuaSnip' -- snippets for completion
  use 'saadparwaiz1/cmp_luasnip' -- snippets for completion'
  use 'RRethy/vim-illuminate' -- Highlight other uses of word under cursor
  use "lukas-reineke/indent-blankline.nvim" -- ident lines
  use 'numToStr/Comment.nvim' -- Enable comments
  use 'folke/trouble.nvim' -- Summarizes issues
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- Make telescope faster
  use 'nvim-telescope/telescope.nvim' -- Fuzzy finder
  use 'BurntSushi/ripgrep' -- Telescope grep
  use 'sharkdp/fd' -- Finder
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp' -- Completion framework
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp' -- LSP completion source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip' -- Snippet completion source for nvim-cmp
  use 'hrsh7th/cmp-path' -- Useful completion sources
  use 'hrsh7th/cmp-buffer' -- Useful completion sources
  use 'simrat39/rust-tools.nvim' -- rust-analyzer hints and more!
  use 'saecki/crates.nvim' -- Help managing crates dependencies
  use 'hrsh7th/vim-vsnip' -- Snippet engine
  use 'nvim-lua/popup.nvim' -- Poup for telescope
  use 'nvim-treesitter/nvim-treesitter' -- better syntax
  use 'm-demare/hlargs.nvim' -- Highlight argument definitions and usages
  use 'nvim-lua/plenary.nvim' -- Collection of Lua functions
  use 'williamboman/mason.nvim' -- Manage LSPs and DAPs
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use { 'theHamsta/nvim-dap-virtual-text' }
  use 'christoomey/vim-tmux-navigator'
  use 'hrsh7th/cmp-cmdline'
  use 'nvim-pack/nvim-spectre'
  use "rafamadriz/friendly-snippets"

  use { 'neoclide/coc.nvim', branch = 'release' }
end)
