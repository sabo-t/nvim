split = {}
split.tabs = {{}}

function init_tabpage(t)
    t = t or {}
    t.wins = {}
    table.insert(t.wins, v.nvim_get_current_win())
    return t
end

init_tabpage(split.tabs[1])

local forbidden_ftype = {'packer', 'aerial', 'nvim-tree', 'nerdtree', ''}
local forbidden_name = {'[Command Line]', '[No Name]'}

local function get_ftype(window_handle)
    local buf_handle = v.nvim_win_get_buf(window_handle)
    local filetype = v.nvim_buf_get_option(buf_handle, 'filetype')
    return filetype
end

local function get_name(window_handle)
    local buf_handle = v.nvim_win_get_buf(window_handle)
    local filename = v.nvim_buf_get_name(buf_handle)
    return filename
end

local function is_legal(window_handle)
    return not (util.contains(forbidden_ftype, get_ftype(window_handle)) or util.contains(forbidden_name, get_name(window_handle)) or
               util.is_win_float(window_handle))
end

function split.update()
    local tabpage = v.nvim_get_current_tabpage()
    local br = split.locate_bottom_right(tabpage)
    local t = split.tabs[tabpage] or init_tabpage(split.tabs[tabpage])
    if t.wins[#t.wins] ~= br then t.wins[#t.wins + 1] = br end
end

-- this cannot be ran after a window is removed
-- this exists because I do not know how to get the window handle of a freshly spawned window
-- so we have to update the vars before splitting next time
function split.locate_bottom_right(tabpage)
    local max_x = -1
    local max_y = -1
    local bottom_right_win = nil

    for _, win_id in ipairs(v.nvim_tabpage_list_wins(tabpage)) do
        local pos = v.nvim_win_get_position(win_id)
        if pos[1] >= max_y and pos[2] >= max_x and is_legal(win_id) then
            max_y = pos[1]
            max_x = pos[2]
            bottom_right_win = win_id
        end
    end
    return bottom_right_win
end

function remove_from_wins(value)
    local tab_id = v.nvim_get_current_tabpage()
    local t = split.tabs[tab_id] or init_tabpage(split.tabs[tab_id])
    for i, v in ipairs(t.wins) do
        if v == value then
            table.remove(t.wins, i)
            break
        end
    end
end

function split.promote(window_handle)
    split.update()
    window_handle = window_handle or v.nvim_get_current_win()
    local tab_id = v.nvim_get_current_tabpage()
    local t = split.tabs[tab_id] or init_tabpage(split.tabs[tab_id])
    local master_buf = v.nvim_win_get_buf(t.wins[1])
    local target_buf = v.nvim_win_get_buf(window_handle)
    v.nvim_win_set_buf(t.wins[1], target_buf)
    v.nvim_win_set_buf(window_handle, master_buf)
    v.nvim_set_current_win(t.wins[1])
end

function split.split()
    split.update()
    local tab_id = v.nvim_get_current_tabpage()
    local curr = v.nvim_get_current_win()
    local t = split.tabs[tab_id] or init_tabpage(split.tabs[tab_id])
    local target = t.wins[#t.wins]
    if target == curr and t.wins[2] == nil then
        vim.cmd("vsplit")
    else
        v.nvim_win_call(target, function() vim.cmd("split") end)
        v.nvim_set_current_win(target)
    end
end

function split.quit()
    split.update()
    local tab_id = v.nvim_get_current_tabpage()
    local t = split.tabs[tab_id] or init_tabpage(split.tabs[tab_id])
    local curr = v.nvim_get_current_win()
    if is_legal(curr) then
        if curr == t.wins[1] and nil ~= t.wins[2] then
            split.promote(t.wins[2])
            v.nvim_win_close(t.wins[2], false)
            table.remove(t.wins, 2)
        elseif curr == t.wins[1] and nil == t.wins[2] then
            t = nil
            vim.cmd("q")
        else
            remove_from_wins(curr)
            vim.cmd("q")
        end
    else
        vim.cmd("q")
    end
end

return split
