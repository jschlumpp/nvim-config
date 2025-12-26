local configs = {
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
    },
    uiua = {},
    gopls = {},
    pyright = {},
    jsonls = {},
    yamlls = {},
    ts_ls = {},
    harper_ls = {
        settings = {
            ['harper-ls'] = {
                linters = {
                    SentenceCapitalization = false,
                    SpellCheck = false,
                    ToDoHyphen = false,
                },
            },
        },
    },
    lua_ls = {},
    zls = {},
    dockerls = {},
    html = {
        cmd = { "vscode-html-languageserver" }
    },
    nixd = {},
    tinymist = { },
    rust_analyzer = {
        flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 4000,
        },
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importMergeBehaviour = "module",
                },
                checkOnSave = true,
                check = {
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
}

return {
    {
        'j-hui/fidget.nvim',
        opts = { },
    },
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            'ibhagwan/fzf-lua',
            'onsails/lspkind-nvim',
            'gfanto/fzf-lsp.nvim',
            'nvim-lua/plenary.nvim',
            'j-hui/fidget.nvim',
            {
                'p00f/clangd_extensions.nvim',
                opts = {
                    symbol_info = {
                        border = 'single',
                    },
                },
            },
        },
        config = function()
            local lspkind = require 'lspkind'
            lspkind.init()

            -- Apply configuration and mark them for auto-start
            for name, config in pairs(configs) do
                vim.lsp.config(name, config)
            end
            vim.lsp.enable(vim.tbl_keys(configs))

            local lsp_group = vim.api.nvim_create_augroup('UserLsp', {})

            -- Setup buffer-local things
            vim.api.nvim_create_autocmd('LspAttach', {
                group = lsp_group,
                callback = function(args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                    ---@param mode string|string[]
                    ---@param lhs string
                    ---@param rhs string|function
                    ---@param opts? vim.keymap.set.Opts
                    local function buf_set_keymap(mode, lhs, rhs, opts)
                        local default_opts = { noremap = true, silent = true, buffer = args.buf }
                        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', default_opts, opts or {}))
                    end

                    buf_set_keymap('n', 'gD', Snacks.picker.lsp_declarations, { desc = "lsp-declarations" })
                    buf_set_keymap('n', 'gri', Snacks.picker.lsp_implementations, { desc = "lsp-implementations" })
                    buf_set_keymap('n', 'grt', Snacks.picker.lsp_type_definitions, { desc = "lsp-type-definitions" })
                    buf_set_keymap('n', 'grr', Snacks.picker.lsp_references, { desc = "lsp-references" })

                    buf_set_keymap('n', '<leader>co', vim.lsp.buf.outgoing_calls)
                    buf_set_keymap('n', '<leader>ci', vim.lsp.buf.incoming_calls)
                    buf_set_keymap('n', 'K', function() vim.lsp.buf.hover({ border = 'single' }) end)
                    buf_set_keymap('n', '<leader>cn', vim.lsp.buf.rename)
                    buf_set_keymap('n', '<M-CR>', '<cmd>FzfLua lsp_code_actions<CR>')
                    buf_set_keymap('v', '<M-CR>', vim.lsp.buf.code_action)

                    if client:supports_method('textDocument/formatting') then
                        buf_set_keymap({ 'n', 'v' }, '<leader>=', function() vim.lsp.buf.format() end)
                    end

                    if client:supports_method('textDocument/documentHighlight') then
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.document_highlight()
                            end
                        })
                        vim.api.nvim_create_autocmd('CursorMoved', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.clear_references()
                            end
                        })
                    end

                    if client:supports_method('textDocument/inlayHint') then
                        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                    end
                end
            })
        end,
    },
}
