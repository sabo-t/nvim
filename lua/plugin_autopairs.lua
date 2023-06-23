-- https://github.com/windwp/nvim-autopairs
return {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup({check_ts = true}) end
}
