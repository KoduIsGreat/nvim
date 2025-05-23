local function root_pattern_exclude(opt)
  local lsputil = require 'lspconfig.util'

  return function(fname)
    local excluded_root = lsputil.root_pattern(opt.exclude)(fname)
    local included_root = lsputil.root_pattern(opt.root)(fname)

    if excluded_root then
      return nil
    else
      return included_root
    end
  end
end

local M = {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    require('typescript-tools').setup {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
      },
      settings = {
        capabilities = capabilities,
        root_dir = root_pattern_exclude {
          root = { 'package.json' },
          exclude = { 'deno.json', 'deno.jsonc' },
        },
        single_file_support = false,
        tsserver_plugins = {
          '@vue/typescript-plugin',
        },
      },
    }
  end,
}
return M
