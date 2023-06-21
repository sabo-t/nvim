-- lualine
local function show_macro_recording() -- show what key is being recorded for a macro
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

vim.api.nvim_create_autocmd("RecordingEnter",
                            { -- make lualine refresh statusline on RecordEnter
    callback = function() require"lualine".refresh({place = {"statusline"}}) end
})

vim.api.nvim_create_autocmd("RecordingLeave",
                            { -- we have to wait 50ms to ensure vim.fn.reg_recording is purged before asking lualine to refresh
    callback = function()
        local timer = vim.loop.new_timer()
        timer:start(50, 0, vim.schedule_wrap(function()
            require"lualine".refresh({place = {"statusline"}})
        end))
    end
})

require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = {left = "", right = ""},
        section_separators = {left = "", right = ""},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false
    },
    sections = {
        lualine_a = {"mode", {"macro-recording", fmt = show_macro_recording}},
        lualine_b = {"branch", "filename", "diff"},
        lualine_c = {{"aerial", sep = '  ->  '}},
        lualine_x = {"diagnostics"},
        lualine_y = {"fileformat", "filesize", "filetype"},
        lualine_z = {"progress", "location"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {
            {
                "tabs",
                max_length = vim.o.columns,
                mode = 2
                -- tabs_color =  {
                -- active = 'lualine_{section}_normal',
                -- inactive = 'lualine_{section}_inactive', },
            }
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {"nvim-tree", "fzf"}
}

-- GUI
vim.cmd([[
if exists("g:neovide")
    let g:neovide_no_idle=v:false
    let g:neovide_cursor_antialiasing=v:false
    let g:neovide_transparency=1
    let g:neovide_cursor_animation_length=0
    let g:neovide_cursor_trail_length=0.4
    let g:neovide_profiler = v:false
    let g:neovide_scroll_animation_length = 0

    " Enable Mouse
    set mouse=a

    " Set Editor Font
    if readfile("/proc/sys/kernel/hostname")[0] == "archM"
        set guifont=hack:h10:#e-subpixelantialias:#h-none
        " set guifont=hack:h10
        let g:neovide_refresh_rate=60
    else
        set guifont=hack:h8
    endif
endif
]])

-- web-devicons
require"nvim-web-devicons".get_icons()
