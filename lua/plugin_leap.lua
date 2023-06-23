return {

    {
        "ggandor/leap.nvim",

        config = function()
            local leap = require('leap')
            leap.opts.case_sensitive = false
            leap.opts.substitute_chars = {['\r'] = '¬'}
            leap.opts.special_keys.prev_target = {'<s-enter>', ','}

            leap.opts.labels = {
                "s", "f", "n", "j", "k", "l", "h", "o", "d", "w", "e", "m", "b", "u", "y", "v", "r", "g", "t", "c", "x", "\"", "&", "!", "&", "N", "F", "J",
                "K", "L", "H", "O", "D", "W", "E", "M", "B", "U", "Y", "V", "R", "G", "T", "C", "X", "?", "Z",
            }
            vim.api.nvim_set_hl(0, 'LeapBackdrop', {link = 'Comment'}) -- or some grey
            vim.api.nvim_set_hl(0, 'LeapMatch', {
                -- For light themes, set to 'black' or similar.
                fg = 'white',
                bold = true,
                nocombine = true,
            })
            -- Of course, specify some nicer shades instead of the default "red" and "blue".
            vim.api.nvim_set_hl(0, 'LeapLabelPrimary', {fg = '#fd350d', bold = true, nocombine = true})
            vim.api.nvim_set_hl(0, 'LeapLabelSecondary', {fg = '#fd6753', bold = true, nocombine = true})
        end,

    }, {
        "ggandor/flit.nvim",
        config = function()

            require('flit').setup {
                keys = mappings.flit_keymap,
                -- A string like "nv", "nvo", "o", etc.
                labeled_modes = "v",
                multiline = true,
                -- Like `leap`s similar argument (call-specific overrides).
                -- E.g.: opts = { equivalence_classes = {} }
                opts = {},
            }
        end,
    },
}
