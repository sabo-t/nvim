-- https://github.com/L3MON4D3/LuaSnip
-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/saadparwaiz1/cmp_luasnip
-- https://github.com/onsails/lspkind.nvim
vim.g.completeopt = 'menu,menuone,noselect'
vim.cmd([[
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4]])

return {
    {
        'L3MON4D3/LuaSnip',
        config = function()
            require"luasnip".config.setup({
                history = false,
                updateevents = "TextChanged,TextChangedI",
                delete_check_events = 'TextChanged, InsertLeave, TextChangedI',
                enable_autosnippets = true,
                region_check_events = 'CursorMoved'
            })
        end
    }, {
        'hrsh7th/nvim-cmp',
        config = function()
            local lspkind = require('lspkind')
            local cmp = require('cmp')
            cmp.setup({
                -- enabled = function()
                --     -- disable completion in comments
                --     local context = require 'cmp.config.context'
                --     -- keep command mode completion enabled when cursor is in a comment
                --     if vim.api.nvim_get_mode().mode == 'c' then
                --         return true
                --     else
                --         return not context.in_treesitter_capture("string")
                --             and not context.in_syntax_group("String")
                --             and not context.in_treesitter_capture("comment")
                --             and not context.in_syntax_group("Comment")
                --     end
                -- end,
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                sources = {
                    {name = 'nvim_lsp'}, {name = 'luasnip'}, -- For luasnip users.
                    {name = 'nvim_lua'}, {name = 'path'},
                    {
                        name = 'buffer',
                        keyword_length = 2,
                        option = {keyword_pattern = [[\k\+]]}
                    }
                },

                experimental = {ghost_text = true, native_menu = false},
                -- formatting = {
                --     format = function(_, vim_item)
                --         vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
                --         return vim_item
                --     end,
                -- },
                formatting = {
                    format = lspkind.cmp_format {
                        with_text = true,
                        menu = {
                            buffer = "[buf]",
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[api]",
                            path = "[path]",
                            luasnip = "[snip]",
                            gh_issues = "[issues]"
                        }
                    }
                },

                mapping = mappings.cmp_keymap
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    {name = 'cmp_git'} -- You can specify the `cmp_git` source if you were installed it.
                }, {{name = 'buffer'}})
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {{name = 'buffer'}}
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({{name = 'path'}},
                                             {{name = 'cmdline'}})
            })

        end,
        requires = {
            "onsails/lspkind.nvim", 'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline'
        }
    }, {'saadparwaiz1/cmp_luasnip'}

}
