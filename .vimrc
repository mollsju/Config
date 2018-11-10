set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin on			  " enable filetype plugin
filetype plugin indent on

"###############################
"### Pathogen plugin handler ###
"###############################
execute pathogen#infect()


"#######################
"### Typing defaults ###
"#######################
set transparency=4
set shiftwidth=4
set tabstop=4
set visualbell
set autochdir
syntax enable
set background=dark
colorscheme carbonized-dark 
set t_Co=16
set nu
set noai "No autoindent
set runtimepath+=~/Documents
set guioptions-=T  "Remove Toolbar
set guioptions-=r  "Remove Right-hand scroll bar
set wildmenu
set gfn=Menlo:h14		"Set font
set showmatch     		"set show matching parenthesis
set ignorecase    		"ignore case when searching
set smartcase     		"ignore case if search pattern is all lowercase,
                  		"	case-sensitive otherwise
set hlsearch      		"highlight search terms
set incsearch     		"show search matches as you type
set history=1000       "remember more commands and search history
set undolevels=1000    "use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class,*.meta
set nobackup
set noswapfile
set fileencoding=utf-8
set relativenumber 		" Use relative number for linenumbers
let g:netrw_liststyle=3 " Set style of directory tree
autocmd FileType python set omnifunc=pythoncomplete#Complete
"set foldmethod=syntax 	" Use syntax for folding


"##############################
"### Shortcuts and mappings ###
"##############################
" Align equals in selected range
vnoremap <F4> :call AlignEqualsRange()<CR>
"Run with python
noremap <F5> :w<CR>:!python %<CR>
"Git commit with message on F6
noremap <F6> :w<CR>:!git commit -a -m "
"Compile sass with compass
noremap <F7> :w<CR>:!compass compile ../<CR>
" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Go to next/prev error in syntastic error-list
nnoremap <leader>en :lnext<cr>
nnoremap <leader>ep :lprevious<cr>
" Show syntastic error-list with el (error list) or se (show errors)
"unmap <leader>e
"unmap <leader>s
nnoremap <leader>el :lopen<cr>
nnoremap <leader>se :lopen<cr>
nnoremap <leader>ec :lclose<cr>
noremap <leader>sf _i[SerializeField] <ESC>$<ESC>
noremap <leader>dl oDebug.Log();<ESC>hha
noremap <leader>sum ko/// <summary><cr><cr></summary><ESC>k$a<space>
" C# Public Getter: generate getter from private field
noremap <leader>pg $hvbyopublic x <esc>pa => this.<esc>pa;<esc>k_wveyj_wvpwxvU
" C# Public Serialized Field: public getter from private field with serialized attribute on same row.
noremap <leader>psf $hvbyopublic x <esc>pa => this.<esc>pa;<esc>k_fpwveyj_wvpwxvU







"################
"### Commands ###
"################
command! Vimrc execute "tabnew ~/.vimrc"


"#################
"### Omnisharp ###
"#################
"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5
" Look for global.json instead of .sln file
"let g:OmniSharp_prefer_global_sln = 1 
"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
set splitbelow
"let g:OmniSharp_server_type = 'v1'
let g:OmniSharp_server_type = 'roslyn'
let g:Omnisharp_stop_server = 0
let g:Omnisharp_start_server = 0
let g:omnicomplete_fetch_documentation=1
let g:Omnisharp_highlight_user_types = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch
augroup omnisharp_commands
    autocmd!
    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    "autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
	
	inoremap <C-space> <C-x><C-o>
	"automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
	"show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
	autocmd FileType cs nnoremap gd :w<cr>:OmniSharpGotoDefinition<cr>
	autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
	autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
	" Auto add .cs files to nearest project on save
	autocmd BufWritePost *.cs call OmniSharp#AddToProject()
augroup END
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
au BufReadPost,BufNewFile *.cs OmniSharpHighlightTypes
" Add syntax highlighting for types and interfaces
nnoremap <leader>ch :OmniSharpHighlightTypes<cr>
" Contextual code actions (with ctrl.p)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code action with visual selection (extract method)
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>
" Force relad solution
nnoremap <leader>rl :OmniSharpReloadSolution<cr>


"#################
"### Syntastic ###
"#################
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0"
let g:syntastic_cs_checkers = ['code_checker'] " Use roslyn codechecker


"#####################
"### YouCompleteMe ###
"#####################
let g:ycm_filetype_whitelist = { 'cpp': 1, 'c': 1, 'python':1, 'csharp':1 }


"################
"### Supertab ###
"################
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1

"####################
"### AUTO PAIR    ###
"####################
let g:AutoPairsMultilineClose = 0 	" Don't close pairs across lines
let g:AutoPairsCenterLine = 0		" Don't center on line when editing close to end of document



"####################
"### ALIGN EQUALS ###
"####################

function! AlignEqualsRange() range
    let lineStart   = line("'<")
    let lineEnd     = line("'>")
    let equalsCol   = 0

    for i in range(lineStart, lineEnd)
        let col = stridx(getline(i), "=")
        if col > equalsCol
            let equalsCol = col
        endif
    endfor

    if &tabstop > 0
        let equalsCol += (&tabstop - (equalsCol % &tabstop)) % &tabstop
    endif

    for i in range(lineStart, lineEnd)
        let lineString      = getline(i)
        let col             = stridx(lineString, "=")
        let spaces          = equalsCol - col
        let lineStringEnd   = strpart(lineString, col)
        let lineString      = strpart(lineString, 0, col)
        let j               = 0
        while j < spaces
            let lineString .= " "
            let j += 1
        endwhile
        let lineString .= lineStringEnd
        call setline(i, lineString)
    endfor
endfunction


"##############
"### RELOAD ###
"##############
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd VimEnter,BufReadPost * set foldtext=CustomFoldText()
    "autocmd VimEnter *.php normal zR
augroup END " }


"#############
"### Other ###
"#############
set exrc  "Project specific .vimrc allow, and safe mode.
set secure
