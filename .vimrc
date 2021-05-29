"! define the prefix <Leader> as ;
let mapleader=";"

call plug#begin('~/.vim/plugged')

"Plugin 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'
Plug 'OmniSharp/omnisharp-vim'
Plug 'fholgado/minibufexpl.vim'
Plug 'vim-scripts/Tagbar'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'szw/vim-tags'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'chriskempson/base16-vim'
Plug 'derekwyatt/vim-scala'
Plug 'cazador481/vim-systemverilog'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'
Plug 'HerringtonDarkholme/yats.vim'
call plug#end()

set encoding=utf8

""" gruvbox color scheme
"set termguicolors
set background=dark
syntax enable
colorscheme gruvbox

"""
""" coc: for autocompletion and imports and type definition
"""     (all copied from README)
"""

" coc extensions
let g:coc_global_extensions = [
  \ 'coc-highlight',
  \ 'coc-snippets',
  \ 'coc-clangd',
  \ 'coc-cmake',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-sh',
  \ 'coc-tsserver',
  \ 'coc-pairs',
  \ 'coc-diagnostic'
  \ ]
" coc.nvim uses jsonc as configuration file format.
" This command support the jsonc highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" TextEdit might fail if hidden is not set
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Give more space for displaying messages
set cmdheight=2

" Having longer update time (default is 400ms) will lead to 
" noticeable delays and poor user experience
set updatetime=300

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
if has("patch-8.1.1564")
  "Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Use <C-Space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use '[g' and ']g' to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Jump to code navigations
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gt <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

" Jump to errors
nmap <silent> <Leader>en <Plug>(coc-diagnostic-next-error)
nmap <silent> <Leader>ep <Plug>(coc-diagnostic-prev-error)

"" Highlight the symbol and its references when holding the cursor
"autocmd CursorHold * silent call CocActionAsync('Highlight')

" Symbol renaming
nmap <Leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <Leader>f <Plug>(coc-format-selected)
nmap <Leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

"""
""" cocvim ends
"""


" detect file type and apply different plugins for each file type
filetype on
filetype plugin on

" make backspace normal
set backspace=2

" redefine shortcuts for goto line_begin(0) & line_end($)
nmap <Leader>[ 0
nmap <Leader>] $

" copy and paste between vim and outside word
vnoremap <Leader>y "+y
nmap <Leader>p "+p

" exist from current window
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>WQ :wq<CR>:q<CR>
nmap <Leader>Q :qa!<CR>

nnoremap nw <C-W><C-W>
" jump to right window
nnoremap <Leader>lw <C-W>l
" jump to left window
nnoremap <Leader>hw <C-W>h
" jump to upper window
nnoremap <Leader>kw <C-W>k
" jump to below window
nnoremap <Leader>jw <C-W>j
" jump between pairs
nmap <Leader>pa %

set incsearch       " set real-time search function
set ignorecase      " capitial-insensitive when searching
set nocompatible    " close compatible mode
set wildmenu        " commmand line auto-complete


" disable cursor blinking, scrolls, menu and toolbar
set gcr=a:block-blinkon0
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T

" F11 to maximize window
fun! ToggleFullscreen()
    call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
map <silent> <F11> :call ToggleFullscreen()<CR>
autocmd VimEnter * call ToggleFullscreen()

set laststatus=2    " display status bar
set ruler           " display cursor
set number          " display line number
set cursorline      " display current line
set cursorcolumn    " display current column
set hlsearch        " display search result

set guifont=Hack\ Nerd\ Font\ 11   " set gvim font

set nowrap          	" no wrap line
set foldmethod=syntax   " fold bases on sytax
set nofoldenable        " close fold as default

" highlight syntax
syntax enable
syntax on

filetype indent on  " apply different indentation for different filetypes
set expandtab       " make tabs as spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4

" ====== Indent Guide Plugin Setup ======
" <Leader>i    toggle indent guide
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" ====== NERDTree Plugin Setup ======
" <Leader>fl    toggle NERDTree
nmap <Leader>fl :NERDTreeToggle<CR>
let NERDTreeWinSize=32
let NERDTreeWinPos="right"
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

" ====== MiniBufExplorer Plugin Setup ======
" <Leader>bl    toggle MiniBufExplorer
map <Leader>bl :MBEToggle<cr>
map <Leader>2 :MBEbn<cr>
map <Leader>1 :MBEbp<cr>

set t_ut=

"" ====== Tagbar Plugin Setup ======
"" <Leader>tl    toggle TagbarToggle
"let tagbar_left=1
"nnoremap <Leader>tl :TagbarToggle<CR>
"let tagbar_width=32
"let g:tagbar_compact=1
"let g:tagbar_type_cpp = {
"    \ 'kinds' : [
"        \ 'd:macros:1',
"        \ 'g:enums',
"        \ 't:typedefs:0:0',
"        \ 'e:enumerators:0:0',
"        \ 'n:namespaces',
"        \ 'c:classes',
"        \ 's:structs',
"        \ 'u:unions',
"        \ 'f:functions',
"        \ 'm:members:0:0',
"        \ 'v:global:0:0',
"        \ 'x:external:0:0',
"        \ 'l:local:0:0'
"     \ ],
"     \ 'sro'        : '::',
"     \ 'kind2scope' : {
"         \ 'g' : 'enum',
"         \ 'n' : 'namespace',
"         \ 'c' : 'class',
"         \ 's' : 'struct',
"         \ 'u' : 'union'
"     \ },
"     \ 'scope2kind' : {
"         \ 'enum'      : 'g',
"         \ 'namespace' : 'n',
"         \ 'class'     : 'c',
"         \ 'struct'    : 's',
"         \ 'union'     : 'u'
"     \ }
"\ }


" ====== Multiple Cursor Setup (naive) ======
" ctrl-n highlight current word & place cursor & find next occurence
" ctrl-p return to last cursor
" ctrl-x go to next cursor & discard current cursor
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual


"" ====== YouCompleteMe Plugin Setup ======
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
"highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
"let g:ycm_complete_in_comments=1
"let g:ycm_confirm_extra_conf=0
"let g:ycm_collect_identifiers_from_tags_files=1
"set tags+=/data/misc/software/misc./vim/stdcpp.tags
"inoremap <leader>; <C-x><C-o>
"set completeopt-=preview
"let g:ycm_min_num_of_chars_for_completion=1
"let g:ycm_cache_omnifunc=0
"let g:ycm_seed_identifiers_with_syntax=1
"
"
"" *.cpp 和 *.h 间切换
"nmap <Leader>ch :A<CR>
"" 子窗口中显示 *.cpp 或 *.h
"nmap <Leader>sch :AS<CR>
"
"nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
"" 只能是 #include 或已打开的文件
"nnoremap <leader>je :YcmCompleter GoToDefinition<CR>
"
"
"" 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
"nnoremap <Leader>sp :CtrlSF<CR>
"
"" 替换函数。参数说明：
"" confirm：是否替换前逐一确认
"" wholeword：是否整词匹配
"" replace：被替换字符串
"function! Replace(confirm, wholeword, replace)
"    wa
"    let flag = ''
"    if a:confirm
"        let flag .= 'gec'
"    else
"        let flag .= 'ge'
"    endif
"    let search = ''
"    if a:wholeword
"        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
"    else
"        let search .= expand('<cword>')
"    endif
"    let replace = escape(a:replace, '/\&~')
"    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
"endfunction
"" 不确认、非整词
"nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
"" 不确认、整词
"nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
"" 确认、非整词
"nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
"" 确认、整词
"nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
"nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
"
"let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
"
"
"" 设置 pullproto.pl 脚本路径
"let g:protodefprotogetter='~/.vim/bundle/protodef/pullproto.pl'
"" 成员函数的实现顺序与声明顺序一致
"let g:disable_protodef_sorting=1
"
"
"set runtimepath^=~/.vim/bundle/ctrlp.vim
