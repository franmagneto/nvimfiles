local g = vim.g
local cmd = vim.cmd

require('nvim-tree').setup {
  open_on_setup = true,
  auto_close = true,
  hijack_cursor = true,
  filters = {
    custom = {'.git'},
  },
  view = {
    auto_resize = true,
    side = 'left',
    width = 30,
  },
}
