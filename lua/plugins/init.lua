require'plugins.packer'
require'plugins.lsp-config'
require'plugins.cmp'
require'plugins.treesitter'
require'plugins.persistence'
require'plugins.nerdtree'
require'plugins.telescope'
require'plugins.dap'

local g = vim.g
local cmd = vim.cmd

-- Plugins configurations

-- Colorscheme
cmd [[colorscheme tokyonight]]

-- Simple setups
require'Comment'.setup()
require'lualine'.setup()
require'rust-tools'.setup()
cmd [[autocmd BufNewFile,BufRead *.{ASM,INC,asm,inc} set filetype=snes_bass]]
g.vimade = { enabletreesitter = 1 }

-- Vimsence
g.vimsence_small_text = 'NeoVim'
g.vimsence_small_image = 'neovim'

-- Vimux
g.VimuxOrientation = 'h'
g.VimuxHeight = 30

-- Vista
g.vista_default_executive = 'nvim_lsp'
g.vista_disable_statusline = 1
g.vista_echo_cursor_strategy = 'floating_win'
g.vista_close_on_jump = 1
