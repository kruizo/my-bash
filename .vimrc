let mapleader = " "  " Set the leader key to space

set tabstop=4        " Number of spaces that a tab represents
set shiftwidth=4     " Number of spaces to use for each level of indentation
set expandtab        " Converts tabs to spaces
set autoindent       " Automatically indent to match the previous line
set smartindent      " Automatically adds extra indent in programming files
set smarttab         " Makes tab insert spaces in leading whitespace
set showmatch        " Show matching brackets
set ignorecase       " Ignore case when searching
set number           " Show line numbers
set incsearch        " Show search matches as you type
set hlsearch         " Highlight search matches
" Map <leader>e to open :Explore in the current working directory

set clipboard^=unnamed     " Use the system clipboard
set clipboard^=unnamedplus " Use the system clipboard
set history=300           " Number of commands to remember


inoremap <A> <Esc>
nnoremap <leader>e :Explore<CR>
nnoremap <ALT>f :find<CR>
