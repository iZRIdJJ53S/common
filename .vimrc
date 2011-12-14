" -------------------
" 色の設定
" -------------------
"syntax on

"colorscheme hhdgray

" 行番号
"highlight LineNr ctermfg=darkyellow
"highlight NonText ctermfg=darkgrey
"highlight Folded ctermfg=blue
" タブの視覚化
highlight SpecialKey cterm=underline ctermfg=darkgrey
" 特殊記号
"highlight SpecialKey ctermfg=grey

" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/

" タブ幅
set ts=4 sw=4
set softtabstop=4
"set expandtab

" -------------------
" 検索
" -------------------
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する(noignorecase)
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する(nosmartcase)
set smartcase
" 検索文字のハイライトをしない
"set nohlsearch
" インクリメンタルサーチ
"set incsearch

"if v:version < 700
"   set migemo
"endif

" -------------------
" その他
" -------------------
"set notitle
"set autowrite
" スクロール時の余白確保
set scrolloff=5


set history=50
"非表示文字（改行文字等）の表示
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:\ \ ,extends:<,trail:\
"set listchars=tab:>\ ,extends:<,trail:-
set laststatus=2
"set directory=/tmp
set wildmode=full:list

" 括弧対応の拡張機能
source $VIMRUNTIME/macros/matchit.vim

