" ~/.config/nvim/init.vim

" --- Core Vim Settings ---
set nocompatible            " Use Neovim defaults, not vi compatible
set encoding=utf-8          " Set default encoding to UTF-8
syntax on                   " Enable syntax highlighting
filetype plugin indent on   " Enable filetype detection, plugins, and indentation

" --- Appearance ---
" set termguicolors         " Enable true colors support (Recommended for modern terminals & colorschemes)
set notermguicolors         " Disable true colors (Keep if you have issues or prefer it)
set number                  " Show line numbers
set cursorline              " Highlight the current line
set showmatch               " Highlight matching brackets
set background=dark         " Assume a dark background (important for colorschemes)
" set cc=80                 " Uncomment to draw a line at 80 columns

" --- Behavior ---
set autoindent              " Copy indent from current line when starting a new line
set smartindent             " Be smart about indentation
set autoread                " Automatically reload files changed outside of Vim
au CursorHold * checktime   " Check for external file changes when cursor is idle
set mouse=                  " Disable mouse support (as you have it)
" set mouse=a               " Uncomment to enable mouse support
" set clipboard=unnamedplus " Uncomment to use system clipboard for copy/paste
set noswapfile              " Disable swap files
" set backupdir=~/.cache/vim " Uncomment and create dir to store backup files elsewhere

" --- Search ---
set hlsearch                " Highlight all search matches
set incsearch               " Show search matches incrementally
" set ignorecase            " Uncomment for case-insensitive search
" set smartcase             " Uncomment (with ignorecase) for case-sensitive search if pattern contains uppercase

" --- Tabs & Indentation ---
set tabstop=4               " Number of visual spaces per tab
set softtabstop=4           " Number of spaces for editing operations (e.g., backspace)
set shiftwidth=4            " Number of spaces for autoindent
set expandtab               " Use spaces instead of tabs

" --- Command Line & Completion ---
set wildmode=longest,list   " Bash-like command line completion
set wildmenu                " Show command menu during completion

" --- Window Splits ---
set splitright              " Open vertical splits to the right
set splitbelow              " Open horizontal splits below

" --- Cursor Position Restore ---
" Restore cursor position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" --- Plugin Manager: vim-plug ---
call plug#begin('~/.local/share/nvim/plugged') " Specify plugin directory

" LSP, Completion & Snippets
Plug 'neovim/nvim-lspconfig'             " LSP configuration utility
Plug 'williamboman/mason.nvim'           " Package manager for LSPs, DAPs, linters, formatters
Plug 'williamboman/mason-lspconfig.nvim' " Bridge between Mason and lspconfig
Plug 'hrsh7th/nvim-cmp'                  " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp'              " nvim-cmp source for LSP
Plug 'hrsh7th/cmp-buffer'                " nvim-cmp source for buffer words
Plug 'hrsh7th/cmp-path'                  " nvim-cmp source for paths
Plug 'hrsh7th/cmp-cmdline'               " nvim-cmp source for command line
Plug 'SirVer/ultisnips'                  " Snippet engine
Plug 'quangnguyen30192/cmp-nvim-ultisnips' " nvim-cmp source for UltiSnips
Plug 'honza/vim-snippets'                " Collection of snippets for UltiSnips

" Syntax & Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Better syntax highlighting & code analysis
Plug 'sheerun/vim-polyglot'              " Large collection of language packs (alternative/fallback to Treesitter)

" File Explorer & Start Screen
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'} " File explorer
Plug 'mhinz/vim-startify'                " Start screen

" Folding
Plug 'pseewald/vim-anyfold'              " Automatic folding based on indentation/treesitter

" Colorscheme & Theming
Plug 'deviantfero/wpgtk.vim'             " Colorscheme based on wpgtk

" --- Potentially Unused/Commented Plugins (Consider removing if not needed) ---
" Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' } " AI code completion (Alternative to cmp/LSP)
" Plug 'hrsh7th/cmp-vsnip'               " cmp source for vim-vsnip (if you switch snippet engines)
" Plug 'hrsh7th/vim-vsnip'               " Alternative snippet engine
" Plug 'neoclide/coc.nvim', {'branch': 'release'} " Completion framework (Alternative to nvim-cmp/LSP)
" Plug 'Valloric/YouCompleteMe'          " Completion framework (Alternative)
" Plug 'lommix/godot.nvim'               " Godot specific features
" Plug 'elkowar/yuck.vim'                " Syntax for yuck files (eww)
" Plug 'folke/tokyonight.nvim'           " Colorscheme
" Plug 'scrooloose/nerdtree'             " File explorer (Alternative to CHADTree)
" Plug 'preservim/nerdcommenter'         " Plugin for easy commenting
" Plug 'jbyuki/instant.nvim'             " Collaborative editing
" Plug 'morhetz/gruvbox'                 " Colorscheme
" Plug 'ObserverOfTime/coloresque.vim'   " CSS color preview
" Plug 'rose-pine/neovim'                " Colorscheme

" Must be last plugin loaded if using vim-plug with itself
Plug 'junegunn/vim-plug'                 " vim-plug itself

call plug#end()

" --- Plugin Configurations ---

" Colorscheme (wpgtk)
" Note: `colorscheme vim` before this is likely unnecessary unless wpgtkAlt fails
colorscheme wpgtkAlt
" colorscheme tokyonight-night " Example alternative
" colorscheme gruvbox          " Example alternative

" Anyfold (Folding)
" filetype plugin indent on and syntax on are already enabled globally
autocmd Filetype * AnyFoldActivate " Activate for all filetypes
" autocmd Filetype <your-filetype> AnyFoldActivate " Activate for a specific filetype
set foldmethod=expr     " Required by Anyfold
set foldexpr=AnyFold()  " Required by Anyfold
set foldlevel=99        " Start with folds open
" set foldlevel=0       " Uncomment to start with all folds closed

" UltiSnips (Snippets)
let g:UltiSnipsExpandTrigger="<C-Space>"   " Trigger snippet expansion
let g:UltiSnipsJumpForwardTrigger="<c-b>"  " Jump to next placeholder in snippet
let g:UltiSnipsJumpBackwardTrigger="<c-z>" " Jump to previous placeholder in snippet

" CHADTree (File Explorer)
map <F2> :CHADopen<CR> " Toggle CHADTree with F2
" nnoremap <C-f> :NERDTreeFind<CR> " Keep commented as NERDTree is commented

" Startify (Start Screen)
let g:startify_bookmarks = [
      \ { 'a': '~/.ricing/' },
      \ { 's': '~/.config/polybar/scripts/' },
      \ { 'd': '~/.bscripts/' },
      \ { 'f': '~/' },
      \ ]
let g:startify_lists = [
    \ { 'header': ['     Bookmarks'],       'type': 'bookmarks' },
    \ { 'header': ['     MRU'],             'type': 'files' },
    \ ]
let g:startify_custom_header = [
    \ '         ,--.                                                        ',
    \ '       ,--.!|                                                 ____   ',
    \ '   ,--,:  : |                                ,--,           ,!  , `. ',
    \ ',`--.!`|  ! :             ,---.            ,--.!|        ,-+-,.! _ | ',
    \ '|   :  :  | |            !   ,!\      .---.|  |,      ,-+-. ;   , || ',
    \ ':   |   \ | :   ,---.   /   /   |   /.  ./|`--!_     ,--.!|!   |  || ',
    \ '|   : !  !; |  /     \ .   ; ,. : .-! . ! |,! ,!|   |   |  ,!, |  |, ',
    \ '!   ! ;.    ; /    /  |!   | |: :/___/ \: |!  | |   |   | /  | |--!  ',
    \ '|   | | \   |.    ! / |!   | .; :.   \  ! .|  | :   |   : |  | ,     ',
    \ '!   : |  ; .!!   ;   /||   :    | \   \   !!  : |__ |   : |  |/      ',
    \ '|   | !`--!  !   |  / | \   \  /   \   \   |  | !.!||   | |`-!       ',
    \ '!   : |      |   :    |  `----!     \   \ |;  :    ;|   ;/           ',
    \ ';   |.!       \   \  /               !---" |  ,   / !---!            ',
    \ '!---!          `----!                       ---`-!                   ',
    \ '',
    \ ]
" nmap <c-m> :Startify<cr> " Uncomment to map Ctrl+M to open Startify

" --- Coloresque Config (Plugin is commented out) ---
" let g:coloresque_whitelist = [
"       \ 'css', 'haml', 'html', 'htmldjango', 'svelte',
"       \ 'javascript', 'jsx', 'less', 'php',
"       \ 'postcss', 'pug', 'qml', 'sass',
"       \ 'scss', 'sh', 'stylus', 'svg',
"       \ 'typescript', 'vim', 'vue', 'xml', 'plaintext' ]
" let g:coloresque_extra_filetypes = [
"     \ 'ini', 'conf', 'dunstrc'
"     \ ]

" --- Instant Config (Plugin is commented out) ---
" let g:instant_username = "kz87"

" --- Mappings ---

" Toggle options
map <F3> :set nu!<CR>     " Toggle line numbers
map <F4> :set wrap!<CR>   " Toggle line wrapping
map <F5> :set hlsearch!<CR> " Toggle search highlighting

" Pane/Split navigation and manipulation
nnoremap <A-h> <C-W>H     " Move current split to far left
nnoremap <A-j> <C-W>J     " Move current split to very bottom
nnoremap <A-k> <C-W>K     " Move current split to very top
nnoremap <A-l> <C-W>L     " Move current split to far right
nnoremap <C-h> <C-w>h     " Move focus to the split left
nnoremap <C-l> <C-w>l     " Move focus to the split right
" Note: <C-j> and <C-k> often used by plugins, map explicitly if needed
" nnoremap <C-j> <C-w>j  " Move focus to the split below
" nnoremap <C-k> <C-w>k  " Move focus to the split above

" Tab navigation and manipulation
map <C-d> gt              " Go to next tab
map <C-a> gT              " Go to previous tab
map <C-t> :tabnew<CR>     " Open a new tab
map <C-w> :tabclose<CR>   " Close current tab (Use :q for window/buffer)

" Insert mode exit
" WARNING: <C-i> is often the same as <Tab> in terminals and used for jump list forward.
" This mapping might interfere with expected behavior. Consider `inoremap jk <Esc>` or similar.
" The comment "Press i to enter insert mode, and ii to exit insert mode." does not match the mapping.
inoremap <C-i> <Esc>      " Exit insert mode with Ctrl+i

" Visual mode copy to system clipboard (requires xclip)
vnoremap <C-c> :'<,'>w !xclip -i -sel c<CR><CR> " Copy visual selection to clipboard

" Save mappings (currently commented out)
" inoremap <C-s> <cmd>write<CR>
" nnoremap <C-s> :w<CR>

" --- Lua Configuration ---

lua <<EOF
-- --- Mason & LSP ---
require("mason").setup()

-- Centralized place to list LSPs to install via Mason
-- NOTE: gdscript LSP is NOT installed via Mason, it runs within Godot Editor
local servers_to_ensure_installed = {
  "pyright",
  "tailwindcss",
  -- Add other Mason-managed LSPs here
}

require("mason-lspconfig").setup({
  ensure_installed = servers_to_ensure_installed,
})

-- Get capabilities from cmp_nvim_lsp for LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure LSPs installed via Mason using lspconfig
for _, server_name in ipairs(servers_to_ensure_installed) do
  require('lspconfig')[server_name].setup {
    capabilities = capabilities
    -- Add any server-specific settings here if needed
  }
end

-- --- Configure GDScript LSP (Connects to running Godot Editor) ---
require('lspconfig').gdscript.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- Optional: You can add keymaps specific to LSP features here
      -- Example: vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
      -- Example: vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
      print("GDScript LSP Attached to buffer " .. bufnr)
    end,
    -- You can customize the port if your Godot editor uses a different one
    -- port = 6008,
}
-- Get capabilities from cmp_nvim_lsp for LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure LSPs using lspconfig
-- Loop through the installed servers and set them up
for _, server_name in ipairs(servers_to_ensure_installed) do
  -- Skip pylsp setup here if pyright is preferred and installed
  -- if server_name == "pylsp" and vim.list_contains(servers_to_ensure_installed, "pyright") then
  --   print("Skipping pylsp setup as pyright is also installed.")
  -- else
    require('lspconfig')[server_name].setup {
      capabilities = capabilities
      -- Add any server-specific settings here inside setup {}
      -- Example for pyright:
      -- settings = {
      --   python = {
      --     analysis = {
      --       autoSearchPaths = true,
      --       diagnosticMode = "workspace",
      --       useLibraryCodeForTypes = true
      --     }
      --   }
      -- }
    }
  -- end
end

-- Note: The separate pylsp setup below is now redundant if you add 'pylsp'
-- to the `servers_to_ensure_installed` list above and handle potential
-- conflicts (e.g., don't run both pyright and pylsp for python files).
-- If you specifically want pylsp *instead* of pyright, remove "pyright"
-- from the list and add "pylsp".
-- require('lspconfig').pylsp.setup{
--   capabilities = capabilities -- Ensure capabilities are passed if using this
-- }


-- --- nvim-cmp (Completion) ---
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- Use UltiSnips
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
    -- Add borders to completion and documentation windows
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),       -- Scroll documentation up
    ['<C-f>'] = cmp.mapping.scroll_docs(4),        -- Scroll documentation down
    ['<A-Space>'] = cmp.mapping.complete(),        -- Show completion suggestions
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- Select next item
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- Select previous item
    ['<C-e>'] = cmp.mapping.abort(),               -- Close completion window
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection (select=true means confirm even if not explicitly selected)
  }),
  -- Define sources for completion suggestions
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },    -- LSP suggestions
    { name = 'ultisnips' },   -- Snippet suggestions
    { name = 'buffer' },      -- Suggestions from words in current buffer
    { name = 'path' }         -- Suggestions for file paths
  })
})

-- Configure completion for command line mode
-- Use buffer source for '/' and '?' (search)
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use path and cmdline source for ':' (commands)
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- --- TabNine Config (Plugin is commented out) ---
-- require('tabnine').setup({
--   disable_auto_comment=true,
--   accept_keymap="<C-Enter>",
--   dismiss_keymap = "<C-BS>",
--   debounce_ms = 800,
--   suggestion_color = {gui = "#808080", cterm = 244},
--   exclude_filetypes = {"TelescopePrompt", "NvimTree"},
--   log_file_path = nil, -- absolute path to Tabnine log file
--   ignore_certificate_errors = false,
-- })

EOF


lua <<EOF
-- --- Treesitter ---
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "c", "lua", "vim", "vimdoc", "query", "python", "javascript",
    "typescript", "html", "css",
    "gdscript" -- <<< ADDED GDScript HERE
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you manage parsers manually with :TSInstall
  auto_install = true,

  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true -- Enable indentation based on treesitter
  },
}
EOF


