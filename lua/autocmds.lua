local util = require('lib_util')
--------------------
----- autocmd ------
--------------------
local key_Escape = v.nvim_replace_termcodes("<Escape>", true, false, true)
local FileTypeCompile = v.nvim_create_augroup("FileTypeCompile", {clear = true})
local MainGroup = v.nvim_create_augroup("MainGroup", {clear = true})
local CustomFileType = v.nvim_create_augroup("MainGroup", {clear = true})

-- NOTES
foreground = "#c8ccd5"
background = "#2e3341"
black1 = "#2e3341"
black2 = "#6a7880"
red1 = "#C4434E"
red2 = "#c46a72"
green1 = "#a9c2a2"
green2 = "#a9c2a2"
yellow1 = "#f2d8a7"
yellow2 = "#F2E9D7"
blue1 = "#5C7BB6"
blue2 = "#6F87B6"
blue3 = "#8193B6"
magenta1 = "#ba9db8"
magenta2 = "#F2D4F0"
cyan1 = "#9ea6b7"
cyan3 = "#369ec4"
white1 = "#c8ccd5"
white2 = "#f5f7fa"
pink = "#ab75bd"
latex = "#7578d7"

-- note syntax
v.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    callback = function()
        -- fname = vim.fn.expand("%:t")
        -- vim.cmd("!notify-send " .. fname)
        if string.sub(vim.fn.expand("%:t"), 1, 1) == "." then
            return
        elseif vim.fn.expand("%:t") == "wrappedhl" then
            return
        elseif vim.fn.expand("%:e") == "" or vim.fn.expand("%:e") == "note" then
            vim.cmd("set filetype=note")
            vim.cmd("set commentstring=#%s")
            vim.cmd("syntax region note_object start=/^ *- / end=/$/")
            vim.cmd(
                "syntax region note_subtitle start=/^ *--[^-]/ end=/ -- *$\\|$/")
            vim.cmd("syntax region note_title start=/^ *--- / end=/ --- *$\\|$/")
            vim.cmd(
                "syntax match note_title2 \"--- \\a.*\\a ---\"ms=s+4,me=e-4 containedin=note_title")
            vim.cmd(
                "syntax match note_numlist \"^ *[0-9]\\+\\(\\.\\?\\)-\\?[0-9]*\\.\\( \\|$\\)\"")
            vim.cmd("syntax match note_list \"^.*:$\"")
            vim.cmd("syntax match note_angle_bracket \"<.*>\" containedin=ALL")
            vim.cmd("syntax match note_comment /%#.*$/")
            vim.cmd(
                "syntax match note_quote /\".*\"\\|\'.*\'/ms=s+1,me=e-1 containedin=note_title")
            -- vim.cmd("syntax match note_comment \"\\(?i\\)m.*$\"")
            vim.cmd(
                "syntax match note_url /\\zs\\%(\\%(\\%(s\\?ftp\\|https\\?\\):\\/\\/\\)\\|\\%(www\\.\\)\\|\\%([\\._\\-+0-9a-z]\\+\\%(:[^@]*\\)\\?@\\)\\)\\%([0-9a-z_\\-\\.]\\+\\)\\?\\.\\%(\\%([a-zA-Z\\-\\.]\\{2,10}\\)\\|[0-9]\\{1,3}\\)\\%(:[0-9]*\\)\\?\\%(\\(\\/\\|?\\)[a-zA-Z0-9_\\-\\.\\/?&=#;]\\+\\)\\?\\%(?\\=[^a-zA-Z0-9_\\-\\.\\/?&=#;]\\|\\s\\|$\\)/")
            vim.cmd(
                "syntax match note_paren \"([^()]*)\" containedin=ALLBUT,note_def,note_ex")
            vim.cmd("syntax match note_bracket \"\\[[^\\[\\]]*\\]\"")
            vim.cmd("syntax match note_def \"(=[^()]*)\" containedin=ALL")
            vim.cmd("syntax match note_ex \"(ex\\.[^()]*)\" containedin=ALL")
            vim.cmd("syntax match note_ex_line /^ *ex\\./")
            -- vim.cmd("syntax match note_ref \".* -> .*\"")
            -- vim.cmd("syntax match note_ref2 \"->.*$\" containedin=note_ref")
            -- vim.cmd("syntax match note_ref3 \"-->.*$\" containedin=note_ref,note_ref2")
            vim.cmd("highlight note_title gui=italic cterm=italic guifg=" ..
                        red1)
            vim.cmd(
                "highlight note_title2 gui=italic,underline cterm=italic guifg=" ..
                    red1)
            vim.cmd("highlight note_subtitle gui=italic cterm=italic guifg=" ..
                        red2)
            vim.cmd("highlight note_object guifg=" .. yellow2)
            vim.cmd("highlight note_list  gui=italic cterm=italic guifg=" ..
                        yellow1)
            vim.cmd("highlight link note_comment Comment")
            vim.cmd("highlight note_quote gui=italic cterm=italic")
            vim.cmd("highlight note_url guifg=" .. magenta1)
            vim.cmd("highlight note_numlist guifg=" .. yellow1)
            -- vim.cmd("highlight note_ref  guifg=" .. blue1)
            -- vim.cmd("highlight note_ref2  gui=italic cterm=italic guifg=" .. blue2)
            -- vim.cmd("highlight note_ref3  gui=italic cterm=italic guifg=" .. blue3)
            vim.cmd("highlight note_paren guifg=" .. cyan1)
            vim.cmd("highlight note_bracket guifg=" .. cyan1)
            vim.cmd("highlight note_def guifg=" .. green1)
            vim.cmd("highlight note_angle_bracket guifg=" .. blue2)
            vim.cmd("highlight note_ex guifg=" .. pink)
            vim.cmd("highlight note_ex_line guifg=" .. pink)
            -- conceal
            vim.cmd("setlocal conceallevel=2")
            vim.cmd("setlocal concealcursor=ivc")
            vim.cmd("highlight Conceal guifg=" .. latex)
            vim.cmd("syntax match note_symbol_arrow \"->\" containedin=ALL")
            vim.cmd("highlight note_symbol_arrow guifg=" .. latex)
            vim.cmd("syntax match note_symbol_defined_as \":=\" containedin=ALL")
            vim.cmd("highlight note_symbol_defined_as guifg=" .. latex)
            vim.cmd(
                "syntax match note_symbol_negation \" ![^ $]\"ms=s+1,me=e-1 containedin=ALL")
            vim.cmd("highlight note_symbol_negation guifg=" .. red1)
            -- vim.cmd("syntax match note_symbol_plus \" + \" containedin=ALL")
            -- vim.cmd("highlight note_symbol_plus guifg=" .. latex)
            -- vim.cmd("syntax match note_symbol_minus \" -[^ ]\"ms=s+1,me=e-1 containedin=ALL")
            -- vim.cmd("highlight note_symbol_minus guifg=" .. latex)
            -- vim.cmd("syntax match note_symbol_multiply \" \\* \" containedin=ALL")
            -- vim.cmd("highlight note_symbol_multiply guifg=" .. latex)
            -- vim.cmd("syntax match note_symbol_divide \" / \" containedin=ALL")
            -- vim.cmd("highlight note_symbol_divide guifg=" .. latex)
            -- vim.cmd("syntax match note_symbol_power \" \\^ \" containedin=ALL")
            -- vim.cmd("highlight note_symbol_power guifg=" .. latex)
            vim.cmd("syntax match note_symbol_and \" && \" containedin=ALL")
            vim.cmd("highlight note_symbol_and guifg=" .. latex)
            vim.cmd("syntax match note_symbol_or \" || \" containedin=ALL")
            vim.cmd("highlight note_symbol_or guifg=" .. latex)
            vim.cmd(
                "syntax match note_latex_forall /\\\\forall/ conceal cchar=∀")
            vim.cmd(
                "syntax match note_latex_exists /\\\\exists/ conceal cchar=∃")
            vim.cmd("syntax match note_latex_and /\\\\land/ conceal cchar=∧")
            vim.cmd("syntax match note_latex_or /\\\\lor/ conceal cchar=∨")
            vim.cmd("syntax match note_latex_not /\\\\lnot/ conceal cchar=¬")
            vim.cmd(
                "syntax match note_latex_implies /\\\\implies/ conceal cchar=⇒")
            vim.cmd("syntax match note_latex_iff /\\\\iff/ conceal cchar=⇔")
            vim.cmd(
                "syntax match note_latex_subset /\\\\subset/ conceal cchar=⊂")
            vim.cmd(
                "syntax match note_latex_superset /\\\\supset/ conceal cchar=⊃")
            vim.cmd("syntax match note_latex_union /\\\\cup/ conceal cchar=∪")
            vim.cmd(
                "syntax match note_latex_intersection /\\\\cap/ conceal cchar=∩")
            vim.cmd(
                "syntax match note_latex_subseteq /\\\\subseteq/ conceal cchar=⊆")
            vim.cmd(
                "syntax match note_latex_supseteq /\\\\supseteq/ conceal cchar=⊇")
            vim.cmd(
                "syntax match note_latex_emptyset /\\\\emptyset/ conceal cchar=∅")
            vim.cmd("syntax match note_latex_element /\\\\in/ conceal cchar=∈")
            vim.cmd(
                "syntax match note_latex_notelement /\\\\notin/ conceal cchar=∉")
            vim.cmd("syntax match note_latex_natural /\\\\gN/ conceal cchar=ℕ")
            vim.cmd("syntax match note_latex_integer /\\\\gZ/ conceal cchar=ℤ")
            vim.cmd(
                "syntax match note_latex_rational /\\\\gQ/ conceal cchar=ℚ")
            vim.cmd("syntax match note_latex_real /\\\\gR/ conceal cchar=ℝ")
            vim.cmd("syntax match note_latex_complex /\\\\gC/ conceal cchar=ℂ")
            vim.cmd(
                "syntax match note_latex_quaternion /\\\\gH/ conceal cchar=ℍ")
            vim.cmd(
                "syntax match note_latex_polynomial /\\\\gP/ conceal cchar=ℙ")
            -- greek
            vim.cmd("syntax match note_latex_alpha /\\\\alpha/ conceal cchar=α")
            vim.cmd("syntax match note_latex_beta /\\\\beta/ conceal cchar=β")
            vim.cmd("syntax match note_latex_gamma /\\\\gamma/ conceal cchar=γ")
            vim.cmd("syntax match note_latex_delta /\\\\delta/ conceal cchar=δ")
            vim.cmd(
                "syntax match note_latex_epsilon /\\\\epsilon/ conceal cchar=ε")
            vim.cmd("syntax match note_latex_zeta /\\\\zeta/ conceal cchar=ζ")
            vim.cmd("syntax match note_latex_eta /\\\\eta/ conceal cchar=η")
            vim.cmd("syntax match note_latex_theta /\\\\theta/ conceal cchar=θ")
            vim.cmd("syntax match note_latex_iota /\\\\iota/ conceal cchar=ι")
            vim.cmd("syntax match note_latex_kappa /\\\\kappa/ conceal cchar=κ")
            vim.cmd(
                "syntax match note_latex_lambda /\\\\lambda/ conceal cchar=λ")
            vim.cmd("syntax match note_latex_mu /\\\\mu/ conceal cchar=μ")
            vim.cmd("syntax match note_latex_nu /\\\\nu/ conceal cchar=ν")
            vim.cmd("syntax match note_latex_xi /\\\\xi/ conceal cchar=ξ")
            vim.cmd(
                "syntax match note_latex_omicron /\\\\omicron/ conceal cchar=ο")
            vim.cmd("syntax match note_latex_pi /\\\\pi/ conceal cchar=π")
            vim.cmd("syntax match note_latex_rho /\\\\rho/ conceal cchar=ρ")
            vim.cmd("syntax match note_latex_sigma /\\\\sigma/ conceal cchar=σ")
            vim.cmd("syntax match note_latex_tau /\\\\tau/ conceal cchar=τ")
            vim.cmd(
                "syntax match note_latex_upsilon /\\\\upsilon/ conceal cchar=υ")
            vim.cmd("syntax match note_latex_phi /\\\\phi/ conceal cchar=φ")
            vim.cmd("syntax match note_latex_chi /\\\\chi/ conceal cchar=χ")
            vim.cmd("syntax match note_latex_psi /\\\\psi/ conceal cchar=ψ")
            vim.cmd("syntax match note_latex_omega /\\\\omega/ conceal cchar=ω")
            vim.cmd("syntax match note_latex_sum /\\\\sum/ conceal cchar=Σ")
            vim.cmd("syntax match note_latex_prod /\\\\prod/ conceal cchar=Π")
            vim.cmd(
                "syntax match note_latex_coproduct /\\\\coprod/ conceal cchar=∐")
            vim.cmd(
                "syntax match note_latex_integrals /\\\\int/ conceal cchar=∫")
            vim.cmd(
                "syntax match note_latex_double_integrals /\\\\iint/ conceal cchar=∬")
            vim.cmd(
                "syntax match note_latex_triple_integrals /\\\\iiint/ conceal cchar=∭")
            vim.cmd(
                "syntax match note_latex_partial_derivative /\\\\partial/ conceal cchar=∂")
            vim.cmd(
                "syntax match note_latex_nabla /\\\\nabla/ conceal cchar=∇")
            vim.cmd(
                "syntax match note_latex_infinity /\\\\infty/ conceal cchar=∞")
            vim.cmd(
                "syntax match note_latex_angle /\\\\angle/ conceal cchar=∠")
            vim.cmd(
                "syntax match note_latex_propto /\\\\propto/ conceal cchar=∝")
            vim.cmd(
                "syntax match note_latex_approx /\\\\approx/ conceal cchar=≈")
            vim.cmd(
                "syntax match note_latex_equiv /\\\\equiv/ conceal cchar=≡")
            vim.cmd("syntax match note_latex_neq /\\\\neq/ conceal cchar=≠")
            vim.cmd("syntax match note_latex_geq /\\\\geq/ conceal cchar=≥")
            vim.cmd("syntax match note_latex_leq /\\\\leq/ conceal cchar=≤")
            vim.cmd(
                "syntax match note_latex_therefore /\\\\therefore/ conceal cchar=∴")
            vim.cmd(
                "syntax match note_latex_such_that /\\\\because/ conceal cchar=∵")
            vim.cmd("syntax match note_latex_qed /\\\\qed/ conceal cchar=□")
            vim.cmd(
                "syntax match note_latex_parallel /\\\\parallel/ conceal cchar=∥")
            vim.cmd(
                "syntax match note_latex_not_parallel /\\\\nparallel/ conceal cchar=∦")
            vim.cmd(
                "syntax match note_latex_similar /\\\\sim/ conceal cchar=∼")
            vim.cmd(
                "syntax match note_latex_congruent /\\\\cong/ conceal cchar=≅")
            vim.cmd(
                "syntax match note_latex_aleph /\\\\aleph/ conceal cchar=ℵ")
            vim.cmd(
                "syntax match note_latex_dagger /\\\\dagger/ conceal cchar=†")
            vim.cmd(
                "syntax match note_latex_ddagger /\\\\ddagger/ conceal cchar=‡")
            -- code blocks
            -- vim.cmd(
            --     "syntax include @java syntax/java.vim")
            -- vim.cmd(
            --     "syntax region javaCode start='JAVA' end='JAAVA' contains=@java")
            vim.cmd("syntax include @java syntax/java.vim")
            vim.cmd(
                "syntax region javaCode start=|\\~java| end=|\\~\\~| contains=@java")
        end
    end,
    pattern = "*",
    group = CustomFileType
})

-- PERL
v.nvim_create_autocmd({"FileType"}, {
    callback = function()
        v.nvim_buf_set_keymap(0, "n", "<F5>", "<cmd>w<cr><cmd>!perl %<cr>",
                              {noremap = true})
        v.nvim_buf_set_keymap(0, "n", "<F4>",
                              "<cmd>w<cr><cmd>!perltidy -ci=4 -ce -l=160 -lp -cti=1 -vtc=1 -sot -nsfs -nolq -pt=2 -b %<cr><cmd>!rm -f %.bak<cr>",
                              {noremap = true})
    end,
    pattern = "perl",
    group = FileTypeCompile
})

-- PYTHON
v.nvim_create_autocmd({"FileType"}, {
    callback = function()
        v.nvim_buf_set_keymap(0, "n", "<F6>",
                              "<cmd>w!<cr><cmd>lua util.terminalNewSessionExec(\"python3 %\")<cr>",
                              {noremap = true})
        v.nvim_buf_set_keymap(0, "n", "<F5>", "<cmd>w<cr><cmd>!python3 %<cr>",
                              {noremap = true})
        v.nvim_buf_set_keymap(0, "n", "<F4>",
                              "<cmd>w<cr><cmd>!yapf -i --style=\"{based_on_style: pep8, indent_width: 4, column_limit: 160 }\" %<cr>",
                              {noremap = true})
    end,
    pattern = "python",
    group = FileTypeCompile
})

-- SHELL
v.nvim_create_autocmd({"FileType"}, {
    callback = function()
        v.nvim_buf_set_keymap(0, "n", "<F5>",
                              "<cmd>w<cr><cmd>!chmod +x %<cr><cmd>!./%<cr>",
                              {noremap = true})
        v.nvim_buf_set_keymap(0, "n", "<F4>",
                              "<cmd>w<cr><cmd>!shfmt -i 4 -w %<cr><cmd>e<cr>",
                              {noremap = true})
    end,
    pattern = "sh",
    group = FileTypeCompile
})

-- CPP
v.nvim_create_autocmd({"FileType"}, {
    callback = function()
        v.nvim_buf_set_keymap(0, "n", "<F4>",
                              "<cmd>w<cr><cmd>!astyle --style=attach --pad-comma --pad-oper --unpad-paren --delete-empty-lines --align-pointer=name --align-reference=name --break-one-line-headers --add-braces --attach-return-type --convert-tabs --close-templates --remove-comment-prefix --max-code-length=160 --break-after-logical %<cr><cmd>e<cr>",
                              {noremap = true})
    end,
    pattern = "cpp",
    group = FileTypeCompile
})

-- C
v.nvim_create_autocmd("FileType", {

    callback = function()
        local gccout = "./a.out"
        local gccparam = "-std=c99 -Wall -pedantic -g -o " .. gccout
        local valparam =
            "valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes -v"

        function compileC()
            vim.cmd("!bear -- gcc " .. gccparam .. " % > /dev/null; gcc " ..
                        gccparam .. " %")
        end

        function execC()
            util.terminalNewSessionExec("bear -- gcc " .. gccparam ..
                                           " % > /dev/null; gcc " .. gccparam ..
                                           " % && " .. gccout)
        end

        function execCwParams()
            util.terminalNewSessionFeedKeys(gccout .. " ")
        end

        function execValgrind()
            util.terminalNewSessionFeedKeys(valparam .. " " .. gccout .. " ")
        end

        v.nvim_buf_set_keymap(0, "n", "<F4>",
                              "<cmd>w<cr><cmd>!astyle --style=attach --pad-comma --pad-oper --unpad-paren --delete-empty-lines --align-pointer=name --align-reference=name --break-one-line-headers --add-braces --attach-return-type --convert-tabs --close-templates --remove-comment-prefix --max-code-length=160 --break-after-logical %<cr><cmd>e<cr>",
                              {noremap = true})
        v.nvim_buf_set_keymap(0, "n", "<F5>", "<cmd>lua execC()<cr>",
                              {noremap = true})
        v.nvim_buf_set_keymap(0, "n", "<C-F5>", "<cmd>lua execCwParams()<cr>",
                              {noremap = true})
        v.nvim_buf_set_keymap(0, "n", "<F6>", "<cmd>lua execValgrind()<cr>",
                              {noremap = true})
    end,
    pattern = "c",
    group = FileTypeCompile
})

-- JAVA
v.nvim_create_autocmd({"FileType"}, {
    callback = function()
        v.nvim_buf_set_keymap(0, "n", "<F6>",
                              "<cmd>w!<cr><cmd>lua util.terminalNewSessionExec(\"java %\")<cr>",
                              {noremap = true})
        v.nvim_buf_set_keymap(0, "n", "<F5>", "<cmd>w!<cr><cmd>!java %<cr>",
                              {noremap = true})
        v.nvim_buf_set_keymap(0, "n", "<F4>",
                              "<cmd>w!<cr><cmd>!astyle --style=attach --pad-comma --pad-oper --unpad-paren --delete-empty-lines --align-pointer=type --align-reference=name --break-one-line-headers --add-braces --attach-return-type --convert-tabs --close-templates --remove-comment-prefix --max-code-length=160 --break-after-logical %<cr><cmd>e<cr>",
                              {noremap = true})
    end,
    pattern = "java",
    group = FileTypeCompile
})

-- LUA
v.nvim_create_autocmd({"FileType"}, {
    callback = function()
        v.nvim_buf_set_keymap(0, "n", "<F5>", "<cmd>w<cr><cmd>!lua %<cr>",
                              {noremap = true})
        if util.get_filename(0) == "snippets.lua" then
            v.nvim_buf_set_keymap(0, "n", "<F4>",
                                  "<cmd>w<cr><cmd>!lua-format --in-place --indent-width=4 --column-limit=160 --tab-width=4 --no-use-tab --continuation-indent-width=4 --align-parameter --align-args --align-table-field --no-keep-simple-control-block-one-line --no-keep-simple-function-one-line --extra-sep-at-table-end --table-sep=\",\"  --column-table-limit=1 --break-before-table-rb --break-after-table-lb --chop-down-parameter --chop-down-table %<cr><cmd>e<cr>",
                                  {noremap = true})
        else
            v.nvim_buf_set_keymap(0, "n", "<F4>",
            -- "<cmd>w<cr><cmd>!lua-format --in-place --indent-width=4 --column-limit=160 --tab-width=4 --no-use-tab --continuation-indent-width=4 --align-parameter --align-args --align-table-field --no-keep-simple-control-block-one-line --no-keep-simple-function-one-line --extra-sep-at-table-end --table-sep=\",\"  --column-table-limit=1 --break-before-table-rb --break-after-table-lb --chop-down-parameter --chop-down-table %<cr><cmd>e<cr>",

                                  "<cmd>w<cr><cmd>!lua-format --in-place --indent-width=4 --column-limit=80 --tab-width=4 --align-args --align-table-field --break-after-table-lb %<cr><cmd>e<cr>",
                                  {noremap = true})
            -- v.nvim_buf_set_keymap(0, "n", "<F4>",
            --                       "<cmd>w<cr><cmd>!lua-format --in-place --indent-width=4 --column-limit=160 --tab-width=4 --no-use-tab --continuation-indent-width=4 --align-parameter --align-args --align-table-field --no-keep-simple-control-block-one-line --no-keep-simple-function-one-line --extra-sep-at-table-end --table-sep=\",\"  --column-table-limit=100 --break-before-table-rb --break-after-table-lb %<cr><cmd>e<cr>",
            --                       {noremap = true})
        end
    end,

    pattern = "lua",
    group = FileTypeCompile
})

-- JSON
v.nvim_create_autocmd({"FileType"}, {
    callback = function()
        v.nvim_buf_set_keymap(0, "n", "<F4>",
                              "<cmd>w<cr><cmd>!prettier --print-width 160 -w % <cr><cmd>e<cr>",
                              {noremap = true})
    end,
    pattern = "json, yaml, css, scss, javascript",
    group = FileTypeCompile
})

-- RUST
v.nvim_create_autocmd({"FileType"}, {
    callback = function()
        v.nvim_buf_set_keymap(0, "n", "<F5>", "<cmd>w<cr><cmd>!cargo run<cr>",
                              {noremap = true})
        v.nvim_buf_set_keymap(0, "n", "<F4>",
                              "<cmd>w<cr><cmd>!cargo fmt<cr><cmd>e<cr>",
                              {noremap = true})
    end,
    pattern = "rust",
    group = FileTypeCompile
})

-- fix mode on tabenter
-- v.nvim_create_autocmd(
--     {
--         "TabEnter",
--     },
--     {
--         callback = function()
--             v.nvim_feedkeys(
--                 key_Escape,
--                 "i",
--                 false)
--         end,
--         pattern = {
--             "*",
--         },
--         group = MainGroup,
--     })

-- recompile xmonad
v.nvim_create_autocmd("BufWritePost * undojoin", {
    callback = function() vim.cmd("!xmonad --recompile") end,
    pattern = {"xmonad.hs"},
    group = MainGroup
})

-- reload buffer automatically
v.nvim_create_autocmd({"FocusGained", "InsertEnter"}, {
    callback = function()
        if string.sub(v.nvim_buf_get_name(0), -14) == "[Command Line]" then
            return
        end
        vim.cmd("checktime")
    end,
    pattern = {"*"},
    group = MainGroup
})

-- Restore cursor position
vim.api.nvim_create_autocmd({"BufReadPost"}, {
    pattern = {"*"},
    callback = function() vim.api.nvim_exec('silent! normal! g`"zv', false) end
})

-- term
-- vim.api
--     .nvim_create_autocmd(
--     {
--         "TermOpen",
--     },
--     {
--         pattern = {
--             "*",
--         },
--         callback = function()
--             vim.api
--                 .nvim_exec(
--                 'startinsert',
--                 false)
--         end,
--     })

-- autosave on insertleave, does NOT work with rust analyzer
vim.api.nvim_create_autocmd({"InsertLeave"}, {
    pattern = {"*"},
    callback = function()
        if string.sub(v.nvim_buf_get_name(0), -14) == "[Command Line]" then
            return
        end
        if vim.o.readonly == false then vim.cmd("silent! w") end
    end
})

-- bdelete on bufleave if win is float
-- vim.api.nvim_create_autocmd({"WinLeave"}, {
--     pattern = {"THISWONTTIRRGERRR"},
--     callback = function()
--         if util.is_win_float(true) then
--             v.nvim_win_close(0)
--         end
--     end,
-- })

-- vim.cmd([[
--     augroup FIXMAN " refresh workaround
--     augroup END
--     autocmd! FIXMAN
--     augroup FIXMAN
--     " ----------------
--     " fix manpages
--     " ----------------
--     autocmd BufNewFile,BufRead *.service* set ft=systemd
--     autocmd BufNewFile,BufRead *.mantemp* set ft=man
--     autocmd FileType man          nnoremap <buffer> ö l
--     autocmd FileType man          nnoremap <buffer> l kzz
--     autocmd FileType man          nnoremap <buffer> k jzz
--     autocmd FileType man          nnoremap <buffer> j h
--     autocmd FileType man    nnoremap <buffer> W $
--     autocmd FileType man    nnoremap <buffer> E $
--     autocmd FileType man    nnoremap <buffer> B 0
--     autocmd FileType man    vnoremap <buffer> W $
--     autocmd FileType man    vnoremap <buffer> E $
--     augroup END
-- ]])

-- restore cursor pos
vim.cmd([[
augroup save_cursor_position
  autocmd!
  autocmd WinLeave * let w:last_cursor_position = getpos('.')
  autocmd WinEnter * if exists('w:last_cursor_position') | call setpos('.', w:last_cursor_position) | endif
augroup END
]])
