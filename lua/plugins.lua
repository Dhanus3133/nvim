require('pconfig.packer')
-- Using a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer") if not status_ok then
  return
end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use "hrsh7th/cmp-nvim-lsp"
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'williamboman/nvim-lsp-installer'
  use 'onsails/lspkind-nvim'
  use 'nvim-lua/lsp-status.nvim' -- LuaLine
  use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'


  -- Theme
  use 'norcalli/nvim-colorizer.lua'
  use 'marko-cerovac/material.nvim'

  -- Syntax
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/nvim-treesitter-context'

  --Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }

  -- Discord Rich Presence
  use 'andweeb/presence.nvim'
  
  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
  requires = {
    'kyazdani42/nvim-web-devicons', -- optional, for file icons
  },
  tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- Comment
  use {
    'numToStr/Comment.nvim',
  }

  -- Formatting
  use 'sbdchd/neoformat'

  -- Cursorline
  use "xiyaowong/nvim-cursorword"

  -- Scrolling
  use "karb94/neoscroll.nvim"

  -- Tabline
  use {
    'akinsho/bufferline.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- LuaLine
  use {
  'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Editing Support
  use "windwp/nvim-autopairs"
  use { 'AckslD/nvim-revJ.lua', requires = {'kana/vim-textobj-user', 'sgur/vim-textobj-parameter'}, }
  use "haringsrob/nvim_context_vt"
  use "phaazon/hop.nvim"
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
  use "Pocco81/AutoSave.nvim"

  -- Indent
  use 'lukas-reineke/indent-blankline.nvim'

  -- Others
  use 'wakatime/vim-wakatime'
  use 'hrsh7th/vim-vsnip'
  use 'lewis6991/impatient.nvim'
  use {
      "michaelb/sniprun",
      run = "bash ./install.sh",
  }
  use {'turbio/bracey.vim', run = 'cd app & npm install --prefix server'}
  use 'laytan/cloak.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
