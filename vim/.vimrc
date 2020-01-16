" ░▒▓ AKUFOOLZ VIM DOTFILE v0.0.1 ▓▒░

" ░▒▓ VIM-PLUG SETTINGS ▓▒░

" installs vim-plug if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" specify directory for plugins
call plug#begin('~/.vim/plugged')

" plugins go here
Plug 'tpope/vim-sensible'
Plug 'kien/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'arcticicestudio/nord-vim'
Plug 'dylanaraps/wal.vim'
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" initialize plugin system
call plug#end()

" ░▒▓ GENERAL VIM SETTINGS ▓▒░

" initiate vim-sensible at runtime to allow overwriting
runtime! plugin/sensible.vim

set term=screen-256color
set t_ut=
let g:indentLine_char = '▏'

" adjust backup locations
set backupdir=.,$HOME/.vimbackups

" set encodings
set encoding=utf-8
set fileencodings=utf-8

" remove status line information
set noshowmode

" show line numbers
set number

" show tabline
set showtabline=2

" wrap lines
set wrap

" enable linebreaks
set linebreak

" set tabs to four spaces
set tabstop=2 shiftwidth=2

" use spaces instead of tabs
" set expandtab

" ignore case when searching
set ignorecase

" smartcase when searching
set smartcase

" enable spellcheck
"set spell

" ░▒▓ CUSTOM REMAP SETTINGS ▓▒░

" remap jj to escape in insert mode
inoremap jj <ESC>

" remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" ░▒▓ COLOR SCHEME SETTINGS ▓▒░

" set vim color scheme + options
let g:nord_italic_comments = 1
" colorscheme nord
colorscheme dracula 
" colorscheme wal

" fix opacity
hi Normal guibg=NONE ctermbg=NONE

" ░▒▓ GVIM GUI SETTINGS ▓▒░

if has('gui_running')

	" set gvim font
	set guifont=Powerline_Consolas:h10:cANSI:qDRAFT

	" remove gvim gui elements
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
	set guioptions-=L
	set guioptions-=e
endif

" ░▒▓ LIGHTLINE SETTINGS ▓▒░

let g:lightline = {
	\ 'colorscheme': 'dracula',
	\ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
	\ 'subseparator': { 'left': '▒', 'right': '░' }
	\ }

" ░▒▓ COC SPECIFIC SETTINGS ▓▒░
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[[` and `]]` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> [[ <Plug>(coc-diagnostic-prev)
nmap <silent> ]] <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
