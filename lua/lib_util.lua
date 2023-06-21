local util = {}
-------------------
---- functions ----
-------------------

v = vim.api

local key_DelimitJump = v.nvim_replace_termcodes("<C-tab>", true, false, true)
local key_TabKey = v.nvim_replace_termcodes("<C-§>", true, false, true)
local key_SplitMod = v.nvim_replace_termcodes("<C-W>", true, false, true)
local key_cr = v.nvim_replace_termcodes("<cr>", true, false, true)
local key_left = v.nvim_replace_termcodes("<Left>", true, false, true)
local key_right = v.nvim_replace_termcodes("<Right>", true, false, true)
-- local posix = require 'posix'

function util.contains(table, value)
    for _, v in ipairs(table) do if v == value then return true end end
    return false
end


function util.chomp(s)
   return s:gsub("\n$", "")
end

function util.to_char_array(s)
    local t = {}
    for c in s:gmatch"." do
        table.insert(t, c)
    end
    return t
end

clock = os.clock
function util.sleep(n) -- seconds
    local t0 = clock()
    while clock() - t0 <= n do end
end

function util.get_filename(buffer)
    local fullPath = v.nvim_buf_get_name(buffer)
    return string.match(fullPath, "[^/]+$")
end

function util.swap_words(word1, word2)
    local start_line, end_line =
        unpack(vim.api.nvim_buf_get_mark(0, '<'), 1, 2),
        unpack(vim.api.nvim_buf_get_mark(0, '>'), 1, 2)
    local temp = "TEMP_WORD_SWAP"

    for line = start_line, end_line do
        local current_line = vim.api
                                 .nvim_buf_get_lines(0, line - 1, line, false)[1]
        local modified_line = current_line:gsub(word1, temp):gsub(word2, word1)
                                  :gsub(temp, word2)
        vim.api.nvim_buf_set_lines(0, line - 1, line, false, {modified_line})
    end
end

function util.reload_file()
    local fullPath = v.nvim_buf_get_name(0)
    local curs_pos = v.nvim_win_get_cursor(0)
    vim.cmd("e /dev/null | bdelete " .. fullPath .. " | e " .. fullPath)
    v.nvim_win_set_cursor(0, curs_pos)
end

function util.get_char_under_cursor()
    local win = v.nvim_get_current_win()
    local byte_index = v.nvim_win_get_cursor(win)[2]
    local line = v.nvim_get_current_line()
    local char_under_cursor = string.sub(line, byte_index + 1, byte_index + 1)
    return char_under_cursor
end

function util.jumptomark(mark)

    -- vim.cmd(key .. mark .. 'zz')
end

function util.test()
    local n = io.read("*n")
    print(n)
end

function util.MoveFromNvimTree()
    local current_buf_name = vim.fs.basename(v.nvim_buf_get_name(0))
    if string.sub(current_buf_name, 1, 8) == "NvimTree" then
        v.nvim_feedkeys(key_SplitMod, 'n', false)
        v.nvim_feedkeys("l", 'n', false)
    end
    return true
end

function util.MoveSplitFromNvimTree()
    local current_buf_name = vim.fs.basename(v.nvim_buf_get_name(0))
    if string.sub(current_buf_name, 1, 8) == "NvimTree" then
        v.nvim_feedkeys(key_SplitMod, 'n', false)
        v.nvim_feedkeys("L", 'n', false)
    end
    return nil
end

function util.tabnext() -- next tab; if focus on nvimtree then change focus to one window to the right
    vim.cmd(string.format("tabnext"))
    util.MoveFromNvimTree()
end

function util.tabprev() -- next tab; if focus on nvimtree then change focus to one window to the right
    vim.cmd(string.format("tabprev"))
    util.MoveFromNvimTree()
end

function util.manpager(x)
    local current_bufs = v.nvim_list_bufs()
    local current_buf_name = vim.fs.basename(v.nvim_buf_get_name(0))

    if string.sub(current_buf_name, 1, 8) == "NvimTree" then
        v.nvim_feedkeys(key_SplitMod, 'n', false)
        v.nvim_feedkeys("l", 'n', false)
        return nil
    end

    for _, i in ipairs(current_bufs) do
        if v.nvim_buf_is_loaded(i) == true then
            if vim.fs.basename(v.nvim_buf_get_name(i)) == ".mantemp" then
                v.nvim_buf_delete(i, {force = true})
                break
            end
        end
    end
    local command = "!man" .. x .. " > /home/sabo/.cache/.mantemp"
    vim.cmd(string.format(command))

    vim.cmd(string.format("tabnew"))
    vim.cmd(string.format("e /home/sabo/.cache/.mantemp"))
end

function util.PrintLoadedBufs()
    local current_buf = v.nvim_get_current_buf()
    local current_bufs = v.nvim_list_bufs()
    local loaded_bufs = {}
    for _, i in ipairs(current_bufs) do
        if v.nvim_buf_is_loaded(i) == true then
            table.insert(loaded_bufs, i)
            print(vim.fs.basename(v.nvim_buf_get_name(i)))
        end
    end
    print("all bufs: " .. table.concat(loaded_bufs, ","))
    print("focused buf: " .. current_buf)
    return nil
end

function util.PrintBufs()
    local current_win = v.nvim_get_current_win()
    local current_uis = v.nvim_list_uis()
    print(current_uis)
    print("all uis: " .. table.concat(current_uis, ","))
    -- print("all uis: " .. current_uis)
    print("focused win: " .. current_win)
    return nil
end

function util.ConditionalQuit()
    local buffer = v.nvim_get_current_buf()
    if buffer == expandedbuffer then expandedbuffer = -1 end
    vim.cmd(string.format("q"))
end

function util.ConditionalForceQuit()
    local buffer = v.nvim_get_current_buf()
    if buffer == expandedbuffer then expandedbuffer = -1 end
    vim.cmd(string.format("q!"))
end

function util.ConditionalSaveQuit()
    local buffer = v.nvim_get_current_buf()
    if buffer == expandedbuffer then expandedbuffer = -1 end
    vim.cmd(string.format("wq"))
end

function util.ExpandSplit()
    local buffer = v.nvim_get_current_buf()
    local current_buf_name = vim.fs.basename(v.nvim_buf_get_name(0))
    if expandedbuffer == nil then expandedbuffer = -1 end
    if string.sub(current_buf_name, 1, 8) ~= "NvimTree" then
        if expandedbuffer == -1 then
            v.nvim_feedkeys("mA", 'n', false)
            v.nvim_feedkeys(key_SplitMod, 'n', false)
            v.nvim_feedkeys("L", 'n', false)
            expandedbuffer = buffer
        elseif buffer == expandedbuffer then
            v.nvim_feedkeys(key_SplitMod, 'n', false)
            v.nvim_feedkeys("K", 'n', false)
            expandedbuffer = -1
        else
            expandedbuffer = buffer
            v.nvim_feedkeys("mB", 'n', false)
            v.nvim_feedkeys("'A", 'n', false)
            v.nvim_feedkeys(key_SplitMod, 'n', false)
            v.nvim_feedkeys("l", 'n', false)
            v.nvim_feedkeys("'B", 'n', false)
            v.nvim_feedkeys("mA", 'n', false)
        end

    end
end

local ls = require("luasnip")
function util.tabcontext()
    -- if v.nvim_exec("echo delimitMate#ShouldJump()", true) == "1" then
    -- v.nvim_feedkeys(key_DelimitJump, 'i', false)
    -- vim.cmd("exe 'norm! l%%'")
    if ls.expand_or_locally_jumpable() then
        if ls.jumpable(1) then
            ls.jump(1)
        else
            v.nvim_feedkeys(key_TabKey, 'i', false)
        end
    else
        v.nvim_feedkeys(key_TabKey, 'i', false)
    end
end

function util.choicecontextR()
    if ls.choice_active() then
        ls.change_choice(1)
    else
        vim.cmd("normal >>")
    end
end

function util.choicecontextL()
    if ls.choice_active() then
        ls.change_choice(-1)
    else
        vim.cmd("normal <<")
    end
end

function util.choicecontextRvisual()
    if ls.choice_active() then
        ls.change_choice(1)
    else
        vim.cmd("normal >gv")
    end
end

function util.choicecontextLvisual()
    if ls.choice_active() then
        ls.change_choice(1)
    else
        vim.cmd("normal <gv")
    end
end

-- nvim_win_close({window}, {force})
-- nvim_set_current_win({window})

function util.terminalScratchPad()
    local winWidth = v.nvim_win_get_width(0)
    if winWidth > 200 then
        spawnCmd = "vsplit"
    else
        spawnCmd = "bel split"
    end
    local bufs = v.nvim_list_bufs()
    local wins = v.nvim_list_wins()
    local tabwins = v.nvim_tabpage_list_wins(0)
    for _, i in ipairs(tabwins) do
        if (string.sub(v.nvim_buf_get_name(v.nvim_win_get_buf(i)), 1, 4) ==
            "term") then
            v.nvim_win_close(i, 0)
            return
        end
    end
    for _, i in ipairs(wins) do
        if (string.sub(v.nvim_buf_get_name(v.nvim_win_get_buf(i)), 1, 4) ==
            "term") then v.nvim_win_close(i, 0) end
    end
    for _, i in ipairs(bufs) do
        if (string.sub(v.nvim_buf_get_name(i), 1, 4) == "term") then
            vim.cmd(spawnCmd)
            v.nvim_set_current_buf(i)
            vim.cmd("startinsert")
            return
        end
    end
    vim.cmd(spawnCmd .. " | term")
    vim.cmd("startinsert")
end

function util.killTerminal()
    local bufs = v.nvim_list_bufs()
    local wins = v.nvim_list_wins()
    for _, i in ipairs(wins) do
        if (string.sub(v.nvim_buf_get_name(v.nvim_win_get_buf(i)), 1, 4) ==
            "term") then v.nvim_win_close(i, 0) end
    end
    for _, i in ipairs(bufs) do
        if (string.sub(v.nvim_buf_get_name(i), 1, 4) == "term") then
            v.nvim_buf_delete(i, {force = true})
        end
    end
end

function util.terminalNewSession()
    local winWidth = v.nvim_win_get_width(0)
    if winWidth > 200 then
        spawnCmd = "vsplit"
    else
        spawnCmd = "split"
    end
    util.killTerminal()
    if spawnCmd == "vsplit" then
        vim.cmd(spawnCmd .. " | term")
    elseif spawnCmd == "split" then
        vim.cmd("bel " .. spawnCmd .. " | term")
    end
    -- if feedkeys ~= nil then
    --     v.nvim_feedkeys(feedkeys, 't', false)
    -- end
    vim.cmd("startinsert")
end

function util.terminalNewSessionFeedKeys(feedkeys)
    local winWidth = v.nvim_win_get_width(0)
    if winWidth > 200 then
        spawnCmd = "vsplit"
    else
        spawnCmd = "split"
    end
    util.killTerminal()
    vim.cmd(spawnCmd .. " | term")
    if feedkeys ~= nil then v.nvim_feedkeys(feedkeys, 't', false) end
    vim.cmd("startinsert")
end

function util.terminalNewSessionExec(cmd)
    local winWidth = v.nvim_win_get_width(0)
    if winWidth > 200 then
        spawnCmd = "vsplit"
    else
        spawnCmd = "split"
    end
    util.killTerminal()
    if cmd ~= nil then
        vim.cmd(spawnCmd .. " | term " .. cmd)
    else
        vim.cmd(spawnCmd .. " | term")
    end
    vim.cmd("startinsert")
end

function util.getTabPageWinNames()
    names = {}
    local tabpageWins = v.nvim_tabpage_list_wins(0)
    for _, i in ipairs(tabpageWins) do
        table.insert(names, vim.fs
                         .basename(v.nvim_buf_get_name(v.nvim_win_get_buf(i))))
    end
    return names
end

function util.printBaseTabWinNames()
    local tabpageWins = v.nvim_tabpage_list_wins(0)
    for _, i in ipairs(tabpageWins) do
        print(vim.fs.basename(v.nvim_buf_get_name(v.nvim_win_get_buf(i))))
    end
end

function util.printBaseWinNames()
    local tabpageWins = v.nvim_list_wins()
    for _, i in ipairs(tabpageWins) do
        print(vim.fs.basename(v.nvim_buf_get_name(v.nvim_win_get_buf(i))))
    end
end

function util.printTabWinNames()
    local tabpageWins = v.nvim_tabpage_list_wins(0)
    for _, i in ipairs(tabpageWins) do
        print(v.nvim_buf_get_name(v.nvim_win_get_buf(i)))
    end
end

function util.printWinNames()
    local tabpageWins = v.nvim_list_wins()
    for _, i in ipairs(tabpageWins) do
        print(v.nvim_buf_get_name(v.nvim_win_get_buf(i)))
    end
end

function util.printWinBufs()
    local tabpageWins = v.nvim_list_wins()
    for _, i in ipairs(tabpageWins) do print(v.nvim_win_get_buf(i)) end
end

function util.is_win_float(debug)
    debug = debug or false
    tabpageWins = v.nvim_tabpage_list_wins(0)
    win_c = v.nvim_get_current_win()
    y_c, x_c = unpack(v.nvim_win_get_position(0))
    for _, i in ipairs(tabpageWins) do
        if i == win_c then goto continue end
        height = v.nvim_win_get_height(i)
        width = v.nvim_win_get_width(i)
        y, x = unpack(v.nvim_win_get_position(i))
        y = y + 1
        x = x + 1
        if debug then
            print(
                y .. " <= " .. y_c .. " and " .. y_c .. " <= " .. y + height ..
                    " and " .. x .. " <= " .. x_c .. " and " .. x_c .. " <= " ..
                    x + width)
            print(y <= y_c and y_c <= y + height and x <= x_c and x_c <= x +
                      width)
            print("\n")
        end
        if y <= y_c and y_c <= y + height and x <= x_c and x_c <= x + width then
            return true
        end
        ::continue::
    end
    return false
end

-- local valgrindparam = '--leak-check=full --show-leak-kinds=all --track-origins=yes -v ./a.out'

-- function util.tabcontext()
--     local key_DelimitJump = v.nvim_replace_termcodes("<C-S-tab>", true, false, true)
--     if v.nvim_exec("echo delimitMate#ShouldJump()", true) == "1" then
--         v.nvim_feedkeys(key_DelimitJump, 'i', false)
--     else
--         v.nvim_feedkeys("    ", 'i', false)
--     end
-- end

-- export MANPAGER="sh -c 'col -bx > ~/.cache/.mantemp && nvim ~/.cache/.mantemp'"



return util
