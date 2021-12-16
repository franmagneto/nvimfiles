local persistence = require'persistence'

persistence.setup()

if (persistence.get_last() == nil) then
  persistence.stop()
else
  vim.cmd [[autocmd VimEnter * nested lua require'persistence'.load()]]
end
