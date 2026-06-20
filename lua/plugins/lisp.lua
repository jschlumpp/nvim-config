local lisp_languages = { 'clojure', 'fennel' }

return {
    {
        'Olical/conjure',
        ft = vim.list_extend({ 'python' }, lisp_languages),
        init = function()
            -- Set configuration options here
            -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
            -- This is VERY helpful when reporting an issue with the project
            -- vim.g["conjure#debug"] = true
        end,
    },
    {
        'eraserhd/parinfer-rust',
        ft = { 'clojure', 'fennel' },
        build = "cargo build --release",
        keys = {
            { "<leader>mp",  ft = lisp_languages, group = "parinfer" },

            { "<leader>mps", ft = lisp_languages, function() vim.g["parinfer_mode"] = "smart" end,  desc = 'smart' },
            { "<leader>mpi", ft = lisp_languages, function() vim.g["parinfer_mode"] = "indent" end, desc = 'indent' },
            { "<leader>mpp", ft = lisp_languages, function() vim.g["parinfer_mode"] = "paren" end,  desc = 'paren' },
        }
    }
}
