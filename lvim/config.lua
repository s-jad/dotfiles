--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true


----------------------- USEFUL SHORTCUTS ---------------------------------

local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------------- GENERAL APPEARANCE --------------------------

lvim.sonokai_style = "espresso"
lvim.sonkai_enable_italic = "1"
lvim.sonokai_diagnostic_text_highlight = "1"
lvim.sonokai_current_word = 'bold'
lvim.sonokai_transparent_bg= "100"

lvim.colorscheme = "sonokai"

cmd([[
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
hi Normal ctermbg=NONE guibg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi CursorLineNR ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
]])

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
   -- for input mode
   i = {
     ["<C-j>"] = actions.move_selection_next,
     ["<C-k>"] = actions.move_selection_previous,
     ["<C-n>"] = actions.cycle_history_next,
     ["<C-p>"] = actions.cycle_history_prev,
   },
   -- for normal mode
   n = {
     ["<C-j>"] = actions.move_selection_next,
     ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "fish",
  "c",
  "javascript",
  "json",
  "julia",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugin
 lvim.plugins = {
    'tribela/vim-transparent',
     {"folke/tokyonight.nvim"},
     {
       "folke/trouble.nvim",
       cmd = "TroubleToggle",
     },
    {"lervag/vimtex", opt=true},      -- Use braces when passing options
    'ojroques/nvim-lspfuzzy',
    'SirVer/ultisnips',
     'roxma/ncm2',
    'Nudin/vimwiki',
    'sainnhe/artify.vim',
    'rmolin88/pomodoro.vim',
    'ryanoasis/vim-devicons',
    'junegunn/goyo.vim',
    'sainnhe/gruvbox-material',
    'vim-pandoc/vim-pandoc',
    'vim-pandoc/vim-pandoc-syntax',
     'vim-airline/vim-airline',
    'morhetz/gruvbox',
    'sainnhe/sonokai',
    'sainnhe/everforest',
    'dag/vim-fish',
    'edkolev/tmuxline.vim',
    {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'},
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

------------------------ TREESITTER MAPPINGS -----------------------------------

map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

----------------------- APPEARANCE --------------------------------------------

opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for deoplete)
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 2                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 2                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.guifont = "Hack Nerd Font, 12"
opt.number = true
opt.linespace = 22

----------------------------- AIRLINE OPTIONS ------------------------------------

cmd([[
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
 endif
 
 let g:airline_left_sep = ''
 let g:airline_left_alt_sep = ''
 let g:airline_right_sep = ''
 let g:airline_right_alt_sep = ''
 let g:airline#extensions#tmuxline#enabled = 1
 let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"
]])

-------------------------------- GOYO ZEN MODE -------------------------------------
g.goyo_width = "1400";
g.goyo_height = "900";

-------------------------------- CALCURSE CONFIG -----------------------------------

cmd([[
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufNewFile /tmp/calcurse*,~/.local/share/calcurse/notes/* 0r ~/.vim/templates/calendar_notes.md
autocmd BufNewFile *.rs 0r ~/.vim/templates/rust_template.rs
autocmd BufNewFile *.sh 0r ~/.vim/templates/script_template.sh
autocmd BufNewFile *.py 0r ~/.vim/templates/python_script.py
autocmd BufNewFile *.fish 0r ~/.vim/templates/fish_script.fish
]])

