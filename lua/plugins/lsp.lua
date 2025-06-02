return {{
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
        'ibhagwan/fzf-lua',
        'onsails/lspkind-nvim',
        'gfanto/fzf-lsp.nvim',
        'nvim-lua/plenary.nvim',
        {
            'p00f/clangd_extensions.nvim',
            opts = {
                symbol_info = {
                    border = 'single',
                },
            },
        },
    },
    opts = {
        clangd = {
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                semanticHighlighting = true
            },
            flags = {
                allow_incremental_sync = true,
                debounce_text_changes = 1000,
            },
            cmd = { "clangd", "--log=error", "--background-index", "--clang-tidy" },
            after = function ()
                vim.keymap.set('n', '<leader>mo', '<cmd>ClangdSwitchSourceHeader<cr>', {silent = true, buffer = true})
            end,
        },
        gopls = { },
        pyright = { },
        jsonls = { },
        yamlls = { },
        ts_ls = { },
        harper_ls = {
            settings = {
                ['harper-ls'] = {
                    linters = {
                        SentenceCapitalization = false,
                        SpellCheck = false,
                    },
                },
            },
        },
        lua_ls = { },
        zls = { },
        dockerls = { },
        html = {
            cmd = {"vscode-html-languageserver"}
        },
        nixd = { },
        rust_analyzer = {
            cmd = {"rust-analyzer"},
            flags = {
                allow_incremental_sync = true,
                debounce_text_changes = 4000,
            },
            settings = {
                ["rust-analyzer"] = {
                    assist = {
                        importMergeBehaviour = "module",
                    },
                    checkOnSave = {
                        command = "clippy",
                    },
                    completion = {
                        addCallArgumentSnippets = true,
                        addCallParenthesis = true,
                        ["postfix.enable"] = true,
                    },
                    procMacro = {
                        enable = true,
                    },
                    cargo = {
                        loadOutDirsFromCheck = true,
                        buildScripts = {
                            enable = true,
                        },
                    },
                }
            }
        }
    },
    config = function(_, opts)
        local lspconfig = require 'lspconfig'
        local lspkind = require 'lspkind'

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = 'single',
            }
        )

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help, {
                border = 'single',
            }
        )

        local lsp_utils = require 'lsp-utils'
        for server, config in pairs(opts) do
            if type(config) == 'function' then
                config = config()
            end
            -- remap any existing on_attach to chain hook
            config.chain = config.on_attach

            config.on_attach = lsp_utils.make_on_attach(config)
            config.capabilities = vim.tbl_deep_extend('force',
                vim.lsp.protocol.make_client_capabilities(),
                require'blink.cmp'.get_lsp_capabilities({}, false)
            )

            lspconfig[server].setup(config)
        end

        local lsp_group = vim.api.nvim_create_augroup('UserLspProgress', {})
        vim.api.nvim_create_autocmd('LspProgress', {
            group = lsp_group,
            callback = lsp_utils.lsp_progress_callback,
        })

        lspkind.init({})
    end,
}}

