require'nvim-tree'.setup {
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  open_on_setup_file = true,
  focus_empty_on_setup = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  }
}

vim.cmd [[autocmd QuitPre * if winnr('$') == 2 && getbufvar(winbufnr(1), "&filetype") == "NvimTree" | NvimTreeClose | endif]]
