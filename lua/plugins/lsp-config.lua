-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-LeftMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)

end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'rust_analyzer', 'pyright', 'tsserver', 'jdtls', 'sumneko_lua', 'vimls', 'ltex' }

require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local flags = {
  debounce_text_changes = 150,
}

local lspconfig = require('lspconfig')
for _, name in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
  }
  if name == 'sumneko_lua' then
    opts.settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        telemetry = { enable = false },
      }
    }
  end
  lspconfig[name].setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end

-- Standalone servers

local null_ls = require('null-ls')
null_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettier,
  },
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}
