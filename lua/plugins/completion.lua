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

return { {
    'saghen/blink.cmp',
    event = "VeryLazy",
    version = version,
    build = build_cmd,
    dependencies = { 'rafamadriz/friendly-snippets' },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'default' },
        appearance = {
            use_nvim_cmp_as_default = true,
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
    },
    opts_extend = { 'sources.default' },
} }
