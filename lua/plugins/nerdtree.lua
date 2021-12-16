local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

g.NERDTreeFileExtensionHighlightFullName = 1
g.NERDTreeExactMatchHighlightFullName = 1
g.NERDTreePatternMatchHighlightFullName = 1

if fn.filereadable(require'persistence'.get_current()) == 0 then
  cmd [[autocmd VimEnter * NERDTree | wincmd p]]
end

cmd [[autocmd BufEnter * nested if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]]
