return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({
      '*', -- Highlight all files, but customize some others.
      css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
      html = { names = false }, -- Disable parsing "names" in html.
      -- Disable all other color parsing.
    }, {
      RGB = true, -- Enable RGB color parsing.
      RRGGBB = true, -- Enable RRGGBB color parsing.
      names = true, -- Enable "names" color parsing.
      RGB_fn = true, -- Enable rgb(...) function parsing.
      rgb_fn = true, -- Enable rgb(...) function parsing (lowercase).
      mode = 'background', -- Set the mode to 'background'.
    })
  end,
}
