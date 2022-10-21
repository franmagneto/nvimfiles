local persistence = require('persistence')

persistence.setup()

if vim.fn.filereadable(persistence.get_current()) ~= 0 then
  vim.cmd [[autocmd VimEnter * nested lua require'persistence'.load()]]
else
  persistence.stop()
end
