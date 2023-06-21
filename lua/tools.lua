-- fzf.vim
-- vim.cmd(
--     [[
-- let $FZF_DEFAULT_OPTS='--bind=ctrl-l:up,ctrl-k:down'
--     " global in tab
-- 	command! -bang -nargs=? -complete=dir MyFiles
--     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline', '--keep-right', '--ansi', '--color=bw']}), <bang>0)
--
-- command! -bang -bar -nargs=? -complete=dir Cd
--     \ call fzf#run(fzf#wrap(
--     \ {'source': 'find '.( empty("<args>") ? ( <bang>0 ? "~" : "." ) : "<args>" ) .' -type d',
--     \ 'sink': 'cd'}))
-- ]]
-- )
-- require"lightspeed".setup {
--     jump_to_unique_chars = false,
--     repeat_ft_with_target_char = true,
--     force_beacons_into_atch_width = false,
--     ignore_case = false,
--     safe_labels = {
--         "s",
--         "f",
--         "n",
--         "S",
--         "F",
--         "N",
--         "!",
--         '"',
--         "#",
--         "%",
--     },
-- }
local 
    leap =
    require(
        'leap')
leap.opts
    .case_sensitive =
    false
leap.opts
    .substitute_chars =
    {
        ['\r'] = '¬',
    }
leap.opts
    .special_keys
    .prev_target =
    {
        '<s-enter>',
        ',',
    }

leap.opts
    .labels =
    {
        "s",
        "f",
        "n",
        "j",
        "k",
        "l",
        "h",
        "o",
        "d",
        "w",
        "e",
        "m",
        "b",
        "u",
        "y",
        "v",
        "r",
        "g",
        "t",
        "c",
        "x",
        "\"",
        "&",
        "!",
        "&",
        "N",
        "F",
        "J",
        "K",
        "L",
        "H",
        "O",
        "D",
        "W",
        "E",
        "M",
        "B",
        "U",
        "Y",
        "V",
        "R",
        "G",
        "T",
        "C",
        "X",
        "?",
        "Z",
    }
vim.api
    .nvim_set_hl(
    0,
    'LeapBackdrop',
    {
        link = 'Comment',
    }) -- or some grey
vim.api
    .nvim_set_hl(
    0,
    'LeapMatch',
    {
        -- For light themes, set to 'black' or similar.
        fg = 'white',
        bold = true,
        nocombine = true,
    })
-- Of course, specify some nicer shades instead of the default "red" and "blue".
vim.api
    .nvim_set_hl(
    0,
    'LeapLabelPrimary',
    {
        fg = '#fd350d',
        bold = true,
        nocombine = true,
    })
vim.api
    .nvim_set_hl(
    0,
    'LeapLabelSecondary',
    {
        fg = '#fd6753',
        bold = true,
        nocombine = true,
    })

require"marks".setup {
    -- whether to map keybinds or not. default true
    default_mappings = false,
    -- which builtin marks to show. default {}
    builtin_marks = {
        ".",
        "<",
        ">",
        "^",
    },
    -- whether movements cycle back to the beginning/end of buffer. default true
    cyclic = true,
    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = false,
    -- how often (in ms) to redraw signs/recompute mark positions.
    -- higher values will have better performance but may cause visual lag,
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 250,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = {
        lower = 10,
        upper = 15,
        builtin = 8,
        bookmark = 20,
    },
    -- disables mark tracking for specific filetypes. default {}
    excluded_filetypes = {},
    -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
    -- sign/virttext. Bookmarks can be used to group together positions and quickly move
    -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
    -- default virt_text is "".
    bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
        -- defaults to false.
        annotate = false,
    },
    mappings = {},
}

-- tagbar
-- vim.cmd([[
-- let g:tagbar_compact = 3
-- let g:tagbar_autoshowtag = 1
-- " let g:tagbar_autopreview = 1
-- let g:tagbar_wrap = 1
-- let g:tagbar_show_balloon = 1
-- ]])

-- delimitMate
-- vim.cmd([[
-- let delimitMate_expand_space = 0
-- let delimitMate_expand_cr = 1
-- let delimitMate_jump_expansion = 1
-- let delimitMate_balance_matchpairs = 1
-- let delimitMate_smart_quotes = 1
-- let delimitMate_smart_matchpairs = 1
-- " let delimitMate_excluded_regions = "Comment,String"
-- let delimitMate_excluded_regions = "Comment"
-- ]])

require(
    "nvim-autopairs").setup(
    {
        check_ts = true,
    })

-- nvim-treesitter: :TSInstall <package>
require"nvim-treesitter.configs".setup {
    -- A list of parser names, or "all"
    ensure_installed = {
        "c",
        "lua",
        "rust",
        "python",
        "latex",
        "haskell",
        "perl",
        "help",
    },
    -- ignore_install = { "javascript" },
    sync_install = false, -- install everything in sync
    auto_install = true,
    indent = {
        enable = false,
    }, -- foldmethod = expr
    highlight = {
        enable = true, -- disables plugin
        disable = {},
        additional_vim_regex_highlighting = false, -- May cause lag -- also doesnt work with catpuccin
    },
    matchup = {
        enable = true,
        disable = {},
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
            show_help = '?',
        },
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {
            "BufWrite",
            "CursorHold",
        },
    },
    refactor = {
        highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
        },
        -- highlight_current_scope = {enable = true},
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },

    },
}

--  surr*ound_words             ysiw)           (surround_words)
-- *make strings               ys$"            "make strings"
-- [delete ar*ound me!]        ds]             delete around me!
-- remove <b>HTML t*ags</b>    dst             remove HTML tags
-- 'change quot*es'            cs'"            "change quotes"
-- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
-- delete(functi*on calls)     dsf             function calls
require(
    "nvim-surround").setup(
    {})

-- treesitter - matchup
vim.g
    .loaded_matchit =
    1
vim.g
    .matchup_override_vimtex =
    1
vim.g
    .matchup_delim_noskips =
    2
vim.g
    .matchup_matchparen_offscreen =
    {
        "method",
        "popup",
    }

-- fidget
require"fidget".setup {}
-- context
require'treesitter-context'.setup {}

require(
    "windows").setup(
    {
        autowidth = { --      |windows.autowidth|
            enable = true,
            winwidth = 20, --        |windows.winwidth|
        },
        ignore = { --  |windows.ignore|
            buftype = {
                "quickfix",
            },
            filetype = {
                "NvimTree",
                "neo-tree",
                "undotree",
                "gundo",
                "aerial",
            },
        },
        animation = {
            enable = false,
        },
    })
require(
    "toggleterm").setup {
    persist_mode = false,
    start_in_insert = true,
}

local 
    alpha =
    require 'alpha'
local 
    dashboard =
    require 'alpha.themes.theta'
-- dashboard.section.buttons.val = {
--         dashboard.button("e", "  New file", "<cmd>ene <CR>"),
--         dashboard.button("<space> f f", "  ssFind file"),
--         dashboard.button("<space> f h", "  Recently opened files"),
--         dashboard.button("<space> f r", "  Frecency/MRU"),
--         dashboard.button("<space> f g", "  Find word"),
--         dashboard.button("<space> f m", "  Jump to bookmarks"),
--         dashboard.button("<space> s l", "  Open last session"),
-- }
dashboard.header
    .val =
    {
        [[⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⡿⠁⢀⣴⣶⣾⡟⠀⣰⡾⠀⠀⠀⣰⣶⡇⠀⢰⣶⡄⠀⠀⢸⣷⣦⡀⠀⠀⠀⠈⢹⣿⣿⡸⣝⠷⢭⢛]],
        [[⠀⠀⠀⠀⠀⠰⠋⢸⣿⣿⣿⡟⢀⣴⣿⣿⣿⠏⠀⣴⣿⠃⠀⠀⣰⣿⣿⢁⠀⣾⣿⣿⠀⠀⠈⣿⣿⣿⣆⠀⠀⠀⠀⠻⡿⠀⠈⠀⠉⠉]],
        [[⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡟⢠⣾⣿⣿⣿⡏⠀⣸⣿⡏⠀⠀⢈⣿⠿⠣⠾⠄⠿⠿⠿⠇⡄⠀⢸⣿⣿⣿⣧⠀⠀⠈⣆⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⣼⣿⣿⠟⠀⣿⣿⣿⣿⡟⠀⢰⣿⡿⠀⠀⢀⣤⠖⠀⣀⣤⡄⢰⣶⣶⡆⣶⡀⠀⢿⣿⣿⣿⣆⠀⠀⢹⣦⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⢰⣿⣿⠏⠀⢠⣿⣿⣿⡿⠁⠀⣿⣿⠇⠀⢀⡚⠉⣢⣾⣿⣿⣿⢸⣿⣿⢣⣏⢿⡄⢸⣿⣿⣿⣿⡀⠀⠀⣿⣇⠀⠀⠀⢀]],
        [[⠀⠀⡀⠀⠀⢼⣿⠃⠀⠀⢸⠿⠿⠛⠁⠀⢸⣿⣏⠃⢠⠟⣱⣾⣿⡿⠟⣫⣾⡆⠿⠟⠘⠉⠙⠛⠈⠛⠛⠟⠛⣃⠀⠀⢹⣿⡆⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⣿⠃⠀⠀⠀⠰⠾⠃⠀⠀⠀⣿⡟⠁⠠⢫⣾⣿⣿⣿⡇⣾⣿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⠀⠀⠸⣿⣿⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠇⠀⠀⠀⠀⠠⠆⠀⠀⠀⢀⠋⠀⢀⣴⣿⣿⣿⣿⣿⣿⡏⠁⡠⠄⢀⣤⡄⡴⠄⠰⠎⣡⣦⠻⢿⣿⠀⢂⠀⣿⣿⡇⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣶⡧⢺⣥⣴⣶⣾⣿⣿⣿⣿⠫⠁⡰⡙⡻⠀⠘⠀⢹⣿⣷⠀⠀]],
        [[⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⢀⡄⠀⠀⢀⣴⣿⣿⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢁⣠⣶⣿⡽⡄⠀⠀⠀⢸⣿⣿⡂⠀]],
        [[⠀⠀⠀⠀⠀⡼⠀⠀⠀⠀⠈⠀⠀⠀⠀⢈⣿⣿⢇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣶⣿⡿⠟⠁⠠⢩⡄⠀⠀⣼⣿⣿⠀⠀]],
        [[⠀⠀⠀⠀⠠⠃⠀⠀⠀⠀⠀⠀⣠⠄⣀⣬⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢛⣁⣀⣤⣶⣾⡏⡇⠀⢀⣿⣿⣿⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⣴⣏⡠⠀⣳⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⣸⣿⣿⡟⢸⠀]],
        [[⠀⠀⠀⠀⠀⠀⠰⣬⣬⣥⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣀⣀⣀⡁⠀⢠⣿⣿⣿⠃⣼⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠈⡙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢛⣛⣛⣛⣛⣛⣻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⢀⣿⣿⣿⠏⣰⡏⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⢿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⠟⡥⠞⠋⠁⠀⠀⠀⠀⢀⣀⡀⣿⣿⣿⣿⣿⣿⣿⣿⠃⢀⣾⣿⣿⠏⣰⠟⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠋⢁⣴⣿⣿⣿⣿⣿⣿⣿⠼⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⢇⣿⣿⣿⣿⣿⣿⣿⠃⠀⠼⣛⣥⣥⣶⣶⣶⣦⣤]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣶⣿⡿⢻⣿⣿⣿⣿⣿⣿⣦⡂⠀⣀⣴⣶⣾⣿⡟⢹⡏⣼⣿⣿⣿⣿⣿⣿⠃⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠋⢀⣾⣿⣿⣿⣿⣿⣿⣿⣷⡐⣿⣿⣿⣿⡿⢡⡟⣴⣿⣿⣿⣿⣿⡿⠁⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⠀⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢻⣿⣿⣿⠇⡟⣼⣿⣿⣿⣿⣿⡟⠁⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⠀⢹⡟⣶⡀⠀⠀⢠⠀⠀⠀⠀⠀⠈⠛⢿⣿⣿⣿⣿⣿⣿⣿⣌⢿⣿⣿⢸⣸⣿⣿⣿⣿⣿⠟⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⠀⠀⠃⣿⣷⡀⠀⢸⡆⠀⠀⠀⠀⠀⠀⠀⢨⣛⠿⣿⣿⣿⣿⣿⣮⡻⠿⢡⣿⣿⣿⣿⡿⠋⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⠀⠀⠀⠈⣿⣿⣆⡸⣿⡄⠀⠀⠀⠀⠀⠀⠘⣿⣷⣄⠈⠙⠛⠿⢿⣿⣶⣿⣿⣿⠿⢋⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⠀⠀⠀⣠⣿⣿⣿⣷⣌⠻⡄⠀⠀⠀⠀⠀⠀⠹⣿⣿⣷⣄⡀⠀⠀⠀⠈⠉⠋⠁⠀⠀⠀⠀⢀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⠀⠀⠀⠻⣿⣿⣿⣿⣿⣷⣌⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣶⢀⡀⠀⠀⠀⠀⠀⠀⠀⢀⡎⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    }
dashboard.header
    .opts =
    {
        position = 'center',
    }
alpha.setup(
    dashboard.config)

-- telescope
require(
    'telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require(
    'telescope').load_extension(
    'fzf')

vim.cmd(
    [[
    let g:tex_flavor='latex'
    let g:vimtex_view_method='sioyek'
    let g:vimtex_quickfix_mode=0
    set conceallevel=1
    let g:tex_conceal='abdmg'
]])
