with import <nixpkgs> {};

vim_configurable.customize {
  name = "vim";
  vimrcConfig.customRC = ''
    " Enable the use of the mouse for all modes
    set mouse=r

    " Show line numbers
    set number

    " Break lines
    set linebreak

    " Wrap lines
    set wrap
    " preserve indentation when wrapping lines
    set breakindent
    " add two additional spaces
    let &showbreak='  '

    " Allow reusing the same window and switch from an unsaved buffer without saving it first
    " (Also allows undo history for multiple files)
    set hidden

    " Highlight search
    set hlsearch

    " Use smartcase for search
    set smartcase

    " Use 2 spaces instead of tabs
    set expandtab
    set shiftwidth=2
    set smarttab
    set softtabstop=2

    " Smart indent lines
    set smartindent

    " Show the current row and column position
    set ruler

    " Replace pesky beep sound with visual bell...
    set visualbell
    " ... and reset terminal code for the visual bell to disable notification entirely
    set t_vb=

    " 'Modern' backspace behaviour
    set backspace=indent,eol,start

    " Set update interval to 100ms instead of 4000ms (reduce gitgutter update time)
    set updatetime=100


    """ CUSTOM VMAPS

    " r: Replace selected text region with current buffer without copying
    "vmap r "_dP

    " d: Shorthand for deleting selected text region without saving it to the buffer
    "vmap d "_d


    """ VIM AIRLINE

    " Automatically display all buffers when there is only one tab open
    let g:airline#extensions#tabline#enabled = 1

    " Define straight tabs
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'

    " Use unique_tail_improved as default path formatter
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

    " Enable powerline fonts for airline
    let g:airline_powerline_fonts = 1

    let g:powerline_pycmd = 'py3'


    """ MISC

    " Enable syntax highlighting
    syntax on

    " Allow intelligent auto-indenting for each filetype, and for plugins that are filetype-specific
    filetype indent plugin on
  '';
}
