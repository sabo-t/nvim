v = vim.api

st = require('state')
util = require('lib_util')
cs = require('lib_cs')

mappings = require('mappings')

require('plugins')
require('snippets')
require('autocmds')
require('commands')
require('cabbrev')

cs.change_colorscheme(cs.get_last_colorscheme() or "blue")

-------------------
--- vim.options ---
-------------------

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

-- backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50

-- ui
vim.opt.signcolumn = "yes"
vim.opt.linebreak = true
vim.opt.wildmenu = true
vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 4
vim.opt.wrap = true
vim.opt.number = true
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
vim.opt.list = true
vim.opt.ruler = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.autochdir = true
vim.opt.listchars = "space:⋅,eol:↴,multispace:|⋅⋅⋅,nbsp:x,tab:  "

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
vim.opt.splitkeep = "cursor"

-- fold
vim.opt.foldcolumn = '0' -- '0' is not bad
-- vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 0
vim.opt.foldenable = true
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 6
-- vim.opt.foldmethod = "expr" -- treesitter folding
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
