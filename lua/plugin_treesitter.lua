return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require"nvim-treesitter.configs".setup {
                -- A list of parser names, or "all"
                ensure_installed = {
                    "c", "lua", "rust", "python", "latex", "haskell", "perl", "query"
                },
                -- ignore_install = { "javascript" },
                sync_install = false, -- install everything in sync
                auto_install = true,
                indent = {enable = false}, -- foldmethod = expr
                highlight = {
                    enable = true, -- disables plugin
                    disable = {},
                    additional_vim_regex_highlighting = false -- May cause lag -- also doesnt work with catpuccin
                },
                matchup = {
                    enable = true,
                    disable = {}
                    -- [options]
                },
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?'
                    }
                },
                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = {"BufWrite", "CursorHold"}
                },
                refactor = {
                    highlight_definitions = {
                        enable = true,
                        -- Set to false if you have an `updatetime` of ~100.
                        clear_on_cursor_move = true
                    },
                    -- highlight_current_scope = {enable = true},
                    smart_rename = {
                        enable = true,
                        keymaps = {smart_rename = "grr"}
                    }

                }
            }
        end,
        run = ":TSUpdate"

    }, {"nvim-treesitter/playground"},
    {'nvim-treesitter/nvim-treesitter-refactor'},
    {'nvim-treesitter/nvim-treesitter-textobjects'}, {
        'nvim-treesitter/nvim-treesitter-context',
        config = function() require'treesitter-context'.setup {} end
    }, {"elkowar/yuck.vim"}
}
