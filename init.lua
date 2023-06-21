v = vim.api

st = require('state')

local util = require('lib_util')
local cs = require('lib_cs')

require('plugins')
require('languageservers')
require('completion')
require('snippets')
require('tools')
require('mappings')
require('graphics')
require('autocmds')
picker_ = require('telescope_project_picker')

cs.change_colorscheme(cs.get_last_colorscheme() or "blue")

-------------------
--- vim.options ---
-------------------
-- vim.opt.path+ = { '~/.config/*/', '~/text/', '~/.local/share/applications/', '~/".*"', '~/.vim/*/', '~/work/*.pdf' }

vim.cmd([[
    filetype plugin indent on
    set wildchar=<S-F9>
set whichwrap+=b,s,<,>,h,l
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  "remove annoying automatic comment insertion
]])

vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.g.mapleader = ','
vim.g.maplocalleader = ','
-- vim.opt.encoding = 'utf8' sometimes need ansi
vim.opt.autoread = true
vim.opt.confirm = true
vim.opt.history = 1000
vim.opt.wildmenu = true
vim.opt.scrolloff = 21
-- vim.opt.noswapfile = 1000
-- vim.opt.spell = true
-- vim.opt.nrformats-= 'octal'

-- backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50

-- ui
vim.opt.signcolumn = "yes"
vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.wildmenu = true
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 4
vim.opt.breakindent = true
vim.opt.showbreak = " => "
vim.opt.hls = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.cmdheight = 0 -- 0 causes issues with :search functions 'w'
vim.opt.lazyredraw = false
vim.opt.title = true
vim.opt.laststatus = 3
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.relativenumber = true
vim.opt.virtualedit = "onemore"
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = 'tab:  '
vim.opt.ruler = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.autochdir = true
vim.opt.listchars = "space:⋅,eol:↴,multispace:|⋅⋅⋅,nbsp:x"
-- vim.opt.listchars = "multispace:⋅⋅⋅+"


-- indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

-- split
vim.opt.splitright = true
vim.opt.equalalways = true
vim.opt.splitkeep = "screen"


-- fold
vim.opt.foldcolumn = '0' -- '0' is not bad
-- vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 0
vim.opt.foldenable = true
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 6
vim.opt.foldmethod = "expr" -- treesitter folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.cmd([[
--
-- " highlight Folded guibg='#fe640b' guifg=blue
-- "  highlight FoldColumn guibg=darkgrey guifg=white
--  set foldtext=CustomFoldText()
--  set fillchars=fold:\
-- function! CustomFoldText()
--   " get first non-blank line
--   let fs = v:foldstart
--   while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
--   endwhile
--   if fs > v:foldend
--       let line = getline(v:foldstart)
--   else
--       let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
--   endif
--   let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
--   let foldSize = 1 + v:foldend - v:foldstart
--   let foldSizeStr = " " . foldSize . " lines "
--   let foldLevelStr = repeat("+--", v:foldlevel)
--   let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
--   return line . expansionString . foldSizeStr . foldLevelStr
-- endfunction
-- ]])

-- custom user commands
v.nvim_create_user_command('Reload', 'silent! !setsid -f ' .. st.path_config .. '/scripts/reload_nvim.sh', {})
