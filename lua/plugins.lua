return {
    'chriskempson/base16-vim',
    'EdenEast/nightfox.nvim',
    {
        'rainglow/vim',
        name = 'rainglow',
    },
    {
        'sonph/onehalf',
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/vim")
        end,
    },
    'rmehri01/onenord.nvim',
    'olimorris/onedarkpro.nvim',
    'ray-x/aurora',
    {
        'folke/tokyonight.nvim',
    },
    {
        'projekt0n/github-nvim-theme',
        opts = {},
        config = function(plugin, opts)
            require("github-theme").setup(opts)
        end,
    },
    {
        'nyoom-engineering/oxocarbon.nvim'
    },
    {
        dependencies = { 'rktjmp/lush.nvim' },
        'metalelf0/jellybeans-nvim',
        lazy = false,
        priority = 1000,
        config = function(_, _)
            vim.cmd.colorscheme('jellybeans-nvim')
        end,
    },
    {
        'tpope/vim-sleuth',
        event = 'BufReadPre',
    },
    {
        'stevearc/quicker.nvim',
        event = 'FileType qf',
        ---@module 'quicker'
        ---@type quicker.SetupOptions
        opts = {
            keys = {
                { '>', function() require 'quicker'.expand({ before = 2, after = 2, add_to_existing = true }) end, desc = 'expand qf content' },
                { '<', function() require 'quicker'.collapse() end,                                                desc = 'expand qf content' },
            }
        },
    },
    {
        'kevinhwang91/nvim-bqf',
        event = "VeryLazy",
        dependencies = { 'junegunn/fzf' },
    },
    {
        'y3owk1n/time-machine.nvim',
        cmd = {
            "TimeMachineToggle",
            "TimeMachinePurgeBuffer",
            "TimeMachinePurgeAll",
            "TimeMachineLogShow",
            "TimeMachineLogClear",
        },
        keys = {
            { '<leader>tU', function() require 'time-machine'.actions.toggle() end, { silent = true }, desc = 'time-machine' },
        },
        ---@module 'time-machine'
        ---@type TimeMachine.Config
        opts = {
            diff_tool = "difft",
        },
    },
        'MagicDuck/grug-far.nvim',
        main = 'grug-far',
        cmd = { 'GrugFar' },
        keys = {
            { '<leader>sR', function() require 'grug-far'.open {} end, { silent = true }, desc = 'grug-far' },
        },
        opts = {
        }
    },
    {
        'mbbill/undotree',
        cmd = { 'UndotreeToggle', 'UndotreeShow', 'UndotreeHide', 'UndotreeFocus' },
        config = function(plugin)
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    },
    {
        'nyngwang/NeoZoom.lua',
        keys = {
            { '<leader>z', function() require 'neo-zoom'.neo_zoom({}) end, { silent = true }, desc = 'zoom-window' },
        },
        opts = {},
    },
    {
        'folke/twilight.nvim',
        cmd = { 'Twilight', 'TwilightEnable', 'TwilightEnable' },
        opts = {},
    },
    {
        'anuvyklack/windows.nvim',
        dependencies = {
            'anuvyklack/middleclass',
            'anuvyklack/animation.nvim',
        },
        keys = {
            { '<leader>ta', '<cmd>WindowsToggleAutowidth<cr>', { silent = true }, desc = 'autowidth' },
            { '<leader>wm', '<cmd>WindowsMaximize<cr>',        { silent = true }, desc = 'maximize' },
            { '<leader>w=', '<cmd>WindowsEqualize<cr>',        { silent = true }, desc = 'balance-windows' },
        },
        opts = {
            autowidth = {
                enable = false,
            }
        },
        config = function(plugin, opts)
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require 'windows'.setup(opts)
        end,
    },
    {
        'cespare/vim-toml',
        ft = 'toml',
    },
    {
        'rust-lang/rust.vim',
        ft = 'rust',
    },
    {
        'Saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        keys = {
            { '<leader>mi', function() require 'crates'.show_popup() end,              desc = "info-popup" },
            { '<leader>mv', function() require 'crates'.show_versions_popup() end,     desc = "version-popup" },
            { '<leader>md', function() require 'crates'.show_dependencies_popup() end, desc = "dependency-popup" },
            { '<leader>mf', function() require 'crates'.show_features_popup() end,     desc = "feature-popup" },
        },
        opts = function(plugin)
            ---@module 'crates'
            ---@type crates.UserConfig
            return {
                completion = {
                    crates = {
                        enabled = true,
                    },
                },
                lsp = {
                    enabled = true,
                    actions = true,
                    hover = true,
                    completion = true,
                },
            }
        end,
    },
    {
        'Apeiros-46B/uiua.vim',
        ft = 'uiua',
    },
    {
        'LnL7/vim-nix',
        ft = 'nix',
    },
    {
        'isobit/vim-caddyfile',
        ft = 'caddyfile',
    },
    {
        'NoahTheDuke/vim-just',
        ft = { 'just', 'Justfile' },
    },
    {
        'lervag/vimtex',
        ft = 'tex',
        config = function(plugin)
            vim.g.tex_flavor = 'latex'
        end,
    },
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = '1.*',
        opts = {},
    },
    {
        'ziglang/zig.vim',
        ft = 'zig',
    },
    {
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            require('orgmode').setup({
                org_agenda_files = '~/org/**/*',
                org_default_notes_file = '~/org/refile.org',
            })
        end,
    },
    {
        'bakpakin/fennel.vim',
        ft = 'fnl',
    },
    {
        'ahf/cocci-syntax',
        ft = 'cocci',
    },
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
    },
    {
        'chrisgrieser/nvim-recorder',
        opts = {
            slots = { 'a', 'b', 'c' },
        },
    },
    {
        'Bekaboo/deadcolumn.nvim',
        event = 'VeryLazy',
        opts = {
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPre',
        opts = {
            on_attach = function(bufnr)
                local gs = require 'gitsigns'

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gs.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gs.nav_hunk('prev')
                    end
                end)

                -- Actions
                map('n', '<leader>ghs', gs.stage_hunk, { desc = 'stage hunk' })
                map('n', '<leader>ghr', gs.reset_hunk, { desc = 'reset hunk' })

                map('v', '<leader>ghs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = 'stage hunk' })
                map('v', '<leader>ghr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = 'reset hunk' })

                map('n', '<leader>ghS', gs.stage_buffer, { desc = 'stage buffer' })
                map('n', '<leader>ghR', gs.reset_buffer, { desc = 'reset buffer' })
                map('n', '<leader>ghd', gs.diffthis, { desc = 'diff this' })

                map('n', '<leader>ghp', gs.preview_hunk, { desc = 'preview hunk' })
                map('n', '<leader>ghi', gs.preview_hunk_inline, { desc = 'preview hunk (inline)' })

                map('n', '<leader>ghb', function() gs.blame_line { full = true } end, { desc = 'blame line' })

                map('n', '<leader>tgb', gs.toggle_current_line_blame, { desc = 'toggle line-blame' })
                map('n', '<leader>tgw', gs.toggle_word_diff, { desc = 'toggle word-diff' })

                -- Text object
                map({ 'o', 'x' }, 'ih', gs.select_hunk)
            end,
        }
    },
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
        keys = {
            { '<leader>gG', '<cmd>Git<cr>', { silent = true }, desc = 'fugitive' },
        }
    },
    {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
        opts = {},
    },
    -- {
    --     'kdheepak/lazygit.nvim',
    --     cmd = {
    --         'LazyGit',
    --         'LazyGitConfig',
    --         'LazyGitFilter',
    --         'LazyGitCurrentFile',
    --         'LazyGitFilterCurrentFile',
    --     },
    --     keys = {
    --         { '<leader>gg', '<cmd>LazyGit<cr>', { silent = true }, desc = 'lazy-git' },
    --     },
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --     },
    -- },
    {
        'numToStr/Comment.nvim',
        event = "BufRead",
        config = function(plugin, opts)
            require('Comment').setup(opts)
        end,
    },
    {
        'kylechui/nvim-surround',
        event = "VeryLazy",
        opts = {
            keymaps = {
                insert          = '<C-g>z',
                insert_line     = '<C-g>Z',
                normal          = 'gz',
                normal_cur      = 'gZ',
                normal_line     = 'gzgz',
                normal_cur_line = 'gZgZ',
                visual          = 'gz',
                visual_line     = 'gZ',
                delete          = 'gzd',
                change          = 'gzc',
            },
        },
    },
    {
        'cbochs/portal.nvim',
        keys = {
            { '<leader>jo', function() require 'portal.builtin'.jumplist.tunnel_backward() end,   desc = 'portal backward' },
            { '<leader>ji', function() require 'portal.builtin'.jumplist.tunnel_forward() end,    desc = 'portal forward' },
            { '<leader>j;', function() require 'portal.builtin'.changelist.tunnel_backward() end, desc = 'portal backward' },
            { '<leader>j,', function() require 'portal.builtin'.changelist.tunnel_forward() end,  desc = 'portal forward' },
        },
        config = function(plugin, opts)
            require 'portal'.setup(opts)
        end,
    },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        ---@module 'flash'
        ---@type Flash.Config
        opts = {
            modes = {
                search = {
                    enabled = false,
                },
            },
        },
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "flash-treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "flash-remote" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "flash-treesitter" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "flash-search-toggle" },
        }
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = 'VeryLazy',
        keys = {
            { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "todo-comments" },
        },
        opts = {},
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {},
    },
    {
        'wsdjeg/vim-fetch',
        lazy = false,
    },
    {
        "folke/zen-mode.nvim",
        dependencies = { 'folke/twilight.nvim' },
        ---@module 'zen-mode'
        ---@type ZenOptions
        opts = {
            window = {
                options = {
                    number = false,
                },
            },
        },
        keys = {
            { '<leader>tz', function() require 'zen-mode'.toggle() end, desc = 'zen-mode' },
        },
        config = function(plugin, opts)
            require("zen-mode").setup(opts)
        end,
    },
    {
        'folke/snacks.nvim',
        keys = {
            { "<leader>bk",      function() Snacks.bufdelete() end,                         desc = "kill-buffer" },
            { "<leader>gg",      function() Snacks.lazygit() end,                           desc = "lazygit" },
            { "<leader>;",       function() Snacks.scratch() end,                           desc = "toggle-scratch" },
            { "<leader>:",       function() Snacks.scratch.select() end,                    desc = "select-scratch" },
            { "<leader>fp",      function() Snacks.picker.projects() end,                   desc = "projects" },
            { '<leader>M',       function() Snacks.picker.notifications() end,              desc = 'message-history' },
            { "<leader><space>", function() Snacks.picker.smart() end,                      desc = "find-file" },
            { "<leader>bb",      function() Snacks.picker.buffers() end,                    desc = "switch-buffer" },
            { "<leader>sp",      function() Snacks.picker.grep({ limit = 10000 }) end,      desc = "live-grep" },
            { "<leader>sP",      function() Snacks.picker.grep_word({ limit = 10000 }) end, desc = "live-grep-word" },
            { "<leader>sb",      function() Snacks.picker.lines() end,                      desc = "buffer-lines" },
            { "<leader>fr",      function() Snacks.picker.recent({ limit = 10000 }) end,    desc = "recent-files" },
            { "<leader>r",       function() Snacks.picker.resume() end,                     desc = "resume" },
            { "<leader>l",       function() Snacks.picker.pickers() end,                    desc = "pickers" },
            { "<c-\\>",          function() Snacks.terminal.toggle() end,                   desc = "terminal" },

            { "<leader>sd",      function() Snacks.picker.lsp_symbols() end,                desc = "lsp-document-symbols" },
            { "<leader>ss",      function() Snacks.picker.lsp_workspace_symbols() end,      desc = "lsp-workspace-symbols" },

            -- Nicer explorer binding: https://github.com/folke/snacks.nvim/discussions/1273
            {
                "<leader>`",
                function()
                    local pickers = Snacks.picker.get({ source = 'explorer' })
                    for _, v in pairs(pickers) do
                        if v:is_focused() then
                            v:close()
                        else
                            v:focus()
                        end
                    end
                    if #pickers == 0 then
                        Snacks.picker.explorer()
                    end
                end,
                desc = "explorer"
            },
        },
        priority = 1000,
        lazy = false,
        ---@module 'snacks'
        ---@type snacks.Config
        opts = {
            dashboard = {
                sections = {
                    { section = 'header',       padding = 1 },
                    { section = 'keys',         indent = 2,             padding = 2 },
                    { section = 'recent_files', title = 'Recent Files', indent = 2, padding = 2 },
                    { section = 'projects',     title = 'Projects',     indent = 2, padding = 2 },
                    {
                        section = 'terminal',
                        title = 'Git status',
                        enabled = function() return Snacks.git.get_root() ~= nil end,
                        cmd = 'git diff --stat -B -M -C',
                        padding = 2,
                        height = 8,
                        indent = 1,
                    },
                    { section = 'startup' },
                },
            },
            explorer = {
                enabled = true,
                replace_netrw = false,
            },
            lazygit = {
                enabled = true,
            },
            toggle = {
                color = {
                    enabled = 'green',
                    disabled = 'red',
                },
                wk_desc = {
                    enabled = ' enable ',
                    disabled = ' disabled ',
                }
            },
            notifier = {
                enabled = true,
            },
            input = {
                enabled = true,
            },
            quickfile = {
                enabled = false,
            },
            statuscolumn = {
                enabled = true,
            },
            picker = {
                enabled = true,
            },
            scratch = {
                enabled = true
            },
            styles = {
                terminal = {
                    keys = {
                        toggle = {
                            '<c-\\>',
                            'toggle',
                            mode = 't',
                        },
                        -- Modification of upstream default: Only send <esc> after the timeout.
                        -- The benefit is that there won't be any unnecessary <esc> visible to
                        -- the program, the downside is that <esc><other key> sequences invert.
                        -- (<esc><esc> doesn't work for some reason)
                        term_normal = {
                            "<esc>",
                            function(self)
                                self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                                if self.esc_timer:is_active() then
                                    self.esc_timer:stop()
                                    vim.cmd("stopinsert")
                                else
                                    self.esc_timer:start(200, 0, function()
                                        vim.schedule(function()
                                            vim.api.nvim_chan_send(vim.b.terminal_job_id, "")
                                        end)
                                    end)
                                    return "<Ignore>"
                                end
                            end,
                            mode = "t",
                            expr = true,
                            desc = "Double escape to normal mode",
                        },
                    },
                },
            },
            terminal = {
                enabled = true,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = 'VeryLazy',
                callback = function()
                    -- Debug helpers
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd

                    -- Toggle bindings
                    Snacks.toggle.option('spell', { name = 'spelling' }):map('<leader>ts')
                    Snacks.toggle.option('wrap', { name = 'wrapping' }):map('<leader>tw')
                    Snacks.toggle.diagnostics({ name = 'diagnostics' }):map('<leader>td')
                    Snacks.toggle.treesitter({ name = 'treesitter' }):map('<leader>tT')
                    Snacks.toggle.inlay_hints({ name = 'inlay-hints' }):map('<leader>th')
                    Snacks.toggle.indent():map('<leader>ti')
                    Snacks.toggle.dim():map('<leader>tD')
                end,
            })

            vim.keymap.set('n', '<leader>gj', function()
                Snacks.terminal.toggle({ 'jjui' }, {
                    interactive = true,
                    win = {
                        border = 'rounded',
                        title = 'jjui',
                    }
                })
            end, { silent = true, noremap = true })
        end,
    },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
        },
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        lazy = false,
    },
    {
        'echasnovski/mini.files',
        version = false,
        keys = {
            { '<M-o>',      function() require 'mini.files'.open() end,                             mode = { 'n', 't' },        desc = 'open file', noremap = true, silent = true },
            { "<leader>ff", function() require 'mini.files'.open() end,                             desc = "file-explorer" },
            { "<leader>fF", function() require 'mini.files'.open(vim.api.nvim_buf_get_name(0)) end, desc = "file-explorer-here" },
        },
        opts = {
            options = {
                use_as_default_explorer = false,
            },
            windows = {
                preview = true,
                width_preview = 100.
            },
        },
    },
    {
        'echasnovski/mini.trailspace',
        event = 'VeryLazy',
        version = false,
        opts = {},
    },
    {
        'olimorris/persisted.nvim',
        event = 'BufReadPre',
        cmd = {
            'Persisted',
        },
        keys = {
            { "<leader>xs", function() require('persisted').load() end,                desc = 'restore-session' },
            { "<leader>xS", function() require('persisted').select() end,              desc = 'select-session' },
            { "<leader>xl", function() require('persisted').load({ last = true }) end, desc = 'restore-last-session' },
            { "<leader>xd", function() require('persisted').stop() end,                desc = 'disable-session-save' },
        },
        opts = {
        },
    },
    {
        'ahmedkhalf/project.nvim',
        main = 'project_nvim',
        opts = {
            manual_mode = true,
        },
        -- This plugin does an automatic cd on VimEnter. So let's load it just in time.
        event = 'VimEnter',
    },
    {
        'mschlumpp/quick-switch.nvim',
        -- The plugin needs to keep track of buffers even if the keybind wasn't
        -- used yet.
        event = 'VeryLazy',
        keys = {
            { '<leader>.', function() require 'quick-switch'.start_switch() end, 'quick-switch' },
        },
        opts = {},
    },
    {
        'windwp/nvim-autopairs',
        event = { 'InsertEnter' },
        opts = {
            fast_wrap = {},
            disable_filetype = { 'uiua' },
            check_ts = true,
        },
        config = function(plugin, opts)
            local npairs = require 'nvim-autopairs'
            npairs.setup(opts)

            local Rule = require 'nvim-autopairs.rule'
            local ts_conds = require 'nvim-autopairs.ts-conds'

            npairs.add_rules({
                Rule('=', ';', 'nix')
                    :with_pair(ts_conds.is_not_ts_node('binding_set'))
            })
        end,
    },
    {
        'gbprod/yanky.nvim',
        opts = {},
        keys = {
            { 'p',     '<Plug>(YankyPutAfter)',     mode = { 'n', 'x' } },
            { 'P',     '<Plug>(YankyPutBefore)',    mode = { 'n', 'x' } },
            { 'gp',    '<Plug>(YankyGPutAfter)',    mode = { 'n', 'x' } },
            { 'gP',    '<Plug>(YankyGPutBefore)',   mode = { 'n', 'x' } },
            { '<c-n>', '<Plug>(YankyCycleForward)' },
            { '<c-p>', '<Plug>(YankyCycleBackward)' },
            { '<m-p>', '<cmd>YankyRingHistory<cr>' },
        },
    },
    -- {
    --     'rcarriga/nvim-notify',
    --     event = 'VeryLazy',
    --     opts = {},
    --     init = function(plugins, opts)
    --         vim.notify = require 'notify'
    --     end,
    -- },
    {
        'lambdalisue/suda.vim',
        cmd = { 'SudaRead', 'SudaWrite' },
    },
    {
        'editorconfig/editorconfig-vim',
        event = 'BufRead',
    },
    {
        'junegunn/vim-easy-align',
        keys = {
            { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' } }
        },
    },
    {
        'monaqa/dial.nvim',
        keys = {
            { '<c-a>',  '<Plug>(dial-increment)',  { noremap = true }, desc = 'dial increment' },
            { '<c-x>',  '<Plug>(dial-decrement)',  { noremap = true }, desc = 'dial decrement' },
            { '<c-a>',  '<Plug>(dial-increment)',  { noremap = true }, mode = { 'v' },         desc = 'dial increment' },
            { '<c-x>',  '<Plug>(dial-decrement)',  { noremap = true }, mode = { 'v' },         desc = 'dial decrement' },
            { 'g<c-a>', 'g<Plug>(dial-increment)', { noremap = true }, mode = { 'v' },         desc = 'dial increment' },
            { 'g<c-x>', 'g<Plug>(dial-decrement)', { noremap = true }, mode = { 'v' },         desc = 'dial decrement' },
        },
    },
    {
        'skywind3000/asyncrun.vim',
        dependencies = {
            { 'skywind3000/asynctasks.vim' }
        },
        cmd = { 'AsyncRun' },
        config = function(plugin)
            vim.g.asyncrun_open = 8
        end,
    },
    {
        't-troebst/perfanno.nvim',
        cmd = {
            'PerfAnnotate',
            'PerfAnnotateSelection',
            'PerfCacheLoad',
            'PerfCycleFormat',
            'PerfHottestCallersSelection',
            'PerfHottestSymbols',
            'PerfLoadFlameGraph',
            'PerfLuaProfileStart',
            'PerfPickEvent',
            'PerfAnnotateFunction',
            'PerfCacheDelete',
            'PerfCacheSave',
            'PerfHottestCallersFunction',
            'PerfHottestLines',
            'PerfLoadCallGraph',
            'PerfLoadFlat',
            'PerfLuaProfileStop',
            'PerfToggleAnnotations'
        },
        keys = {
            { '<leader>cplp', '<cmd>PerfLoadFlat<cr>',                desc = "perf-data",            noremap = true,               silent = true },
            { '<leader>cplg', '<cmd>PerfLoadCallGraph<cr>',           desc = "perf-data-call-graph", noremap = true,               silent = true },
            { '<leader>cplf', '<cmd>PerfLoadFlameGraph<cr>',          desc = "flamegraph",           noremap = true,               silent = true },

            { '<leader>cpe',  '<cmd>PerfPickEvent<cr>',               desc = "pick-event",           noremap = true,               silent = true },

            { '<leader>cpa',  '<cmd>PerfAnnotate<cr>',                desc = "annotate",             noremap = true,               silent = true },
            { '<leader>cpf',  '<cmd>PerfAnnotateFunction<cr>',        desc = "annotate-function",    noremap = true,               silent = true },
            { '<leader>cpf',  '<cmd>PerfAnnotateSelection<cr>',       mode = { 'v' },                desc = "annotate",            noremap = true, silent = true },

            { '<leader>cpt',  '<cmd>PerfToggleAnnotations<cr>',       desc = "toggle",               noremap = true,               silent = true },

            { '<leader>cph',  '<cmd>PerfHottestLines<cr>',            desc = "hottest-lines",        noremap = true,               silent = true },
            { '<leader>cps',  '<cmd>PerfHottestSymbols<cr>',          desc = "hottest-symbols",      noremap = true,               silent = true },
            { '<leader>cpc',  '<cmd>PerfHottestCallersFunction<cr>',  desc = "hottest-callers-fn",   noremap = true,               silent = true },
            { '<leader>cpc',  '<cmd>PerfHottestCallersSelection<cr>', mode = { 'v' },                desc = "hottest-callers-sel", noremap = true, silent = true },

        },
        opts = {

        },
        config = function(plugin, opts)
            local perfanno = require 'perfanno'
            local util = require 'perfanno.util'
            local config = require 'perfanno.config'

            local function generate_color_config(opts)
                local bgcolor = vim.fn.synIDattr(vim.fn.hlID('Normal'), 'bg', 'gui')
                local color_config = {
                    line_highlights = util.make_bg_highlights(bgcolor, '#CC3300', 10),
                    vt_highlight = util.make_fg_highlight('#CC3300'),
                }
                return vim.tbl_deep_extend('force', vim.deepcopy(opts), color_config)
            end

            perfanno.setup(generate_color_config(opts))
            -- Automatically update colors on colorscheme change
            local color_autocmd = vim.api.nvim_create_augroup("PerfannoColorUpdate", { clear = true })
            vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
                group = color_autocmd,
                callback = function(ev)
                    config.load(generate_color_config(opts))
                end,
            })
        end,
    },
    {
        'stevearc/stickybuf.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'ibhagwan/fzf-lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        cmd = { "FzfLua" },
        opts = {
        },
    },
    {
        'junegunn/fzf.vim',
        dependencies = { 'junegunn/fzf' },
        cmd = {
            'RG',
            'Files',
            'GFiles',
            'Buffers',
            'Colors',
            'Ag',
            'Rg',
            'Lines',
            'BLines',
            'Tags',
            'BTags',
            'Marks',
            'Windows',
            'Locate',
            'History',
            'Snippets',
            'Commits',
            'BCommits',
            'Commands',
            'Maps',
            'Helptags',
            'Filetypes',
        },
        config = function()
            vim.api.nvim_exec([[
                function! RipgrepFzf(query, fullscreen)
                    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
                    let initial_command = printf(command_fmt, shellescape(a:query))
                    let reload_command = printf(command_fmt, '{q}')
                    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
                    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
                endfunction
                command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
            ]], false)
        end,
    }
}
