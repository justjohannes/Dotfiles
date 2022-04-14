Plug 'romgrk/doom-one.vim'

"""""""""""""""""""""""""""""""""""""""""""
"Colorshceme
"""""""""""""""""""""""""""""""""""""""""""

set termguicolors                       " 
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"  " For true colors inside alacritty
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"  "  


augroup Doom-OneOverrides
    autocmd User color ++nested colorscheme doom-one
augroup end
set background=dark
