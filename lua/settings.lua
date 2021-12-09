local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local fn = vim.fn
local bo = vim.bo
-- Highlight the 80th column
opt.colorcolumn = '80'

-- Set indent to 2 spaces, not expanded, but let plugins to override it
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
cmd [[autocmd filetype make setlocal noexpandtab]]
-- filetype plugin indent on

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
cmd [[colorscheme dracula]]

g.vimsence_small_text = 'NeoVim'
g.vimsence_small_image = 'neovim'

-- Vista
g.vista_default_executive = 'nvim_lsp'
g.vista_disable_statusline = 1
g.vista_echo_cursor_strategy = 'floating_win'
g.vista_close_on_jump = 1

-- CtrlP
-- opt.wildignore:append '*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store' -- MacOSX/Linux

-- Use ripgrep with CtrlP
if fn.executable('rg') then
  opt.grepprg = 'rg --vimgrep'
  g.ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  g.ctrlp_use_caching = 0
end

-- gitgutter
g.gitgutter_max_signs = 1000

-- nerdcommenter
g.NERDSpaceDelims = 1

-- Vimux
g.VimuxOrientation = 'h'
g.VimuxHeight = 30

-- Syntax
cmd [[autocmd BufNewFile,BufRead *.{ASM,INC,asm,inc} set filetype=snes_bass]]
