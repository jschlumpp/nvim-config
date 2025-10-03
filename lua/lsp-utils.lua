local M = {}

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()

---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
function M.lsp_progress_callback(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
        return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
        if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                    value.kind == "end" and 100 or value.percentage or 100,
                    value.title or "",
                    value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
            }
            break
        end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
        return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
        id = "lsp_progress",
        title = client.name,
        opts = function(notif)
            notif.icon = #progress[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
    })
end

function M.make_on_attach(config)
    return function(client, bufnr)
        ---@param mode string|string[]
        ---@param lhs string
        ---@param rhs string|function
        ---@param opts? vim.keymap.set.Opts
        local function buf_set_keymap(mode, lhs, rhs, opts)
            local default_opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', default_opts, opts or {}))
        end

        --- @param name string
        --- @param value any
        local function buf_set_option(name, value)
            vim.api.nvim_set_option_value(name, value, { buf = bufnr })
        end

        if config.before then config.before(client) end

        buf_set_keymap('n', 'gd', Snacks.picker.lsp_definitions, { desc = "lsp-definitions" })
        buf_set_keymap('n', 'gD', Snacks.picker.lsp_declarations, { desc = "lsp-declarations" })
        buf_set_keymap('n', 'gi', Snacks.picker.lsp_implementations, { desc = "lsp-implementations" })
        buf_set_keymap('n', 'gy', Snacks.picker.lsp_type_definitions, { desc = "lsp-type-definitions" })
        buf_set_keymap('n', 'gr', Snacks.picker.lsp_references, { desc = "lsp-references" })

        buf_set_keymap('n', '<leader>co', vim.lsp.buf.outgoing_calls)
        buf_set_keymap('n', '<leader>ci', vim.lsp.buf.incoming_calls)
        buf_set_keymap('n', 'K', vim.lsp.buf.hover)
        buf_set_keymap('i', '<c-q>', vim.lsp.buf.signature_help)
        buf_set_keymap('n', '<leader>cn', vim.lsp.buf.rename)
        buf_set_keymap('n', '<M-CR>', '<cmd>FzfLua lsp_code_actions<CR>')
        buf_set_keymap('v', '<M-CR>', vim.lsp.buf.code_action)
        buf_set_keymap('n', ']g',
            function() vim.diagnostic.jump({ count = 1, float = true, popup_opts = { border = "single" } }) end)
        buf_set_keymap('n', '[g',
            function() vim.diagnostic.jump({ count = -1, float = true, popup_opts = { border = "single" } }) end)

        buf_set_keymap('n', '<leader>e',
            function() vim.diagnostic.open_float({ bufnr = 0, scope = "line", popup_opts = { border = "single" } }) end)
        buf_set_keymap('n', '<leader>E', vim.diagnostic.setqflist)

        if client.server_capabilities.documentFormattingProvider then
            buf_set_keymap({ 'n', 'v' }, '<leader>=', vim.lsp.buf.format)
        end

        if client.server_capabilities.documentHighlightProvider then
            local lsp_aucmds = vim.api.nvim_create_augroup('p_lsp_aucmds', {})
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                group = lsp_aucmds,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.document_highlight()
                end
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                group = lsp_aucmds,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.clear_references()
                end
            })
        end

        buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')
        buf_set_option('tagfunc', 'v:lua.vim.lsp.tagfunc')

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        if config.after then config.after(client, bufnr) end
        if config.chain then config.chain(client, bufnr) end
    end
end

return M
