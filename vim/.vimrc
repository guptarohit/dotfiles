set encoding=utf-8 nobomb                           " Use UTF-8 without BOM
set number                                          " Enable line numbers
syntax on                                           " Enable syntax highlighting
set cursorline                                      " Highlight current line
set ruler                                           " Show the cursor position
set ignorecase                                      " Ignore case of searches
set title                                           " Show the filename in the window titlebar
set showcmd                                         " Show the (partial) command as it’s being typed

" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif

set scrolloff=3                                     " Start scrolling three lines before the horizontal window border
set nocompatible                                    " Make Vim more useful

set clipboard=unnamed                               " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set wildmenu                                        " Enhance command-line completion
set esckeys                                         " Allow cursor keys in insert mode
set backspace=indent,eol,start                      " Allow backspace in insert mode

" clipboard
set clipboard=unnamed                               " allow yy, etc. to interact with OS X clipboard

" search
set hlsearch                                        " highlighted search results
set showmatch                                       " show matching bracket

set autoread                                        " watch for file changes

" tabs and indenting
set autoindent                                      " auto indenting
set smartindent                                     " smart indenting
set expandtab                                       " spaces instead of tabs
set tabstop=2                                       " 2 spaces for tabs
set shiftwidth=2                                    " 2 spaces for indentation

" Temp Files
set nobackup                                        " No backup file
set noswapfile                                      " No swap file

" plugins manager
call plug#begin()
Plug 'catppuccin/vim', { 'as': 'catppuccin' }       " catppuccin theme
Plug 'vim-airline/vim-airline'                      " status bar
call plug#end()

" catppuccin theme for airline
let g:airline_theme = 'catppuccin_mocha'
