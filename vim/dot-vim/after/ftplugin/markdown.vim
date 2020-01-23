echomsg "SUCCESS!"

" Compile the markdown file to a word doc
autocmd FileType markdown nnoremap <buffer><silent><localleader>b :!pandoc % -o ~/Documents/Docs/_Inbox/%:r.docx<CR>

