-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/lervag/vimtex
-- https://github.com/simrat39/rust-tools.nvim
-- https://github.com/p00f/clangd_extensions.nvim
-- https://github.com/SmiteshP/nvim-navic
vim.diagnostic.config({virtual_text = true, update_in_insert = true})

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
        -- Use a sharp border with `FloatBorder` highlights
        border = "single",
        -- add the title in hover float window
        title = "hover"
        -- width = 200,
        -- height = 10,
    })

return {
    {
        "folke/neodev.nvim",
        opts = {},
        config = function()
            require("neodev").setup({
                -- add any options here, or leave empty to use the default settings
            })
        end
    }, {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.jsonls.setup {}
            lspconfig.jdtls.setup {}
            lspconfig.perlls.setup {}
            lspconfig.bashls.setup {}
            lspconfig.clangd.setup {}
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        runtime = {
                            format = {
                                enable = true,
                                -- Put format options here
                                -- NOTE: the value should be STRING!!
                                defaultConfig = {
                                    indent_style = "space",
                                    indent_size = "4"
                                }
                            },
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT"
                        },
                        hint = {enable = true},
                        completion = {callSnippet = "Replace"},
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {"vim"},
                            disable = {"lowercase-global"}
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true)
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {enable = false}
                    }
                }
            }

            lspconfig.hls.setup {
                settings = {haskell = {formattingProvider = "brittany"}}
            }
            -- lspconfig.jedi_language_server.setup {}
            lspconfig.pyright.setup {}
            lspconfig.rust_analyzer.setup {
                -- Server-specific settings. See `:help lspconfig-setup`
                settings = {['rust-analyzer'] = {}}
            }

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    local opts = {buffer = ev.buf}

                    vim.keymap.set('n', '<space>N', vim.diagnostic.goto_prev)
                    vim.keymap.set('n', '<space>n', vim.diagnostic.goto_next)
                    -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
                    vim.keymap.set("n", "?", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "<space>k", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<space>wa",
                                   vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set("n", "<space>wr",
                                   vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set("n", "<space>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)

                    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition,
                                   opts)
                    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action,
                                   opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<space>rk", function()
                        vim.lsp.buf.format {async = true}
                    end, opts)
                end
            })
        end
    }, {
        "lervag/vimtex",
        config = function()
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_view_method = "sioyek"
            vim.g.vimtex_quickfix_mode = 0
            vim.opt.conceallevel = 1
            vim.g.tex_conceal = "abdmg"
        end

    }, {

        "simrat39/rust-tools.nvim",
        config = function()

            local rt = require("rust-tools")
            rt.setup({
                tools = {
                    inlay_hints = {
                        -- automatically set inlay hints (type hints)
                        -- default: true
                        auto = false,

                        -- Only show inlay hints for the current line
                        only_current_line = false,

                        -- whether to show parameter hints with the inlay hints or not
                        -- default: true
                        show_parameter_hints = true,

                        -- prefix for parameter hints
                        -- default: "<-"
                        parameter_hints_prefix = "<- ",

                        -- prefix for all the other hints (type, chaining)
                        -- default: "=>"
                        other_hints_prefix = "=> ",

                        -- whether to align to the length of the longest line in the file
                        max_len_align = true,

                        -- padding from the left if max_len_align is true
                        max_len_align_padding = 1,

                        -- whether to align to the extreme right or not
                        right_align = false,

                        -- padding from the right if right_align is true
                        right_align_padding = 5,

                        -- The color of the hints
                        highlight = "Comment"
                    }

                },
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>",
                                       rt.hover_actions.hover_actions,
                                       {buffer = bufnr})
                        -- Code action groups
                        vim.keymap.set("n", "<Leader>a",
                                       rt.code_action_group.code_action_group,
                                       {buffer = bufnr})
                    end
                }

            })
        end
    }, {
        "p00f/clangd_extensions.nvim",
        config = function()

            extensions = {
                -- defaults:
                -- Automatically set inlay hints (type hints)
                autoSetHints = true,
                -- These apply to the default ClangdSetInlayHints command
                inlay_hints = {
                    -- Only show inlay hints for the current line
                    only_current_line = false,
                    -- Event which triggers a refersh of the inlay hints.
                    -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
                    -- not that this may cause  higher CPU usage.
                    -- This option is only respected when only_current_line and
                    -- autoSetHints both are true.
                    only_current_line_autocmd = "CursorHold",
                    -- whether to show parameter hints with the inlay hints or not
                    show_parameter_hints = true,
                    -- prefix for parameter hints
                    parameter_hints_prefix = " <- ",
                    -- prefix for all the other hints (type, chaining)
                    other_hints_prefix = "=> ",
                    -- whether to align to the length of the longest line in the file
                    max_len_align = false,
                    -- padding from the left if max_len_align is true
                    max_len_align_padding = 1,
                    -- whether to align to the extreme right or not
                    right_align = false,
                    -- padding from the right if right_align is true
                    right_align_padding = 7,
                    -- The color of the hints
                    highlight = "Comment",
                    -- The highlight group priority for extmark
                    priority = 100
                },
                ast = {
                    role_icons = {
                        type = "",
                        declaration = "",
                        expression = "",
                        specifier = "",
                        statement = "",
                        ["template argument"] = ""
                    },
                    kind_icons = {
                        Compound = "",
                        Recovery = "",
                        TranslationUnit = "",
                        PackExpansion = "",
                        TemplateTypeParm = "",
                        TemplateTemplateParm = "",
                        TemplateParamObject = ""
                    },
                    highlights = {detail = "Comment"}
                },
                memory_usage = {border = "none"},
                symbol_info = {border = "none"}
            }
        end

    }
}
