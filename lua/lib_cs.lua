local util = require('lib_util')
local cs = {}

function cs.save_colorscheme()
    local file = io.open(st.file_current_colorscheme, "w")
    if file then
        file:write(st.colorscheme)
        file:close()
    else
        error("Cannot open file to save colorscheme!")
    end
end

function cs.get_last_colorscheme()
    local file = io.open(st.file_current_colorscheme, "r")
    if file then
        local colorscheme = file:read("*all")
        file:close()
        return util.chomp(colorscheme)
    end
end

function cs.next_colorscheme()
    local found = false
    for i, colorscheme in ipairs(st.colorschemes) do
        if found then
            cs.change_colorscheme(st.colorschemes[i])
            return
        end
        if colorscheme == st.colorscheme then found = true end
    end
    cs.change_colorscheme(st.colorschemes[1])
end

function cs.change_colorscheme(colorscheme)
    if util.contains(st.colorschemes, colorscheme) then
        vim.cmd('colorscheme ' .. colorscheme)
        st.colorscheme = colorscheme
        cs.save_colorscheme()
        adjust_brightness()
    end
end

function adjust_brightness()
    blend_hlgroup("CursorLine", 13)
    blend_hlgroup("CursorColumn", 5)
end

function blend_hlgroup(group, brightness_increase)
    local normal_bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg", "gui")
    local r, g, b = tonumber(normal_bg:sub(2, 3), 16),
                    tonumber(normal_bg:sub(4, 5), 16),
                    tonumber(normal_bg:sub(6, 7), 16)
    local is_light_bg = (r + g + b) / 3 > 127.5
    local function adjust(value, amount)
        if is_light_bg then
            return math.max(math.floor(value - amount), 0)
        else
            return math.min(math.floor(value + amount), 255)
        end
    end
    r, g, b = adjust(r, brightness_increase), adjust(g, brightness_increase),
              adjust(b, brightness_increase)
    local new_bg = string.format("#%02x%02x%02x", r, g, b)
    vim.cmd("highlight " .. group .. " guibg=" .. new_bg)
end

return cs
