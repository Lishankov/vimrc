set encoding=utf-8
set nu
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set history=1000
set autoindent
set relativenumber
set noswapfile

if !has('gui_running')
    silent !stty -ixon
    augroup restore_tty
        autocmd!
        autocmd VimLeave * silent !stty ixon
    augroup END
endif

"плагины
let s:plug_file = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_file))
    silent execute '!curl -fLo ' . shellescape(s:plug_file) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    augroup plug_autoinstall
        autocmd!
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    augroup END
endif

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
call plug#end()

let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable = 1

" Отмена
nnoremap <C-z> u
inoremap <C-z> <C-o>u
vnoremap <C-z> <Esc>u

" Сохранение
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>

" Выход и сохранение
nnoremap <C-q>w :wq<CR>
nnoremap <C-q>q :q!<CR>
nnoremap <C-q>s :w<CR>

" Выделить всё
nnoremap <C-a> ggVG

" Копирование в буфер обмена
vnoremap y "+y
nnoremap y "+y
nnoremap yy "+yy
nnoremap p "+p
vnoremap p "+p

" Изменение размера окон
nnoremap <C-Right> <C-w>>
nnoremap <C-Left> <C-w><

let &langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,ж\;,Ж:,х[,ъ],Х{,Ъ},э'',б\,,ю.,Б<,Ю>,ё`,Ё~'

cnoreabbrev <expr> й  getcmdtype() == ':' && getcmdline() ==# 'й'  ? 'q'  : 'й'
cnoreabbrev <expr> ц  getcmdtype() == ':' && getcmdline() ==# 'ц'  ? 'w'  : 'ц'
cnoreabbrev <expr> йц getcmdtype() == ':' && getcmdline() ==# 'йц' ? 'wq' : 'йц'
cnoreabbrev <expr> цй getcmdtype() == ':' && getcmdline() ==# 'цй' ? 'wq' : 'цй'

" Компиляция и запуск
autocmd FileType cpp nnoremap <buffer> <F4> :w<CR>:!g++ -g % -o %:r -std=c++23 && ./%:r<CR>
autocmd FileType python nnoremap <buffer> <F4> :w<CR>:!python3 %<CR>

" Переключение между NERDTree и файлом
nnoremap <F2> <C-w>w
nnoremap <F3> <C-w>w

"Открыть NERDTree
nnoremap <F5> :NERDTreeToggle<CR>

" Отладка через GDB
nnoremap <F6> :w<CR>:!g++ -g -std=c++23 % -o %:r && gdb -tui -ex "set debuginfod enabled off" -ex "start" -ex "set pagination off" %:r<CR>

" Шаблоны
let g:template_dir = '/home/lishankov/Документы/automize/templates/'

function! InsertTemplate(line_num, template_name)
    let template_file = g:template_dir . a:template_name . '.cpp'
    
    if !filereadable(template_file)
        echo "Файл " . a:template_name . ".cpp не найден!"
        return
    endif
    
    execute a:line_num . 'read ' . template_file
    echo "Вставлен " . a:template_name . ".cpp в строку " . a:line_num
endfunction

command! -nargs=1 Bincl call InsertTemplate(<f-args>, 'base_include')
command! -nargs=1 Bcpp call InsertTemplate(<f-args>, 'base_cpp')
command! -nargs=1 Binsearch call InsertTemplate(<f-args>, 'binsearch')
command! -nargs=1 Baincl call InsertTemplate(<f-args>, 'all_need_include')
