set nu
set expandtab
set tabstop=4
set softtabstop=4
set history=1000
set autoindent
set relativenumber
set noswapfile

"плагины
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
call plug#end()

let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable = 1

" Отмена
nnoremap <C-z> u
inoremap <C-z> <C-o>u
vnoremap <C-z> u

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

" Русские буквы
noremap ш i
noremap Ш I
noremap ф a
noremap Ф A
noremap й q
noremap Й Q
noremap ц w
noremap Ц W
noremap р h 
noremap Р H
noremap о j
noremap О J
noremap л k
noremap Л K
noremap д l
noremap Д L
noremap з p 
noremap З P
noremap я z 
noremap Я Z
noremap с c
noremap С C
noremap м v
noremap М V
noremap ы s
noremap Ы S
noremap Ж :
noremap н y
noremap Н Y
noremap р h
noremap Р H

" Русские буквы для команд
cnoremap й q
cnoremap ц w
cnoremap йц wq
cnoremap цй wq

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
