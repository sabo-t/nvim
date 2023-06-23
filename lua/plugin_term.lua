-- https://github.com/akinsho/toggleterm.nvim
return {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
        require("toggleterm").setup {
            persist_mode = false,
            start_in_insert = true
        }
    end
}
