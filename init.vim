"===================================================================================================
" エンコーディング(encoding)
"===================================================================================================
"バッファ内で扱う文字コード(文字列)
set encoding=utf-8
"Vim Script内でマルチバイト文字を使うのに必要(nvimでは未検証)
scriptencoding utf-8
"書き込む文字コード(文字列) : この場合encodingと同じなので省略可
set fileencoding=utf-8
"読み込む文字コード(文字列のリスト) : この場合UTF-8を試し、だめならShift_JIS
set fileencodings=utf-8,cp932

"===================================================================================================
" 基本設定(basic)
"===================================================================================================
" このスクリプトで定義するautocmdのaugroup
augroup MyAutoCmd
    autocmd!
augroup END

"カレントディレクトリを自動で移動
set autochdir

" ファイルタイプの検出&ファイルタイプ別プラグイン&ファイルタイプ別インデントのON neovimではデフォルトで全てONになっている
filetype plugin indent on

" vimdoc-ja を入れつつ helplang=en,ja にしておけば、つらくなったときに :h hoge@ja とすると日本語 help が開けて便利
set helplang=ja,en

"===================================================================================================
" 表示設定(display)
"===================================================================================================
"行番号表示
set number
"コマンドラインの高さ
set cmdheight=2
set laststatus=2
"コマンドをステータス行に表示
set showcmd
"画面最後の行をできる限り表示する
set display=lastline


" スペース派です。自分で書くファイルはタブ文字を使わない。タブ文字を含むファイルも問題なく編集できるように設定する。
" インデントにタブ文字を強制する系のファイルは<C-V> <Tab>で直接タブ文字を入力するか、retabコマンドでスペースインデントをタブインデントに変換する。
"タブを設定項目は5つあり、いつも混乱する
"タブ文字の代わりにスペースを使う(インデントはスペース派にとって最重要の項目)
set expandtab
"タブ文字の表示幅
set tabstop=4
"Tabキーで挿入するスペースの数。インデントを削除するときも作用する
set softtabstop=4
"各コマンドやsmartindentで挿入する空白の量(数値)
set shiftwidth=4
"各コマンドやsmartindentで挿入する空白の量(数値)
set smarttab

" 改行時にインデントを自動挿入
set autoindent
"プログラミング言語に合わせて適切にインデントを自動挿入
set smartindent

"カーソルの上または下には、最低でもこのオプションに指定した数の行が表示される
set scrolloff=8

"不可視文字を表示する
set list
"タブ文字を>--- 行末のスペースを~ で表示する。
set listchars=tab:>-,trail:~

" 全角スペースを表示(念の為) (https://zenn.dev/kawarimidoll/articles/450a1c7754bde6)
" u2000 ' ' en quad
" u2001 ' ' em quad
" u2002 ' ' en space
" u2003 ' ' em space
" u2004 ' ' three-per em space
" u2005 ' ' four-per em space
" u2006 ' ' six-per em space
" u2007 ' ' figure space
" u2008 ' ' punctuation space
" u2009 ' ' thin space
" u200A ' ' hair space
" u200B '​' zero-width space
" u3000 '　' ideographic (zenkaku) space
augroup MyAutoCmd
    highlight default ExtraWhitespace ctermbg=darkmagenta guibg=darkmagenta
    autocmd VimEnter,WinEnter,BufRead,ColorScheme * call matchadd('ExtraWhitespace', "[\u2000-\u200B\u3000]")
augroup END

"===================================================================================================
" 検索(search)
"===================================================================================================
"検索の時に大文字小文字を区別しない。ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase
"検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
"インクリメンタルサーチ
set incsearch
"検索文字の強調表示
set hlsearch
"w,bの移動で認識する文字
"set iskeyword=a-z,A-Z,48-57,_,.,-,>
"部分一致検索 anで単語検索するとanotherにもマッチする
nnoremap * g*N

"===================================================================================================
" 編集・移動(edit, move, cursor)
"===================================================================================================
"Vimの無名レジスタとシステムのクリップボードを連携(文字列のリスト) : ダメならxclipをインストールで使えるかも
set clipboard+=unnamed,unnamedplus
"eコマンド等でTabキーを押すとパスを補完する(文字列のリスト) : この場合まず最長一致文字列まで補完し、2回目以降は一つづつ試す
set wildmode=longest,full
"カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,h,l,[,],<,>
"8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
"Visual blockモードでフリーカーソルを有効にする
set virtualedit=block
"日本語の行の連結時 には空白を入力しない
set formatoptions+=mM
" マウスとスクロールの有効化
set mouse=a

"ファイルを開いたら前回のカーソル位置へ移動
augroup MyAutoCmd
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe "normal! g`\""
                \ | endif
augroup END

"行末の空白を削除
function! s:remove_dust()
    let cursor = getpos(".")
    %s/\s\+$//ge
    call setpos(".", cursor)
    unlet cursor
endfunction
augroup MyAutoCmd
    autocmd BufWritePre * call <SID>remove_dust()
augroup END

"===================================================================================================
" キーマッピング(mapping)
"===================================================================================================
"あらゆるマッピングに<silent>つける意味ある？基本はつけない方が操作がわかりや
"すくていい
"現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>
"強制全保存終了を無効化
nnoremap ZZ <Nop>
" 選択した文字列を*で検索
vnoremap * "zy:let @/ = @z<CR>
" jjで挿入モードを抜ける
inoremap jj <ESC>
"変更があれば保存
nnoremap <C-S> :update<CR>
nnoremap <D-S> :update<CR>
inoremap <C-S> <Esc>:update<CR>a
inoremap <D-S> <Esc>:update<CR>a
"カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>で行う。キーボードマクロには物理行移動を推奨
nnoremap j gj
nnoremap k gk
"コマンドモードの補完選択をカーソルキーで行えるように
cnoremap <Down> <C-N>
cnoremap <Up>   <C-P>
" ctrl-spaceで補完を表示
inoremap <C-Space> <C-N>
inoremap <C-N> <Down>
inoremap <C-P> <Up>
nnoremap <C-N> :bn<CR>
nnoremap <C-p> :bp<CR>


" Leaderキーをスペースキーに(デフォルトでは\だが、スペースが多数派)
let mapleader = "\<space>"
" init.vimを編集
nnoremap <Leader>v :e $MYVIMRC<CR>
" カレントウィンドウを閉じる
nnoremap <Leader>q :q<CR>
" 上書き保存
nnoremap <Leader>w :update<CR>
" バッファの移動
nnoremap <Tab>  :bn<CR>
" バッファの削除(vim-sayonaraプラグイン)
nnoremap <Leader>d :Sayonara!<CR>
" 一括インデント
nnoremap <Leader>i migg=G`i

" fzf.vim
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>g :GFiles?<CR>
"nnoremap <Leader>G :GFiles<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :History<CR>
nnoremap <Leader>p :Commands<CR>
nnoremap <Leader>/ :Rg<CR>
nnoremap <Leader>: :History:<CR>
" 次のキーでファイルの開き方を選べる
"   <Enter> is open in the current window,
"   CTRL-T  is open in new tabs
"   CTRL-X  is open in horizontal splits
"   CTRL-V  is open in vertical splits r

" caw.vim
" Ctrl-/でコメントアウトのトグル
nnoremap <C-_> <Plug>(caw:hatpos:toggle)
vnoremap <C-_> <Plug>(caw:hatpos:toggle)

" Quickrun実行
nnoremap <Leader>r :QuickRun >message<CR>
" Quickrun引数を渡して実行
nnoremap <Leader>a :QuickRun >message -args ""<Left>

"===================================================================================================
" その他設定
"===================================================================================================

"===================================================================================================
" 一時的な設定
"===================================================================================================
":ScouterでVim戦闘力測定
function! Scouter(file, ...)
    let pat = '^\s*$\|^\s*"'
    let lines = readfile(a:file)
    if !a:0 || !a:1
        let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
    endif
    return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter echo Scouter(empty(<q-args>) ? $MYVIMRC  : expand(<q-args>), <bang>0)

augroup MyAutoCmd
    " Makefile を編集するときは、タブキーをタブ文字の入力に使用する
    autocmd FileType make  setlocal noexpandtab
augroup END




"===================================================================================================
" プラグイン設定
"===================================================================================================
" プラグイン管理はdeinで行う。dein.tomlとdein_lazy.tomlでプラグインの設定
" たまにcall dein#update()でプラグインのアップデートをしろ

" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
" プラグインがインストールされるディレクトリ
let s:dein_dir = s:cache_home . '/dein'
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" プラグイン読み込み＆キャッシュ作成
" プラグインリストを収めたTOMLファイルを予め用意しておく
let s:toml = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:lazy_toml = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
    call dein#install()
endif

"===================================================================================================
" テーマ設定(color)
"===================================================================================================
" 背景色を透過に
augroup MyAutoCmd
    autocmd Colorscheme * highlight Normal ctermbg=none
                \ | highlight NonText ctermbg=none
                \ | highlight LineNr ctermbg=234
                \ | highlight Folded ctermbg=none
                \ | highlight EndOfBuffer ctermbg=none
                \ | highlight Pmenu ctermbg=none
                \ | highlight NormalFloat ctermbg=none
augroup END
" カラーテーマの設定
set background=dark
colorscheme hybrid
let g:airline_theme='hybridline'

"===================================================================================================
" やりたいこと
"===================================================================================================
"fzfのバッファとMRUとカレントディレクトリをこの順に一緒くたにしたコマンド欲しい

"===================================================================================================
" vimメモ
"===================================================================================================
"helpの活用
"https://qiita.com/shinshin86/items/eb41e4fb513bb4d3e3cd
"
"neovim使いこなしメモ
" vimとneovimの差についてはヘルプの*vim_diff*を参照しろ。
" [init.vimに関係ありそうな簡易まとめ]
" 設定ファイルの場所が違う
"   Use `$XDG_CONFIG_HOME/nvim/init.vim` instead of `.vimrc` for your |config|.
"   Use `$XDG_CONFIG_HOME/nvim` instead of `.vim` to store configuration files.
"   Use `$XDG_DATA_HOME/nvim/shada/main.shada` instead of `.viminfo` for persistent
"   session information.  |shada|
" ファイルタイプ検出とシンタックスハイライトがデフォルトでオン
" 他にもautoindentやencodingなど複数のオプションがデフォルトで有効になっている
" man.vim plugin, matchit pluginが有効。
" 以下のマッピングがデフォルトで有効
"   " Yの挙動をDやCと同じにする
"   nnoremap Y y$
"   " 画面更新(C-L)で検索ハイライトをオフにする
"   nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>
"   " 行削除毎にUndo可能に
"   inoremap <C-U> <C-G>u<C-U>
"   " 単語削除毎にUndo可能に
"   inoremap <C-W> <C-G>u<C-W>
