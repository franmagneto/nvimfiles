require'nvim-tree'.setup {
  auto_close = true,
  filters = {
    custom = { '.git' },
  },
  view = {
    auto_resize = true,
    side = 'left',
    width = 30,
  },
}
