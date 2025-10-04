return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function(plugin)
        return {
            extensions = {
                'quickfix',
                'nvim-tree',
                'toggleterm',
                'fugitive',
                'man',
                'fzf',
            },
            options = {
                theme = 'auto',
                icons_enabled = true,
            },
            sections = {
                lualine_b = { 'branch', 'diff' },
                lualine_c = {
                    'filename',
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' }
                    },
                },
                lualine_x = {
                    'encoding',
                    'fileformat',
                    function()
                        -- Use bo.filetype directly because the lualine filetype
                        -- handles a unloaded web-devicons package very poorly (it
                        -- searches for the package using `require` *every* redraw,
                        -- even when the icons are disabled. While require keeps a list
                        -- of loaded packages, it does not optimize for "cache-misses")
                        return vim.bo.filetype or ''
                    end,
                },
                lualine_y = {
                    'progress',
                    { require 'recorder'.displaySlots },
                },
                lualine_z = {
                    { require 'recorder'.recordingStatus },
                    'location',
                }
            },
        }
    end,
}
