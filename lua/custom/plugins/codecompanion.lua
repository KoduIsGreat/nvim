return {
  'olimorris/codecompanion.nvim',
  opts = {
    strategies = {
      chat = {
        adapter = {
          name = 'anthropic',
          model = 'claude-sonnet-4-20250514',
        },
        slash_commands = {
          ['file'] = {
            callback = 'strategies.chat.slash_commands.file',
            description = 'select a file using telescope',
            opts = {
              provider = 'telescope',
              contains_code = 'true',
            },
          },
        },
      },
      inline = {
        adapter = 'copilot',
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local cc = require 'codecompanion'
    require('codecompanion').setup {
      display = {
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = 'vertical', -- vertical|horizontal split for default provider
          opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
          provider = 'default', -- default|mini_diff
        },
        action_palette = {
          width = 95,
          height = 10,
          prompt = 'Prompt ', -- Prompt used for interactive LLM calls
          provider = 'telescope', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
      },
    }
    vim.keymap.set('n', '<leader>aa', '<Cmd>CodeCompanionChat<CR>')
    vim.keymap.set('n', '<leader>ca', '<Cmd>CodeCompanionActions<CR>')
  end,
}
