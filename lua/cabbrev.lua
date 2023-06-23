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
]])
