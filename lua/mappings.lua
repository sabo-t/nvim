local mappings = {}

-- movement
vim.keymap.set({"n", "x"}, "j", "h", {silent = true})
vim.keymap.set({"n", "x"}, "k", "gj", {silent = true})
vim.keymap.set({"n", "x"}, "l", "gk", {silent = true})
vim.keymap.set({"n", "x"}, "ö", "l", {silent = true})
vim.keymap.set({"x"}, "J", "h", {silent = true})
vim.keymap.set({"x"}, "K", "gj", {silent = true})
vim.keymap.set({"x"}, "L", "gk", {silent = true})
vim.keymap.set({"x"}, "Ö", "l", {silent = true})
vim.keymap.set({"n", "x"}, ",", "<C-D>zz", {silent = true})
vim.keymap.set({"n", "x"}, ".", "<C-U>zz", {silent = true})
vim.keymap.set({"n", "x"}, "<c-b>", "", {silent = true})
vim.keymap.set({"n", "x"}, "<c-w>", "", {silent = true})

-- zz on jump
vim.keymap.set({"n"}, "G", "Gzz", {silent = true})
vim.keymap.set({"n"}, "G", "Gzz", {silent = true})
vim.keymap.set({"n"}, "G", "Gzz", {silent = true})
vim.keymap.set({"n"}, "n", "nzz", {silent = true})
vim.keymap.set({"n"}, "N", "Nzz", {silent = true})
vim.keymap.set({"n"}, "<C-o>", "<C-o>zz", {silent = true})
vim.keymap.set({"n"}, "<C-i>", "<C-i>zz", {silent = true})
vim.keymap.set({"n"}, "<C-1>", "{zz", {silent = true})
vim.keymap.set({"n"}, "<C-3>", "}zz", {silent = true})
vim.keymap.set({"n"}, "{", "{zz", {silent = true})
vim.keymap.set({"n"}, "}", "}zz", {silent = true})
vim.keymap.set({"n"}, "%", "%zz", {silent = true})

-- dot-repeat
vim.keymap.set({"n", "x"}, "-", ".", {silent = true}) -- dot

-- macro
vim.keymap.set({"n"}, "_", "@@", {silent = true}) -- macros
vim.keymap.set({"x"}, "@", ":normal @", {silent = true}) -- quick visual mode edit

-- marks
vim.keymap.set({"n", "x"}, "'", "`", {silent = true})

-- autosave
vim.keymap.set({"n", "x", "i"}, "<Escape>", "<Escape><cmd>if !&readonly && expand('%') != '' && expand('%') != '[Command Line]'<CR>:write<CR>:endif<CR>",
               {silent = true})

-- dynamic Tab key
vim.keymap.set({"i", "s"}, "<tab>", "<cmd>lua util.tabcontext()<cr>", {silent = true})
vim.keymap.set({"i"}, "<C-§>", "<tab>", {silent = true})

-- jump character
vim.keymap.set({"i"}, "§", "<c-o>a", {silent = true})
vim.keymap.set({"n"}, "§", "l", {silent = true})
vim.keymap.set({"i"}, "¶", "<c-o>a", {silent = true})
vim.keymap.set({"n"}, "¶", "l", {silent = true})

-- indentation
vim.keymap.set({"n"}, "å", "<cmd>lua lib.choicecontextL()<cr>", {silent = true})
vim.keymap.set({"x"}, "å", "<cmd>lua lib.choicecontextLvisual()<cr>", {silent = true})
vim.keymap.set({"n"}, "Å", "<cmd>lua lib.choicecontextR()<cr>", {silent = true})
vim.keymap.set({"x"}, "Å", "<cmd>lua lib.choicecontextRvisual()<cr>", {silent = true})

-- move lines
vim.keymap.set({"v"}, "<c-k>", ":m '>+1<cr>gv=gv", {silent = true})
vim.keymap.set({"v"}, "<c-l>", ":m '<-2<cr>gv=gv", {silent = true})

-- splits
vim.keymap.set({"n", "x"}, "<space>s", split.split, {silent = true})
vim.keymap.set({"n", "x"}, "<space>m", split.promote, {silent = true})
-- vim.keymap.set({"n", "x"}, "<space>h", "<cmd>split<cr>", {silent = true})
vim.keymap.set({"n"}, "J", "<C-W>h", {silent = true})
vim.keymap.set({"n"}, "K", "<C-W>j", {silent = true})
vim.keymap.set({"n"}, "L", "<C-W>k", {silent = true})
vim.keymap.set({"n"}, "Ö", "<C-W>l", {silent = true})
-- vim.keymap.set({"n"}, "-", "<C-W>>", {silent = true})
-- vim.keymap.set({"n"}, "+", "<C-W><", {silent = true})
-- vim.keymap.set({"n"}, "-", "<C-W>-", {silent = true})
-- vim.keymap.set({"n"}, "+", "<C-W>+", {silent = true})
-- vim.keymap.set({"n"}, "<C-->", "<C-W>>", {silent = true})
-- vim.keymap.set({"n"}, "<C-+>", "<C-W><", {silent = true})
vim.keymap.set({"n"}, "=", "<C-W>=", {silent = true})
vim.keymap.set({"n"}, "<space>J", "<C-W>H", {silent = true})
vim.keymap.set({"n"}, "<space>K", "<C-W>J", {silent = true})
vim.keymap.set({"n"}, "<space>L", "<C-W>K", {silent = true})
vim.keymap.set({"n"}, "<space>Ö", "<C-W>L", {silent = true})
vim.keymap.set({"n"}, "<S-space>J", "<C-W>H", {silent = true})
vim.keymap.set({"n"}, "<S-space>K", "<C-W>J", {silent = true})
vim.keymap.set({"n"}, "<S-space>L", "<C-W>K", {silent = true})
vim.keymap.set({"n"}, "<S-space>Ö", "<C-W>L", {silent = true})

-- tabs
vim.keymap.set({"n", "x"}, "<space>t", "<cmd>tabnew<cr>", {silent = true})
vim.keymap.set({"n"}, "T", ":silent! -tabmove<cr>", {silent = true})
vim.keymap.set({"n"}, "H", ":silent! +tabmove<cr>", {silent = true})
vim.keymap.set({"n"}, "h", "<cmd>tabnext<cr>", {silent = true})
vim.keymap.set({"n"}, "t", "<cmd>tabprev<cr>", {silent = true})
vim.keymap.set({"n"}, "gxx", "<cmd>tabonly<cr>", {silent = true})
-- vim.keymap.set({"n"}, "gx$", "<cmd>-10tabonly<cr>", {silent = true})
-- vim.keymap.set({"n"}, "gx^", "<cmd>10tabonly<cr>", {silent = true})

-- split -> tab
vim.keymap.set({"n"}, "gt", "<C-W>T", {silent = true})

-- tab -> split
vim.keymap.set({"n"}, "gS", util.MoveToPrevTab, {silent = true})
vim.keymap.set({"n"}, "gs", util.MoveToNextTab, {silent = true})

-- folds
vim.keymap.set('n', 'Å', 'zR')
vim.keymap.set('n', 'Ä', 'zM')
vim.keymap.set({"n"}, "å", "<cmd>silent! normal! zo<cr>", {silent = true})
vim.keymap.set({"n"}, "ä", "<cmd>silent! normal! zc<cr>", {silent = true})

-- misc
vim.keymap.set('n', '<space>x', 'x')
vim.keymap.set({"n", "x"}, "<a-o>", "h", {silent = true})
vim.keymap.set({"n"}, "Q", "<nop>", {silent = true})

-- delete next char
vim.keymap.set({"i"}, "<C-Backspace>", '<C-o>:normal "_x<cr>', {silent = true})

-- new lines
vim.keymap.set({"i"}, "<C-Return>", "<c-o>o", {noremap = true})
vim.keymap.set({"n"}, "<space>o", "O<C-j>", {noremap = true})

-- paste
vim.keymap.set({"n"}, "<C-p>", '"*p', {silent = true})
vim.keymap.set({"i"}, "<C-p>", '<Escape>"*pa', {silent = true})
vim.keymap.set({"x"}, "<C-p>", '"*p', {silent = true})

-- yank
vim.keymap.set({"x"}, "<C-y>", '"+ygv"*y', {silent = true})
vim.keymap.set({"n"}, "<C-y>", '"+ygv"*yw', {silent = true})
vim.keymap.set({"n"}, "<space>ya", 'GVgg"+y', {noremap = true}) -- all
vim.keymap.set({"n"}, "<space>yf", "<cmd>!echo %:p | xclip -selection clipboard<cr><cr>", {}) -- file

-- do not add x'd character to register
vim.keymap.set({"n"}, "x", '"_x', {noremap = true})

-- get line excluding whitespace
vim.keymap.set({"n"}, "<space>yd", "^vg_y$", {noremap = true})
vim.keymap.set({"n"}, "<space>dd", '^vg_d"_dd', {noremap = true})
vim.keymap.set({"n"}, "<space>v", "^vg_", {noremap = true})

-- open [Command Line]
vim.keymap.set({"n"}, "<space>.", "q::resize 20<cr>", {})
vim.keymap.set({"n"}, "<space>:", "q::resize 20<cr>", {})

-- quit
vim.keymap.set({"n"}, "<space>q", split.quit, {silent = true})

-- change colorscheme
vim.keymap.set({"n"}, "<space><space>c", cs.next_colorscheme, {silent = false})

-- search and replace
vim.keymap.set({"n"}, "<C-s>", ":%s/", {noremap = true})
vim.keymap.set({"v"}, "<C-s>", ":s/", {noremap = true})

-- open ranger
-- vim.keymap.set({"n"}, "<c-f>",
--                '<cmd>!ps aux | grep -E \'/home/sabo/scripts/ranger.sh$\' | awk \'{print $2}\'|sed \'$d\' |xargs -I {} kill -9 {} ; setsid -f st -t "ranger" -e sh -c \'cd %:p:h && /home/sabo/scripts/ranger.sh\'<cr><cr>',
--                {silent = true}) -- kill ranger session and open ranger where file located

-- open term
vim.keymap.set({"n"}, "<space>j", "<cmd>silent! !setsid -f kitty -d \"%:p:h\"<cr>")

-- source
vim.keymap.set({"n"}, "<space><space>p",
               '<cmd>source ~/.config/nvim/lua/snippets.lua | echo "sourced snippets" | source ~/.config/nvim/lua/plugins.lua | echo "sourced plugins" | PackerSync<cr>',
               {noremap = true})
vim.keymap.set({"n"}, "<space><space>s", '<cmd>source ~/.config/nvim/lua/snippets.lua | echo "sourced snippets"<cr>', {noremap = true})

vim.keymap.set({"t"}, "<C-e>", "<C-\\><C-n>", {})
vim.keymap.set({"t"}, "<C-,>", "<C-\\><C-n><C-D>zz", {})
vim.keymap.set({"t"}, "<C-.>", "<C-\\><C-n><C-U>zz", {})
vim.keymap.set({"t"}, "<C-7>", "<C-\\>", {})
vim.keymap.set({"t"}, "<C-p>", '<C-\\><C-n>"+pa', {})
vim.keymap.set({"t"}, "<s-space>", "<Nop>", {})

----------------------------- ~~
---------- plugins ---------- ~~
----------------------------- ~~

-- undotree
vim.keymap.set({"n"}, "<space>u", "<cmd>UndotreeToggle<cr>", {silent = true})

-- cmp
local cmp = require("cmp")
local ls = require("luasnip")
mappings.cmp_keymap = {
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}),
    ["<C-l>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "c"}),
    ["<CR>"] = cmp.mapping(cmp.mapping.confirm({select = false}), {"i"}),
    ["<C-CR>"] = cmp.mapping(cmp.mapping.confirm({select = true}), {"i", "s"}),
    ["<C-space>"] = cmp.mapping(cmp.mapping.confirm({select = true}), {"i", "s", "c"}),
    ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), {"i", "c"}),
    --[[         ["<S-Tab>"] = cmp.mapping(function(fallback) ]]
    ["<S-Tab>"] = cmp.mapping(function()
        if ls.expand_or_locally_jumpable() then
            if ls.jumpable(-1) then
                ls.jump(-1)
                -- else
                --     fallback()
            end
        end
    end, {"i", "s"}),
    -- ["<Tab>"] = cmp.mapping(function()
    --     if ls.expand_or_locally_jumpable() then
    --         if ls.jumpable(1) then
    --             ls.jump(1)
    --             -- else
    --             --     fallback()
    --         end
    --     end
    -- end, {"i", "s"}),
}
-- })

-- luasnip
vim.keymap.set({"i", "s"}, "<C-Tab>", "<Plug>luasnip-next-choice", {})

-- aerial
vim.keymap.set('n', '<space>a', '<cmd>AerialToggle!<CR>')
function mappings.aerial_on_attach(bufnr)
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
end
mappings.aerial_keymap = {
    ["l"] = false,
    ["h"] = "actions.tree_open",
    ["H"] = "actions.tree_open_all",
    ["t"] = "actions.tree_close",
    ["T"] = "actions.tree_close_all",
}

-- toggleterm
vim.keymap.set({"v"}, "<F1>", ":ToggleTermSendVisualSelection 1<cr>", {silent = true})
vim.keymap.set({"v"}, "<F2>", ":ToggleTermSendVisualSelection 2<cr>", {silent = true})
vim.keymap.set({"n", "t"}, "<c-f>", "<cmd>ToggleTerm 3 size=33<cr>", {silent = true})
vim.keymap.set({"n", "t"}, "<F1>", "<cmd>ToggleTerm 1 size=25<cr>", {silent = true})
vim.keymap.set({"n", "t"}, "<F2>", "<cmd>ToggleTerm 2 size=25<cr>", {silent = true})

-- leap
vim.keymap.set({"n", "x"}, "s", function()
    local current_window = vim.fn.win_getid()
    require('leap').leap {target_windows = {current_window}}
end, {silent = true})
mappings.flit_keymap = {f = 'f', F = 'F', t = '<C-f>', T = '<C-F>'}

-- telescope
vim.keymap.set({"n"}, "<space>ff", "<cmd>lua require'telescope.builtin'.git_files{}<cr>")
vim.keymap.set({"n"}, "<space>fn", "<cmd>lua require'telescope.builtin'.git_files{cwd = '/home/sabo/.config/nvim'}<cr>")
vim.keymap.set({"n"}, "<space>fr", "<cmd>lua require'telescope.builtin'.live_grep{}<cr>")
vim.keymap.set({"n"}, "<space>fb", "<cmd>lua require'telescope.builtin'.buffers{}<cr>")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local actions_set = require("telescope.actions.set")
mappings.telescope_keymap = {
    i = {
        ["<esc>"] = actions.close,
        ["<c-p>"] = action_layout.toggle_preview,
        ["<c-l>"] = actions.move_selection_previous,
        ["<c-k>"] = actions.move_selection_next,
        ["<c-s>"] = actions.file_vsplit,
        ["<c-h>"] = actions.file_split,
        ["<c-t>"] = actions.file_tab,
    },
    n = {
        ["<esc>"] = actions.close,
        ["<c-p>"] = action_layout.toggle_preview,
        ["<c-l>"] = actions.move_selection_previous,
        ["<c-k>"] = actions.move_selection_next,
        ["<c-s>"] = actions.file_vsplit,
        ["<c-t>"] = actions.file_tab,
    },
}

-- sniprun
vim.keymap.set({"v"}, "<F3>", ":SnipRun<cr>", {silent = true})
vim.keymap.set({"n"}, "<F3>", "<cmd>SnipClose<cr>", {silent = true})

return mappings
