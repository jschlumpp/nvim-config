local parsers_requested = {
    -- Should use clangd highlighting
    c = { highlight = false },
    cpp = { highlight = false },

    diff = {},
    rust = {},
    asm = {},
    strace = {},
    make = {},
    ssh_config = {},
    regex = {},
    lua = {},
    nginx = {},
    cmake = {},
    vim = {},
    vimdoc = {},
    json = {},
    zig = {},
    nix = {},
    jq = {},
    awk = {},
    json5 = {},
    bash = {},
    sql = {},
    typescript = {},
    go = {},
    gosum = {},
    gomod = {},
    toml = {},
    python = {},
    comment = {},
    dockerfile = {},
    jjdescription = {},
}

---@param table table
---@param key string
---@param default any
---@return any
local function get_or_def(table, key, default)
    local value = table[key]
    if value == nil then
        return default
    end
    return value
end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        dependencies = {
            'shushtain/nvim-treesitter-incremental-selection',
            'nvim-treesitter/nvim-treesitter-context',
        },
        build = function()
            local treesitter = require 'nvim-treesitter'
            treesitter.install(vim.tbl_keys(parsers_requested))
            treesitter.update()
        end,
        init = function()
            local group = vim.api.nvim_create_augroup('UserTreeSitter', {})
            vim.api.nvim_create_autocmd('User', {
                group = group,
                pattern = "TSUpdate",
                callback = function()
                    local parsers = require 'nvim-treesitter.parsers'
                    parsers.jjdescription = {
                        install_info = {
                            url = 'https://github.com/kareigu/tree-sitter-jjdescription.git',
                            revision = '1613b8c85b6ead48464d73668f39910dcbb41911',
                            files = { 'src/parser.c' },
                            branch = "dev",
                        },
                        tier = 2,
                        filetype = 'jj',
                    }
                end
            })
            vim.api.nvim_create_autocmd('FileType', {
                group = group,
                callback = function(args)
                    -- Trigger load
                    require 'nvim-treesitter'

                    local filetype = args.match
                    local lang = vim.treesitter.language.get_lang(filetype)
                    if lang == nil or not vim.treesitter.language.add(lang) then
                        return
                    end

                    local tsis = require 'nvim-treesitter-incremental-selection'
                    vim.keymap.set({ 'n' }, '+', tsis.init_selection, { silent = true, noremap = true, buffer = true })
                    vim.keymap.set({ 'v' }, '+', tsis.increment_node, { silent = true, noremap = true, buffer = true })
                    vim.keymap.set({ 'v' }, '_', tsis.decrement_node, { silent = true, noremap = true, buffer = true })

                    local opts = parsers_requested[lang] or {}
                    if get_or_def(opts, "indent", true) then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                    if get_or_def(opts, "indent", true) then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                    if get_or_def(opts, "highlight", true) then
                        vim.treesitter.start(0, lang)
                    end
                end
            })
        end
    },
    {
        'shushtain/nvim-treesitter-incremental-selection',
        opts = { },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
            enable = true,
            max_lines = 6,
            separator = "─",
        },
    },
    {
        'gsuuon/tshjkl.nvim',
        keys = {
            "<M-v>"
        },
        config = true
    },
}
