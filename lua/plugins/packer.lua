local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'simrat39/rust-tools.nvim'
  use 'mfussenegger/nvim-dap'

  -- Utilities
  use 'liuchengxu/vista.vim'
  use 'antoinemadec/FixCursorHold.nvim'
  use 'farmergreg/vim-lastplace' -- Restore cursor position
  use 'scrooloose/nerdcommenter' -- Toggle comments
  use 'Shougo/vinarise.vim' -- HEX editor
  use 'cohama/lexima.vim'
  use 'gregsexton/MatchTag'
  use 'rbgrouleff/bclose.vim' -- Close buffer without close window
  use 'tpope/vim-eunuch' -- Vim sugar for the UNIX shell commands that need it the most.
  use 'benmills/vimux'
  use 'vimsence/vimsence' -- Discord rich presence
  use 'terryma/vim-multiple-cursors'
  use 'tpope/vim-characterize'
  use 'folke/persistence.nvim'
  use 'nvim-telescope/telescope.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run="make"}

  -- Git
  use 'airblade/vim-gitgutter' -- Show modified lines
  use 'tpope/vim-fugitive' -- Git commands and status of files
  use 'whiteinge/diffconflicts'

  -- Syntax
  use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'} -- We recommend updating the parsers on update
  use 'windwp/nvim-ts-autotag'
  use 'ARM9/snes-syntax-vim'

  -- Appearance
  use 'dracula/vim'
  use 'TaDaa/vimade'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'Yggdroot/indentLine'
  use 'ryanoasis/vim-devicons'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
