local function option(name, value, targets)
    local t = targets
    local v = value
    if targets == nil then
        t = {vim.o}
    end
    if value == nil then
        v = true
    end
    for i, target in ipairs(t) do
         target[name] = v
    end
end

local buffer = {vim.o, vim.bo}
local window = {vim.o, vim.wo}
option('shortmess', vim.o.shm .. 'I')
option('incsearch')
option('ignorecase')
option('smartcase')
option('wildignorecase')
option('autoread')
option('showmode', false)
option('laststatus', 2)
option('ruler')
option('number', true, window)
option('hidden')
option('updatetime', 300)
option('timeoutlen', 500)
option('cmdheight', 2)
option('signcolumn', 'auto', window)
option('termguicolors')
option('completeopt', 'menu,menuone,noselect')
option('shortmess', vim.o.shortmess .. 'c')
option('mouse', 'a')
option('undofile', true, buffer)
option('cursorline', true, window)
option('wildmenu', false)
option('inccommand', 'split')
option('list', true, window)
option('mousemodel', 'extend')
option('listchars', 'lead:·,tab:> ,nbsp:+,trail:-')
vim.opt.formatoptions:remove { 't' }
vim.opt.formatoptions:append { '/' }

vim.g.mapleader = ' '
vim.g.localleader = '\\'

-- tab settings
option('smarttab')
option('expandtab', true, buffer)
option('shiftwidth', 4, buffer)

-- Disable matchparen as it causes stutters
-- vim.cmd([[let loaded_matchparen = 1]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    defaults = {
        lazy = true,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'netrwPlugin',
                'rplugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
    dev = {
        path = vim.fn.stdpath('config') .. '/local_plugins',
    },
})

-- GUI
option('guifont', 'Iosevka Term:h14')

-- Ensure buffers automatic buffer reloading. Uses silent to prevent error messages for command line window/search history.
vim.api.nvim_exec([[
    augroup focus_checktime
        au!
        au FocusGained,BufEnter * :silent! checktime
    augroup END
]], false)

-- Use spellchecking/wordbreaks in text buffers
vim.api.nvim_exec([[
    augroup text_spellcheck
        au!
        au FileType tex,markdown setlocal spell linebreak
    augroup END
]], false)

vim.filetype.add({
    filename = {
        ['Config.uk'] = 'kconfig',
        ['Makefile.uk'] = 'make',
        ['Makefile.rules'] = 'make',
    },
})

local uk_group = vim.api.nvim_create_augroup('unikraft', { })
vim.api.nvim_create_autocmd('FileType', {
    group = uk_group,
    pattern = {'make', 'kconfig'},
    callback = function()
        vim.opt_local.shiftwidth = 8
        vim.opt_local.tabstop = 8
        vim.opt_local.expandtab = false
    end,
})

vim.filetype.add({
    filename = {
        ['Kraftfile'] = 'yaml',
        ['.swcrc'] = 'json',
    },
})

-- some additional keybinds
vim.api.nvim_set_keymap('n', ']q', '<cmd>cn<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '[q', '<cmd>cp<cr>', { silent = true, noremap = true })

-- Select last yanked/changed text
vim.keymap.set('n', 'g<c-v>', "'`[' . getregtype()[0] . '`]'", { expr = true })

-- More convenient window navigation
vim.api.nvim_set_keymap('', '<m-c-up>', '<c-w>k', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<m-c-down>', '<c-w>j', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<m-c-left>', '<c-w>h', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<m-c-right>', '<c-w>l', { silent = true, noremap = true })
-- Same for the terminal
vim.keymap.set({'t', 'i'}, '<m-c-up>', '<C-\\><C-N><c-w>k', { silent = true, noremap = true })
vim.keymap.set({'t', 'i'}, '<m-c-down>', '<C-\\><C-N><c-w>j', { silent = true, noremap = true })
vim.keymap.set({'t', 'i'}, '<m-c-left>', '<C-\\><C-N><c-w>h', { silent = true, noremap = true })
vim.keymap.set({'t', 'i'}, '<m-c-right>', '<C-\\><C-N><c-w>l', { silent = true, noremap = true })

vim.keymap.set('n', '<m-k>', '<c-w>k', { silent = true, noremap = true })
vim.keymap.set('n', '<m-j>', '<c-w>j', { silent = true, noremap = true })
vim.keymap.set('n', '<m-h>', '<c-w>h', { silent = true, noremap = true })
vim.keymap.set('n', '<m-l>', '<c-w>l', { silent = true, noremap = true })

vim.keymap.set('t', '<esc>', function ()
    local ft = vim.bo.filetype
    if ft == 'fzf' or ft == 'lazygit' then
        return '<esc>'
    else
        return '<c-\\><c-n>'
    end
end, { expr = true })

-- IDE features tweaks
vim.diagnostic.config({
    signs = true,
    update_in_insert = false,
    underline = true,
    virtual_lines = { current_line = true },
})

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

-- git in nvim terminal
vim.api.nvim_exec([[
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit,gitrebase set bufhidden=delete
]], false)

