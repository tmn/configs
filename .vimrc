:syntax on
set shiftwidth=4 softtabstop=4
:set number
:highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=Grey guibg=NONE
:set cursorline

:set so=999
"" :colorscheme ir_black

set cindent
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
"" set cinkeys=0(,0),_,0#,!,!^F

nnoremap å :tabnew<cr>
nnoremap ø :tabprev<cr>
nnoremap æ :tabnext<cr>
nnoremap @ :! pdflatex 


