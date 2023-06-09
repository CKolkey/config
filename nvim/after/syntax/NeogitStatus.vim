syn match NeogitChangePath /\s.*$/ contained

syn match NeogitChangeModified /^Modified/ contained
syn region NeogitFileModified start=/^Modified/ end=/\s/ contains=NeogitChangeModified
" hi def link NeogitChangeModified Macro

syn match NeogitChangeAdded /^Added/ contained
syn region NeogitFileAdded start=/^Added/ end=/\s/ contains=NeogitChangeAdded
" hi def link NeogitChangeAdded String

syn match NeogitChangeDeleted /^Deleted/ contained
syn region NeogitFileDeleted start=/^Deleted/ end=/\s/ contains=NeogitChangeDeleted
" hi def link NeogitChangeDeleted Error

syn match NeogitChangeRenamed /^Renamed/ contained
syn region NeogitFileRenamed start=/^Renamed/ end=/\s/ contains=NeogitChangeRenamed
" hi def link NeogitChangeRenamed Label

syn match NeogitChangeUpdated /^Updated/ contained
syn region NeogitFileUpdated start=/^Updated/ end=/\s/ contains=NeogitChangeUpdated
" hi def link NeogitChangeUpdated Boolean

syn match NeogitChangeCopied /^Copied/ contained
syn region NeogitFileCopied start=/^Copied/ end=/\s/ contains=NeogitChangeCopied
" hi def link NeogitChangeCopied Operator

syn match NeogitChangeBothModified /^Both Modified/ contained
syn region NeogitFileBothModified start=/^Both/ end=/d\s/ contains=NeogitChangeBothModified
" hi def link NeogitChangeBothModified Constant

syn match NeogitChangeNewFile /^New file/ contained
syn region NeogitFileNewFile start=/^New/ end=/e\s/ contains=NeogitChangeNewFile
" hi def link NeogitChangeNewFile String
