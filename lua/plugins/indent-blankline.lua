vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1a1b26 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#16161e gui=nocombine]]

require('indent_blankline').setup {
  -- show_current_context = true,
  -- show_current_context_start = true,
  char = '',
  char_highlight_list = {
    'IndentBlanklineIndent1',
    'IndentBlanklineIndent2',
  },
  space_char_highlight_list = {
    'IndentBlanklineIndent1',
    'IndentBlanklineIndent2',
  },
  show_trailing_blankline_indent = false,
}
