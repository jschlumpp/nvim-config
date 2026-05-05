return {
    {
        'arborist-ts/arborist.nvim',
        opts = {
            concurrency = 8,
            install_popular = false,
            ensure_installed = {
                'c',
                'cpp',
                'rust',
                'lua',
                'nix',
                'diff',
                'python',
            },
            disable = {
                highlight = { "c", "cpp" },
            }
        },
        event = 'VeryLazy',
    },
    {
        'shushtain/nvim-treesitter-incremental-selection',
        keys = {
            { "+", function() require 'nvim-treesitter-incremental-selection'.init_selection() end, noremap = true, silent = true, mode = "n", desc = "Incremental selection", },
            { "+", function() require 'nvim-treesitter-incremental-selection'.increment_node() end, noremap = true, silent = true, mode = "v", desc = "Increment selection", },
            { "_", function() require 'nvim-treesitter-incremental-selection'.decrement_node() end, noremap = true, silent = true, mode = "v", desc = "Decrement selection", },
        },
        opts = {},
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
            enable = true,
            max_lines = 6,
            separator = "─",
        },
        event = 'VeryLazy',
    },
    {
        'gsuuon/tshjkl.nvim',
        keys = {
            "<M-v>"
        },
        config = true,
    },
}
