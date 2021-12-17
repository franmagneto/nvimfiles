local g = vim.g
local cmd = vim.cmd

g.NERDTreeFileExtensionHighlightFullName = 1
g.NERDTreeExactMatchHighlightFullName = 1
g.NERDTreePatternMatchHighlightFullName = 1

cmd [[autocmd VimEnter * NERDTree | wincmd p]]

-- Close Neovim if NERDTree is the last buffer
cmd [[autocmd QuitPre * if winnr('$') == 2 && getbufvar(winbufnr(1), "&filetype") == "nerdtree" | NERDTreeClose | endif]]

-- Prevent other buffers to open on NERDTree window
cmd [[
  autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
]]
