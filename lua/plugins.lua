vim.cmd [[packadd packer.nvim]]
use =
    ""

return
    require(
        "packer").startup(
        function()
            ---------
            -- engine
            ---------
            use "wbthomason/packer.nvim"
            -- use "williamboman/mason.nvim"
            -- use "neovim/pynvim"
            -- use({
            --     "jackMort/ChatGPT.nvim",
            --     requires = {
            --         "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim",
            --     },
            -- })

            use {
                'nvim-telescope/telescope.nvim',
                tag = '0.1.1',
                -- or                            , branch = '0.1.x',
                requires = {
                    {
                        'nvim-lua/plenary.nvim',
                    },
                },
            }
            use {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make',
            }

            ---------
            -- lspconfig
            ---------
            use "neovim/nvim-lspconfig"
            use "simrat39/rust-tools.nvim"
            -- use({
            --     "glepnir/lspsaga.nvim",
            --     branch = "main",
            --     config = function()
            --         local saga = require("lspsaga")
            --
            --         saga.init_lsp_saga({})
            --     end,
            -- })
            use "lervag/vimtex"
            use "p00f/clangd_extensions.nvim"
            -- use "mfussenegger/nvim-jdtls"

            -------------
            -- treesitter
            -------------
            use {
                "nvim-treesitter/nvim-treesitter",
                run = ":TSUpdate",
                "nvim-treesitter/playground",
                'nvim-treesitter/nvim-treesitter-refactor',
                'nvim-treesitter/nvim-treesitter-textobjects',
                -- "andymass/vim-matchup",
                "elkowar/yuck.vim",
                'nvim-treesitter/nvim-treesitter-context',
            }

            use {
                "SmiteshP/nvim-navic",
                requires = "neovim/nvim-lspconfig",
            }

            ---------
            -- tools
            --------

            -- BROKEN WTF
            -- use {
            --   'glepnir/dashboard-nvim',
            --   event = 'VimEnter',
            --   config = function()
            --     require('dashboard').setup {
            -- config = {
            --   shortcut = {
            --     -- action can be a function type
            --     { desc = string, group = 'highlight group', key = 'shortcut key', action = 'action when you press key' },
            --   },
            --   packages = { enable = true }, -- show how many plugins neovim loaded
            --   -- limit how many projects list, action when you press key or enter it will run this action.
            --   -- action can be a functino type, e.g.
            --   -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
            --   project = { enable = true, limit = 8, icon = 'your icon', label = '', action = 'Telescope find_files cwd=' },
            --   mru = { limit = 10, icon = 'your icon', label = '', },
            --   footer = {}, -- footer
            -- }
            --     }
            --   end,
            --   requires = {'nvim-tree/nvim-web-devicons'}
            -- }

            use "tpope/vim-fugitive"

            use {
                "anuvyklack/windows.nvim",
                requires = {
                    "anuvyklack/middleclass",
                },
            }

            vim.cmd(
                [[let g:tmux_navigator_no_mappings = 1]])
            use {
                "christoomey/vim-tmux-navigator",
                lazy = false,
            }
            use "anuvyklack/windows.nvim"
            use {
                "akinsho/toggleterm.nvim",
                -- "tpope/vim-repeat",
                -- "ggandor/lightspeed.nvim",
                "ggandor/leap.nvim",
                "ggandor/flit.nvim",
                "michaelb/sniprun",
                run = "bash ./install.sh",
                -- "tpope/vim-surround",
                -- "raimondi/delimitmate", -- until nvim-autopairs implements function to check if can jump
                "windwp/nvim-autopairs",
                "lambdalisue/suda.vim",
                -- "preservim/tagbar",
                "stevearc/aerial.nvim",
                "nvim-lua/plenary.nvim",
                "chentoast/marks.nvim",
                "mbbill/undotree",
                -- "907th/vim-auto-save"
                -- 'folke/which-key.nvim', too janky for the moment
                -- 'vim-scripts/tabops', lag?
                --
            }
            -- use({ // a bit scuffed
            --     'ray-x/navigator.lua',
            --     requires = {
            --         {
            --             'ray-x/guihua.lua',
            --             run = 'cd lua/fzy && make',
            --         },
            --         {
            --             'neovim/nvim-lspconfig',
            --         },
            --     },
            -- })
            use {
                'numToStr/Comment.nvim',
                config = function()
                    require(
                        'Comment').setup()
                end,
            }
            use {
                "nvim-neotest/neotest",
                requires = {
                    "nvim-lua/plenary.nvim",
                    "nvim-treesitter/nvim-treesitter",
                    "antoinemadec/FixCursorHold.nvim",
                },
            } -- debug tool notsetup yet
            use(
                {
                    "kylechui/nvim-surround",
                    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
                })
            -- use 'mg979/vim-visual-multi'

            -------------------------------------
            -- completion and snippet integration
            -------------------------------------

            use {
                "hrsh7th/nvim-cmp",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "onsails/lspkind.nvim",
                -- 'rafamadriz/friendly-snippets',
            }

            ----------
            -- graphics
            ----------
            use  {
            'j-hui/fidget.nvim', tag = 'legacy'
        }

            use "nvim-lualine/lualine.nvim"
            -- use "lukas-reineke/indent-blankline.nvim"
            -- use({
            --     "folke/noice.nvim",
            --     config = function()
            --         require("noice").setup({
            --             -- add any options here
            --         })
            --     end,
            --     requires = {
            --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            --         "MunifTanjim/nui.nvim", -- OPTIONAL:
            --         --   `nvim-notify` is only needed, if you want to use the notification view.
            --         --   If not available, we use `mini` as the fallback
            --         "rcarriga/nvim-notify"
            --     }
            -- })

            ----------
            --- icons
            ----------
            use {
                "kyazdani42/nvim-web-devicons",
                "lewis6991/gitsigns.nvim",
                config = function()
                    require(
                        "gitsigns").setup()
                end,
            }

            ---------------
            -- colorschemes
            ---------------
            -- use { 'dasupradyumna/midnight.nvim' }


            -- use 'sainnhe/everforest'
            -- use 'AlessandroYorba/Alduin'
            -- use 'sainnhe/gruvbox-material'
            -- use 'ayu-theme/ayu-vim'
            -- use "VDuchauffour/neodark.nvim"
            -- use 'Luxed/ayu-vim'
            -- use 'AlexvZyl/nordic.nvim'
            use 'shaunsingh/nord.nvim'
            use 'rebelot/kanagawa.nvim'
            -- use {
            --     "catppuccin/nvim",
            --     as = "catppuccin",
            -- }
            -- use {'nyoom-engineering/oxocarbon.nvim'}
            -- use "rebelot/kanagawa.nvim"
            -- use 'eddyekofo94/gruvbox-flat.nvim'
            -- use "EdenEast/nightfox.nvim" -- Packer
            -- use 'franbach/miramare'
            -- use 'shaunsingh/solarized.nvim'
            -- use 'sam4llis/nvim-tundra' -- packer.nvim
            -- use 'pineapplegiant/spaceduck'
            -- use 'junegunn/seoul256.vim'

            use {
                "goolord/alpha-nvim",
            }
        end)

