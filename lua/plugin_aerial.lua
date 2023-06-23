-- https://github.com/stevearc/aerial.nvim
return {
    'stevearc/aerial.nvim',
    config = function()
        require('aerial').setup({
            keymaps = mappings.aerial_keymap,
            manage_folds = true,
            layout = {
                width = 15,
                default_direction = "left",
                placement = "edge"
            },
            highlight_on_hover = true,
            show_guides = true,
            open_automatic = false,
            attach_mode = "global",
            lazy_load = false,
            -- optionally use on_attach to set keymaps when aerial has attached to a buffer
            on_attach = mappings.aerial_on_attach
        })
    end
}

