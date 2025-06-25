local commands = {
    { 'nix',   'nix run .#build-plugin', nil },
    { 'cargo', 'cargo build --release',  nil },
}

-- Use an released version with binaries if no build tools are available
local version = '*' ---@type string?
local build_cmd ---@type string?

for _, cmd in ipairs(commands) do
    if vim.fn.executable(cmd[1]) == 1 then
        build_cmd = cmd[2]
        version = cmd[3]
        break
    end
end

return {
    {
        'saghen/blink.cmp',
        event = "VeryLazy",
        version = version,
        build = build_cmd,
        dependencies = { 'echasnovski/mini.snippets' },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
            },
            snippets = {
                preset = 'mini_snippets',
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            signature = {
                enabled = true,
                window = {
                    show_documentation = false,
                },
            },
        },
        opts_extend = { 'sources.default' },
    },
    {
        'echasnovski/mini.snippets',
        dependencies = { 'rafamadriz/friendly-snippets' },
        opts = function(_)
            local gen_loader = require 'mini.snippets'.gen_loader
            return {
                snippets = {
                    gen_loader.from_lang(),
                },
            }
        end,
    },
    {
        'chrisgrieser/nvim-scissors',
        opts = {
            snippetDir = vim.fn.stdpath('config') .. '/snippets',
        },
        keys = {
            { '<leader>css', function() require 'scissors'.addNewSnippet() end, mode = {'n', 'x'}, desc = 'snippet-add' },
            { '<leader>cse', function() require 'scissors'.editSnippet() end, desc = 'snippet-edit' },
        },
    }
}
