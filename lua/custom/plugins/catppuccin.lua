return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function(self, opts)
    require('catppuccin').setup {
      flavour = 'mocha',
    }
  end,
}
