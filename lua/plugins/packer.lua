local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'nvim-lua/plenary.nvim' }

  -- LSP
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'simrat39/rust-tools.nvim' }
  use { 'mfussenegger/nvim-dap' }
  use { 'theHamsta/nvim-dap-virtual-text' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'akinsho/flutter-tools.nvim' }

  -- Utilities
  use { 'liuchengxu/vista.vim' }
  use { 'antoinemadec/FixCursorHold.nvim' }
  use { 'farmergreg/vim-lastplace' } -- Restore cursor position
  use { 'numToStr/Comment.nvim' }
  use { 'Shougo/vinarise.vim' } -- HEX editor
  use { 'cohama/lexima.vim' }
  use { 'gregsexton/MatchTag' }
  use { 'tpope/vim-eunuch' } -- Vim sugar for the UNIX shell commands that need it the most.
  use { 'benmills/vimux' }
  use { 'vimsence/vimsence' } -- Discord rich presence
  use { 'terryma/vim-multiple-cursors' }
  use { 'tpope/vim-characterize' }
  use { 'folke/persistence.nvim' }
  use { 'qpkorr/vim-bufkill' }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'nvim-telescope/telescope-dap.nvim' }

  -- Git
  use { 'airblade/vim-gitgutter' } -- Show modified lines
  use { 'tpope/vim-fugitive' } -- Git commands and status of files
  use { 'whiteinge/diffconflicts' }

  -- Syntax
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'windwp/nvim-ts-autotag' }
  use { 'ARM9/snes-syntax-vim' }
  use { 'RRethy/vim-hexokinase', run = 'make hexokinase' }

  -- Appearance
  use { 'folke/tokyonight.nvim' }
  use { 'TaDaa/vimade' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'lukas-reineke/indent-blankline.nvim' }
  use { 'romgrk/barbar.nvim' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
