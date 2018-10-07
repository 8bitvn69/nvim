" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" Manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" This needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.config/nvim/plugged')

" Now the actual plugins:

" Monokai colorscheme
Plug 'crusoexia/vim-monokai'

" Vim airline - status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Async autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Python autocompletion
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim'

" Surround - parentheses, brackets, quotes, XML tags, ...
Plug 'tpope/vim-surround'
" Add . repeating support for Surround plugin
Plug 'tpope/vim-repeat'

" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'


" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" Use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
    let &t_Co = 256
    let g:monokai_term_italic = 1
    let g:monokai_gui_italic = 1
    colorscheme monokai
else
    colorscheme delek
endif

" Tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Show line numbers
set nu

" Prevent wrapping lines and change sidescroll behavior
set nowrap
set sidescroll=1

" When scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Set theme for airline
let g:airline_theme='jellybeans'

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" Turn off preview related to the selected completion option
set completeopt-=preview

" Deoplete setup
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}
