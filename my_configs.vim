" Custom config applied after amix/vimrc
colorscheme holokai
set background=dark

set history=1000
set ttyfast
set so=15
set number
set cursorline " highlight current line with cursor
set ruler " shows position in lower right corner
set cmdheight=1
set noshowmode
set hid " buffer becomes hidden when abandoned
set mat=4

set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldlevel=99

" C-<space> toggles folding
noremap <c-space> za

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

noremap <silent><expr> z/ incsearch#go(<SID>config_fuzzyall())
noremap <silent><expr> z? incsearch#go(<SID>config_fuzzyall({'command': '?'}))
noremap <silent><expr> zg? incsearch#go(<SID>config_fuzzyall({'is_stay': 1}))

" Auto completion
filetype plugin on
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Hack to fix arrow keys in insert-mode due to above mappings
imap <ESC>oA <ESC>ki
imap <ESC>oB <ESC>ji
imap <ESC>oC <ESC>li
imap <ESC>oD <ESC>hi

let g:gitgutter_enabled = 1
let g:NERDTreeWinPos = "left"

" vim-go
let g:go_gocode_unimported_packages = 1
let g:go_version_warning = 0
"let g:go_metalinter_enabled = 0
"let g:go_metalinter_autosave = 0
"let g:go_fmt_fail_silently = 1
au FileType go nmap <leader>r <Plug>(go-run)

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0
hi SpellBad term=reverse ctermbg=darkgreen

noremap $1 ()<esc>i
noremap $2 []<esc>i
noremap $3 {}<esc>i
noremap $4 {<esc>o}<esc>O
noremap $q ''<esc>i
noremap $e ""<esc>i

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

function! s:config_fuzzyall(...) abort
  return extend(copy({
  \   'converters': [
  \     incsearch#config#fuzzy#converter(),
  \     incsearch#config#fuzzyspell#converter()
  \   ],
  \ }), get(a:, 1, {}))
endfunction
