-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-lua/plenary.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
vim.keymap.set({"n"}, "<space>ff", "<cmd>lua require'telescope.builtin'.git_files{}<cr>")
vim.keymap.set({"n"}, "<space>fn", "<cmd>lua require'telescope.builtin'.git_files{cwd = '/home/sabo/.config/nvim'}<cr>")
vim.keymap.set({"n"}, "<space>fr", "<cmd>lua require'telescope.builtin'.live_grep{}<cr>")
vim.keymap.set({"n"}, "<space>fb", "<cmd>lua require'telescope.builtin'.buffers{}<cr>")

return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                },
                defaults = {mappings = mappings.telescope_keymap},
            }
            require('telescope').load_extension('fzf')
        end,

    }, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},

}
