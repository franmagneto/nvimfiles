require('plugins.packer')
require('plugins.dap')
require('plugins.lsp-config')
require('plugins.cmp')
require('plugins.treesitter')
require('plugins.persistence')
require('plugins.nvim-tree')
require('plugins.telescope')
require('plugins.indent-blankline')
require('plugins.flutter-tools')

local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

-- Plugins configurations

-- Colorscheme
opt.termguicolors = true
cmd [[colorscheme tokyonight-night]]

-- Simple setups
require('Comment').setup()
require('rust-tools').setup()
cmd [[autocmd BufNewFile,BufRead *.{ASM,INC,asm,inc} set filetype=snes_bass]]
g.vimade = { enabletreesitter = 1 }

-- Vimsence
g.vimsence_small_text = 'NeoVim'
g.vimsence_small_image = 'neovim'

-- Vista
g.vista_default_executive = 'nvim_lsp'
g.vista_disable_statusline = 1
g.vista_echo_cursor_strategy = 'floating_win'
g.vista_close_on_jump = 1

-- Lualine
require('lualine').setup {
  sections = {
    lualine_c = { { 'filename', path = 1 } },
  },
}
