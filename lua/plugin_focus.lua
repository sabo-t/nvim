-- https://github.com/nvim-focus/focus.nvim
return {
    'beauwilliams/focus.nvim',
    config = function()
      require("focus").setup({
          minwidth=30,
          number=false,
          cursorline = false,
          winhighlight = false,
          width = 80
      })
    end
}
