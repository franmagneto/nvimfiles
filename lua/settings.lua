local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

-- Highlight the 80th column
opt.colorcolumn = '80'

-- Set indent to 2 spaces, not expanded, but let plugins to override it
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
cmd [[autocmd filetype make setlocal noexpandtab]]

-- Commands
cmd [[command! W :execute ':silent w !sudo tee "%" > /dev/null' | :edit!]]

-- Misc
opt.hidden = true
opt.cul = true
opt.number = true
opt.ic = true
opt.scs = true
opt.tc = 'followscs'
opt.swapfile = false
opt.linebreak = true
opt.list = false
opt.splitbelow = true
opt.mouse = 'a'
opt.backupcopy = 'yes'
opt.updatetime = 300
opt.shortmess:append {c = true}
opt.signcolumn = 'yes'
g.tex_flavor = "latex"

-- Terminal settings (no line numbers; start in Terminal-mode)
cmd [[autocmd TermOpen * setlocal nonumber norelativenumber | startinsert]]

-- Theme
opt.termguicolors = true
g.tokyonight_style = "night"
cmd [[colorscheme tokyonight]]
