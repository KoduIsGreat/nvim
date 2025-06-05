local M = {
  'theprimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    -- REQUIRED
    harpoon:setup()
    vim.keymap.set('n', '<leader>m', function()
      harpoon:list():add()
    end)

    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-p>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():next()
    end)

    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      local action_state = require 'telescope.actions.state'
      local actions = require 'telescope.actions'
      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          attach_mappings = function(prompt_bufnr, map)
            local function refresh()
              actions.close(prompt_bufnr)
              vim.schedule(function()
                toggle_telescope(harpoon:list())
              end)
            end

            local delete_buf = function()
              local selection = action_state.get_selected_entry()
              harpoon:list():remove_at(selection.index)
              refresh()
            end

            local delete_multiple_buf = function()
              local picker = action_state.get_current_picker(prompt_bufnr)
              local selection = picker:get_multi_selection()
              table.sort(selection, function(a, b)
                return a.index > b.index
              end)
              for _, entry in ipairs(selection) do
                harpoon:list():remove_at(entry.index)
              end
              refresh()
            end

            map('n', 'dd', delete_buf)
            map('n', '<C-d>', delete_multiple_buf)
            return true
          end,
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<C-e>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window' })
  end,
}

return M
