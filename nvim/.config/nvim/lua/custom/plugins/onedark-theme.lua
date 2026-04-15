return {
  {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        transparent = true,
        style = 'darker',
        lualine = {
          transparent = true,
        },
      }
      -- Enable theme
      require('onedark').load()
    end,
  },
}
