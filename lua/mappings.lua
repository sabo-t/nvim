local ls = require("luasnip")
local cmp = require("cmp")
package.loaded["lib_util"] = nil
util = require('lib_util')
package.loaded["lib_cs"] = nil
cs = require('lib_cs')
-- movement
vim.keymap.set({"n", "x"}, "j", "h", {silent = true})
-- vim.keymap.set({"n", "x", "i"}, "<Escape>", "<Escape><cmd>if !&readonly<CR>:write<CR>:endif<CR>", {silent = true})

vim.keymap.set({"n", "x", "i"}, "<Escape>",
               "<Escape><cmd>if !&readonly && expand('%') != '' && expand('%') != '[Command Line]'<CR>:write<CR>:endif<CR>",
               {silent = true})
vim.keymap.set({"n", "x"}, "<a-o>", "h", {silent = true})
vim.keymap.set({"n", "x"}, "k", "gj", {silent = true})
vim.keymap.set({"n", "x"}, "l", "gk", {silent = true})
vim.keymap.set({"n", "x"}, "ö", "l", {silent = true})
vim.keymap.set({"n", "x"}, "J", "h", {silent = true})
vim.keymap.set({"n", "x"}, "K", "j", {silent = true})
vim.keymap.set({"n", "x"}, "L", "k", {silent = true})
vim.keymap.set({"n", "x"}, "Ö", "l", {silent = true})
vim.keymap.set({"n", "x"}, "'", "`", {silent = true})
vim.keymap.set({"n", "x"}, ",", "<C-D>zz", {silent = true})
vim.keymap.set({"n", "x"}, ".", "<C-U>zz", {silent = true})
vim.keymap.set({"n", "x"}, "-", ".", {silent = true})
vim.keymap.set({"n", "x"}, "<c-b>", "", {silent = true})
vim.keymap.set({"n", "x"}, "<c-w>", "", {silent = true})
vim.cmd([[
    nnoremap <silent> W :silent!call search('\<[A-Za-zÄÅÖäöå0-9]\\|\(_[A-Za-zÄÅÖäöå0-9]\)\\|\($\)\\|\(^\)', 'W')<cr>
    nnoremap <silent> E :call search('[A-Za-zÄÅÖäöå0-9]\>\\|\(_\)\\|\($\)\\|\(^\)', 'W')<cr>
    nnoremap <silent> B :call search('\<[A-Za-zÄÅÖäöå0-9]\\|\(_\)\\|\($\)\\|\(^\)', 'bW')<cr>
    nnoremap <silent> gE :call search('[A-Za-zÄÅÖäöå0-9]\>', 'bW')<cr>
    vnoremap <silent> W <Esc>:call search('\<[A-Za-zÄÅÖäöå0-9]\\|\(_\)', 'W')<cr>m>gv
    vnoremap <silent> E <Esc>:call search('[A-Za-zÄÅÖäöå0-9]\>', 'W')<cr>m>gv
    vnoremap <silent> B <Esc>:call search('\<[A-Za-zÄÅÖäöå0-9]', 'bW')<cr>m>gv
    vnoremap <silent> gE <Esc>:call search('[A-Za-zÄÅÖäöå0-9]\>', 'bW')<cr>m>gv
]])
require'nvim-treesitter.configs'.setup {
    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["<c-h>"] = "@function.outer",
                ["<c-g>"] = "@block.outer"
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer"
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer"
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer"
            }
        }
    }
}

-- center on cursor on jumps
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

-- indent
-- vim.keymap.set({"n"}, "å", "<cmd>lua lib.choicecontextL()<cr>", {silent = true})
-- vim.keymap.set({"n"}, "Å", "<cmd>lua lib.choicecontextR()<cr>", {silent = true})
-- vim.keymap.set({"x"}, "å", "<cmd>lua lib.choicecontextLvisual()<cr>", {silent = true})
-- vim.keymap.set({"x"}, "Å", "<cmd>lua lib.choicecontextRvisual()<cr>", {silent = true})
vim.keymap.set({"v"}, "<c-k>", ":m '>+1<cr>gv=gv", {silent = true})
vim.keymap.set({"v"}, "<c-l>", ":m '<-2<cr>gv=gv", {silent = true})

-- splits
vim.keymap.set({"n"}, "J", "<C-W>h", {silent = true})
vim.keymap.set({"n"}, "K", "<C-W>j", {silent = true})
vim.keymap.set({"n"}, "L", "<C-W>k", {silent = true})
vim.keymap.set({"n"}, "Ö", "<C-W>l", {silent = true})
vim.keymap.set({"n"}, "<C-j>", "<cmd>TmuxNavigateLeft<CR>", {silent = true})
vim.keymap.set({"n"}, "<C-ö>", "<cmd>TmuxNavigateRight<CR>", {silent = true})
vim.keymap.set({"n"}, "<C-k>", "<cmd>TmuxNavigateDown<CR>", {silent = true})
vim.keymap.set({"n"}, "<C-l>", "<cmd>TmuxNavigateUp<CR>", {silent = true})
-- vim.keymap.set({"n"}, "-", "<C-W>>", {silent = true})
-- vim.keymap.set({"n"}, "+", "<C-W><", {silent = true})
-- vim.keymap.set({"n"}, "-", "<C-W>-", {silent = true})
-- vim.keymap.set({"n"}, "+", "<C-W>+", {silent = true})
-- vim.keymap.set({"n"}, "<C-->", "<C-W>>", {silent = true})
-- vim.keymap.set({"n"}, "<C-+>", "<C-W><", {silent = true})
vim.keymap.set({"n"}, "=", "<C-W>=", {silent = true})
vim.keymap.set({"n"}, "gt", "<C-W>T", {silent = true})

-- tab
vim.cmd([[
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    vs
  else
    close!
    exe "0tabnew"
  endif
 "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    vs
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
]])
vim.keymap.set({"n"}, "T", ":silent! -tabmove<cr>", {silent = true})
vim.keymap.set({"n"}, "H", ":silent! +tabmove<cr>", {silent = true})
vim.keymap.set({"n"}, "h", "<cmd>tabnext<cr>", {silent = true})
vim.keymap.set({"n"}, "t", "<cmd>tabprev<cr>", {silent = true})
vim.keymap.set({"n"}, "gxx", "<cmd>tabonly<cr>", {silent = true})
-- vim.keymap.set({"n"}, "gx$", "<cmd>-10tabonly<cr>", {silent = true})
-- vim.keymap.set({"n"}, "gx^", "<cmd>10tabonly<cr>", {silent = true})
vim.keymap.set({"n"}, "<space>mt", "<C-W>T", {silent = true})
vim.keymap.set({"n"}, "<space>mj", "<cmd>call MoveToPrevTab()<cr>",
               {silent = true})
vim.keymap.set({"n"}, "<space>mö", "<cmd>call MoveToNextTab()<cr>",
               {silent = true})

-- folds
vim.cmd([[
function! NextClosedFold(dir)
    let cmd = 'norm!z'..a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
function! NextClosedFoldOrFoldable(dir)
    let cmd = 'norm!z'..a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    let l_closed = l
    let l_foldable = search('\v^[^-]', 'Wn', line('.') + (a:dir == 'j' ? 1 : -1))
    if l_foldable <= 0
        call winrestview(view)
    else
        let closest = min([l_closed, l_foldable])
        exe closest == l_closed ? cmd : 'norm!'.closest
        call winrestview(view)
    endif
endfunction
nnoremap <silent> <C-k> :call NextClosedFold('j')<cr>zz
nnoremap <silent> <C-l> :call NextClosedFold('k')<cr>zz
nnoremap <silent> <C-h> :call NextClosedFoldOrFoldable('k')<cr>zz
" nnoremap <expr> <c-space> &foldlevel ? 'zMzz' :'zRzz'
nnoremap <silent> <space>x <space>
]])
vim.keymap.set('n', 'Å', 'zR')
vim.keymap.set('n', 'Ä', 'zM')
vim.keymap.set({"n"}, "å", "<cmd>silent! normal! zo<cr>", {silent = true})
vim.keymap.set({"n"}, "ä", "<cmd>silent! normal! zc<cr>", {silent = true})

-- window manip

-- -- tagbar
-- vim.cmd([[
-- let g:tagbar_map_nexttag = 'K'
-- let g:tagbar_map_prevtag = 'L'
-- ]])
-- -- vim.keymap.set({"n", "x"}, "<C-t>", "<cmd>TagbarToggle fjc<cr>", {silent = true})
-- vim.keymap.set({"n", "x"}, "<MB>", "<cmd>TagbarToggle fjc<cr>", {silent = true})
-- vim.keymap.set({"n", "x"}, "s", "<Plug>Lightspeed_omni_s", {silent = true})
-- vim.keymap.set({"n", "x"}, "s", "<Plug>(leap-backward-to)", {silent = true})
require('flit').setup {
    keys = {f = 'f', F = 'F', t = '<C-f>', T = '<C-F>'},
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = "v",
    multiline = true,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {}
}
vim.keymap.set({"n", "x"}, "s", function()
    local current_window = vim.fn.win_getid()
    require('leap').leap {target_windows = {current_window}}
end, {silent = true})
-- vim.keymap.set({"n", "x"}, "f", "<Plug>(leap-forward-to)", {silent = true})
-- vim.keymap.set({"n", "x"}, "f", "<Plug>(leap-from-window)", {silent = true})
-- undotree
vim.keymap.set({"n"}, "<space>u", "<cmd>UndotreeToggle<cr>", {silent = true})

-- aerial
require('aerial').setup({
    keymaps = {
        ["l"] = false,
        ["h"] = "actions.tree_open",
        ["H"] = "actions.tree_open_all",
        ["t"] = "actions.tree_close",
        ["T"] = "actions.tree_close_all"
    },
    manage_folds = true,
    layout = {width = 15, default_direction = "left", placement = "edge"},
    highlight_on_hover = true,
    show_guides = true,
    open_automatic = false,
    attach_mode = "global",
    lazy_load = false,
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
    end
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set('n', '<space>a', '<cmd>AerialToggle!<CR>')

-- hotkeys
vim.keymap.set({"n"}, "Q", "<nop>", {silent = true}) -- quick visual mode edit
vim.keymap.set({"x"}, "@", ":normal @", {silent = true}) -- quick visual mode edit
vim.keymap.set({"n"}, "_", "@@", {silent = true}) -- quick visual mode edit
vim.keymap.set({"i"}, "<C-Backspace>", '<C-o>:normal "_x<cr>', {silent = true}) -- insert delete char after cursor
vim.keymap.set({"i"}, "<C-Return>", "<c-o>o", {noremap = true}) -- void deleted char
vim.keymap.set({"n"}, "<C-p>", '"*p', {silent = true}) -- paste +
vim.keymap.set({"i"}, "<C-p>", '<Escape>"*pa', {silent = true}) -- insert paste +
-- vim.keymap.set({"i"}, "a>", "<c-o>:normal $<cr>", {silent = true}) -- insert paste +
vim.keymap.set({"x"}, "<C-y>", '"+ygv"*y', {silent = true}) -- yank +
vim.keymap.set({"x"}, "<C-p>", '"*p', {silent = true}) -- yank +
vim.keymap.set({"n"}, "<C-y>", '"+ygv"*yw', {silent = true}) -- yank word +
vim.keymap.set({"n"}, "x", '"_x', {noremap = true}) -- void deleted char
vim.keymap.set({"x"}, "<space>p", "\"_dP", {noremap = true}) -- void deleted char
-- vim.keymap.set({"n"}, "gp", "`[v`]", {noremap = true}) -- void deleted char
vim.keymap.set({"n"}, "<space>v", "^vg_", {noremap = true}) -- visual line without \n
vim.keymap.set({"n"}, "<space>yf",
               "<cmd>!echo %:p | xclip -selection clipboard<cr><cr>", {}) -- yank line without \n
vim.keymap.set({"n"}, "<space>yd", "^vg_y$", {noremap = true}) -- yank line without \n
vim.keymap.set({"n"}, "<space>dd", '^vg_d"_dd', {noremap = true}) -- yank line without \n
vim.keymap.set({"n"}, "<space>da", "GVggd", {noremap = true}) -- yank line without \n
vim.keymap.set({"n"}, "<space>ca", "GVggc", {noremap = true}) -- yank line without \n
vim.keymap.set({"n"}, "<space>ya", 'GVgg"+y', {noremap = true}) -- yank line without \n
vim.keymap.set({"n"}, "<space>o", "O<C-j>", {noremap = true}) -- void deleted char
vim.keymap.set({"v"}, "<space>co",
               'm9yO<Escape>P`[v`]<cmd>call nvim_feedkeys("gcÅ9", "v", v:false)<cr>',
               {silent = true}) -- duplicate lines
vim.keymap.set({"n"}, "<space>co",
               'm9VyP`[v`]<cmd>call nvim_feedkeys("gcÅ9", "v", v:false)<cr>',
               {silent = true}) -- duplicate line
vim.keymap.set({"n"}, "<space>.", "q::resize 20<cr>", {})
vim.keymap.set({"n"}, "<space>:", "q::resize 20<cr>", {})
vim.keymap.set({"n", "x"}, "<space>t", "<cmd>tabnew<cr>", {silent = true})
vim.keymap.set({"n", "x"}, "<space>s", "<cmd>vsplit<cr>", {silent = true})
vim.keymap.set({"n", "x"}, "<space>h", "<cmd>split<cr>", {silent = true})
vim.keymap.set({"n"}, "<space>J", "<C-W>H", {silent = true}) -- move split
vim.keymap.set({"n"}, "<space>K", "<C-W>J", {silent = true})
vim.keymap.set({"n"}, "<space>L", "<C-W>K", {silent = true})
vim.keymap.set({"n"}, "<space>Ö", "<C-W>L", {silent = true})
vim.keymap.set({"n"}, "<S-space>J", "<C-W>H", {silent = true})
vim.keymap.set({"n"}, "<S-space>K", "<C-W>J", {silent = true})
vim.keymap.set({"n"}, "<S-space>L", "<C-W>K", {silent = true})
vim.keymap.set({"n"}, "<S-space>Ö", "<C-W>L", {silent = true})
vim.keymap.set({"n"}, "<space>q", "<cmd>q<cr>", {silent = true})
vim.keymap.set({"n"}, "<space><space>c", cs.next_colorscheme, {silent = false})
-- vim.keymap.set({"n"}, "<space>qs", "<cmd>w<bar>bdelete<cr>", {silent = true})
-- vim.keymap.set({"n"}, "<space>qa", "<cmd>qa<cr>", {silent = true})
-- vim.keymap.set({"n"}, "<space>wa", "<cmd>wa<cr>", {silent = true})
-- vim.keymap.set({"n"}, "<space>qx", "<cmd>bdelete!<bar>q<cr>", {silent = true})
-- vim.keymap.set({"n"}, "<c-f>",
--                '<cmd>!ps aux | grep -E \'/home/sabo/scripts/ranger.sh$\' | awk \'{print $2}\'|sed \'$d\' |xargs -I {} kill -9 {} ; setsid -f st -t "ranger" -e sh -c \'cd %:p:h && /home/sabo/scripts/ranger.sh\'<cr><cr>',
--                {silent = true}) -- kill ranger session and open ranger where file located
vim.keymap.set({"n"}, "<C-s>", ":%s/", {noremap = true}) -- search and replace -- default is last /
vim.keymap.set({"v"}, "<C-s>", ":s/", {noremap = true}) -- search and replace -- default is last /
vim.keymap.set({"i", "s"}, "<tab>", "<cmd>lua util.tabcontext()<cr>",
               {silent = true})
-- vim.cmd([[inoremap <expr> <C-Tab> delimitMate#JumpAny()]])
vim.keymap.set({"i"}, "<C-§>", "<tab>", {silent = true})
vim.keymap.set({"i"}, "§", "<c-o>a", {silent = true})
vim.keymap.set({"n"}, "§", "l", {silent = true})
vim.keymap.set({"i"}, "¶", "<c-o>a", {silent = true})
vim.keymap.set({"n"}, "¶", "l", {silent = true})
-- vim.keymap.set("i", "<C-tab>", "<esc>:exe 'norm! l%%'<CR>a", {silent = true})

-- files
vim.keymap.set({"n"}, "<space>j",
               "<cmd>silent! !setsid -f kitty -d \"%:p:h\"<cr>")
-- vim.keymap.set({"n"}, "<c-c>", "<cmd>lua picker_.project_root_finder()<cr>")
vim.keymap.set({"n"}, "<space>ff",
               "<cmd>lua require'telescope.builtin'.git_files{}<cr>")
vim.keymap.set({"n"}, "<space>fn",
               "<cmd>lua require'telescope.builtin'.git_files{cwd = '/home/sabo/.config/nvim'}<cr>")
vim.keymap.set({"n"}, "<space>fr",
               "<cmd>lua require'telescope.builtin'.live_grep{}<cr>")
vim.keymap.set({"n"}, "<space>fb",
               "<cmd>lua require'telescope.builtin'.buffers{}<cr>")
-- telescope
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local actions_set = require("telescope.actions.set")
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<c-p>"] = action_layout.toggle_preview,
                ["<c-l>"] = actions.move_selection_previous,
                ["<c-k>"] = actions.move_selection_next,
                ["<c-s>"] = actions.file_vsplit,
                ["<c-h>"] = actions.file_split,
                ["<c-t>"] = actions.file_tab
            },
            n = {
                ["<esc>"] = actions.close,
                ["<c-p>"] = action_layout.toggle_preview,
                ["<c-l>"] = actions.move_selection_previous,
                ["<c-k>"] = actions.move_selection_next,
                ["<c-s>"] = actions.file_vsplit,
                ["<c-t>"] = actions.file_tab
            }
        }
    }
}

-- debug
-- vim.keymap.set({"n"}, "<space>fö", "<cmd>lua lib.printTabWinNames()<cr>", {silent = true})
-- vim.keymap.set({"n"}, "<space>fl", "<cmd>lua lib.printWinNames()<cr>", {silent = true})
-- vim.keymap.set({"n"}, "<space>fp", "<cmd>lua lib.printBaseTabWinNames()<cr>", {silent = true})
-- vim.keymap.set({"n"}, "<space>fo", "<cmd>lua lib.printBaseWinNames()<cr>", {silent = true})
-- vim.keymap.set({"n"}, "<space>fi", "<cmd>lua lib.printWinBufs()<cr>", {silent = true})
-- vim.keymap.set({"n"}, " ft", "<cmd>lua lib.test()<cr>", {noremap = true}) -- yank line without \n
-- vim.keymap.set({"n"}, "<C-r>", "<cmd>lua lib.reload_file()<cr>", {noremap = true}) -- yank line without \n

-- cmp
cmp.setup({
    mapping = {
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}),
        ["<C-l>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "c"}),
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm({select = false}), {"i"}),
        ["<C-CR>"] = cmp.mapping(cmp.mapping.confirm({select = true}),
                                 {"i", "s"}),
        ["<C-space>"] = cmp.mapping(cmp.mapping.confirm({select = true}),
                                    {"i", "s", "c"}),
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
        end, {"i", "s"})
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
})
vim.keymap.set({"i", "s"}, "<C-Tab>", "<Plug>luasnip-next-choice", {})

-- re-source
vim.keymap.set({"n"}, "<space><space>p",
               '<cmd>source ~/.config/nvim/lua/snippets.lua | echo "sourced snippets" | source ~/.config/nvim/lua/plugins.lua | echo "sourced plugins" | PackerSync<cr>',
               {noremap = true})
vim.keymap.set({"n"}, "<space><space>s",
               '<cmd>source ~/.config/nvim/lua/snippets.lua | echo "sourced snippets"<cr>',
               {noremap = true})

-- CHATGPT
-- vim.keymap.set({"n"}, "<space>g", '<cmd>ChatGPT<cr>', {noremap = true})
-- vim.keymap.set({"n"}, "<space>G", '<cmd>ChatGPTActAs<cr>', {noremap = true})
--
-- require("chatgpt").setup({
--     welcome_message = "~", -- set to "" if you don't like the fancy godot robot
--     loading_text = "loading",
--     question_sign = "", -- you can use emoji if you want e.g. 🙂
--     answer_sign = "ﮧ", -- 🤖
--     max_line_length = 120,
--     yank_register = "+",
--     chat_layout = {relative = "editor", position = "50%", size = {height = "80%", width = "80%"}},
--     settings_window = {border = {style = "rounded", text = {top = " Settings "}}},
--     chat_window = {
--         filetype = "chatgpt",
--         border = {highlight = "FloatBorder", style = "rounded", text = {top = " ChatGPT "}},
--     },
--     chat_input = {
--         prompt = "  ",
--         border = {
--             highlight = "FloatBorder",
--             style = "rounded",
--             text = {top_align = "center", top = " Prompt "},
--         },
--     },
--     openai_params = {
--         model = "text-davinci-003",
--         frequency_penalty = 0,
--         presence_penalty = 0,
--         max_tokens = 300,
--         temperature = 0,
--         top_p = 1,
--         n = 1,
--     },
--     openai_edit_params = {model = "code-davinci-edit-001", temperature = 0, top_p = 1, n = 1},
--     keymaps = {
--         close = {"<C-c>", "<Esc>"},
--         yank_last = "<C-y>",
--         scroll_up = "<C-u>",
--         scroll_down = "<C-d>",
--         toggle_settings = "<C-o>",
--  new_session = "<C-n>",
--         cycle_windows = "<Tab>",
--     },
-- })

-- terminal-emulator
-- vim.keymap.set({"n", "t"}, "<F1>", "<cmd>lua lib.terminalScratchPad()<cr>", {silent = true})
-- vim.keymap.set({"n", "t"}, "<C-F1>", "<cmd>lua lib.terminalNewSessionFeedKeys()<cr>", {
--     silent = true,
-- })

-- terminal emulator
require("toggleterm").setup {}
vim.keymap.set({"v"}, "<F1>", ":ToggleTermSendVisualSelection 1<cr>",
               {silent = true})
vim.keymap.set({"v"}, "<F2>", ":ToggleTermSendVisualSelection 2<cr>",
               {silent = true})
vim.keymap.set({"n", "t"}, "<c-f>", "<cmd>ToggleTerm 3 size=33<cr>",
               {silent = true})
vim.keymap.set({"n", "t"}, "<F1>", "<cmd>ToggleTerm 1 size=25<cr>",
               {silent = true})
vim.keymap.set({"n", "t"}, "<F2>", "<cmd>ToggleTerm 2 size=25<cr>",
               {silent = true})

vim.keymap.set({"t"}, "<C-e>", "<C-\\><C-n>", {})
vim.keymap.set({"t"}, "<C-,>", "<C-\\><C-n><C-D>zz", {})
vim.keymap.set({"t"}, "<C-.>", "<C-\\><C-n><C-U>zz", {})
vim.keymap.set({"t"}, "<C-7>", "<C-\\>", {})
vim.keymap.set({"t"}, "<C-p>", '<C-\\><C-n>"+pa', {})
vim.keymap.set({"t"}, "<s-space>", "<Nop>", {})

-- sniprun
vim.keymap.set({"v"}, "<F3>", ":SnipRun<cr>", {silent = true})
vim.keymap.set({"n"}, "<F3>", "<cmd>SnipClose<cr>", {silent = true})

--------------------
----- cabbrev ------
--------------------

vim.cmd([[
    " cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'
    " cnoreabbrev <expr> help getcmdtype() == ":" && getcmdline() == 'help' ? 'tab help' : 'help'
    " cabbrev W w!
    " cabbrev w w!
    cabbrev W lua util.sleep(10)
    cabbrev w lua util.sleep(10)
    cabbrev Q q
    cabbrev E\  e\ 
    cabbrev Qa qa
    cabbrev qA qa
    cabbrev QA qa
    cabbrev Wq wq
    cabbrev wQ wq
    cabbrev man lua util.manpager("")<Left><Left>
    cabbrev help vert help
    cabbrev h vert h
]])
