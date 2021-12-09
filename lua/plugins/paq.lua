local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require 'paq' {
  'savq/paq-nvim';
  'nvim-lua/plenary.nvim';

  -- LSP
  'neovim/nvim-lspconfig';
  'williamboman/nvim-lsp-installer';
  'hrsh7th/nvim-cmp';
  'hrsh7th/cmp-nvim-lsp';
  'saadparwaiz1/cmp_luasnip';
  'L3MON4D3/LuaSnip';
  'simrat39/rust-tools.nvim';
  'mfussenegger/nvim-dap';

  -- Utilities
  'liuchengxu/vista.vim';
  'antoinemadec/FixCursorHold.nvim';
  'farmergreg/vim-lastplace'; -- Restore cursor position
  'ctrlpvim/ctrlp.vim'; -- Search files, mru, etc
  'scrooloose/nerdcommenter'; -- Toggle comments
  'Shougo/vinarise.vim'; -- HEX editor
  'cohama/lexima.vim';
  'gregsexton/MatchTag';
  'rbgrouleff/bclose.vim'; -- Close buffer without close window
  'tpope/vim-eunuch'; -- Vim sugar for the UNIX shell commands that need it the most.
  'benmills/vimux';
  'vimsence/vimsence'; -- Discord rich presence
  'terryma/vim-multiple-cursors';
  'tpope/vim-characterize';

  -- Git
  'airblade/vim-gitgutter'; -- Show modified lines
  'tpope/vim-fugitive'; -- Git commands and status of files
  'whiteinge/diffconflicts';

  -- Syntax
  {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}; -- We recommend updating the parsers on update
  'windwp/nvim-ts-autotag';
  'ARM9/snes-syntax-vim';

  -- Appearance
  {'dracula/vim', as='dracula'};
  'TaDaa/vimade';
  'nvim-lualine/lualine.nvim';
  'kyazdani42/nvim-web-devicons';
  'kyazdani42/nvim-tree.lua';
  'Yggdroot/indentLine';
  'ryanoasis/vim-devicons';
}
