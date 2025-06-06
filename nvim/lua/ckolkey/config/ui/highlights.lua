local c = require("ckolkey.config.ui.colors")

-- stylua: ignore
return {
  ["@number"]                       = { fg = c.red, bg = c.none },
  ["@float"]                        = { fg = c.yellow, bg = c.none },
  ["@label"]                        = { fg = c.red, bg = c.none, style = "italic,bold" },
  ["@variable"]                     = { fg = c.white, bg = c.none },
  ["@variable.builtin"]             = { fg = c.yellow, bg = c.none, style = "italic" },
  ["@variable.global"]              = { fg = c.cyan, bg = c.none, style = "bold" },
  ["@function.builtin"]             = { fg = c.purple, bg = c.none },
  ["@type"]                         = { fg = c.yellow, bg = c.none, style = "italic" },
  ["@variable.member"]              = { fg = c.red, bg = c.none, style = "bold" },
  ["@string.special.symbol"]        = { fg = c.red, bg = c.none, style = "bold" },
  ["@string.special.symbol.ruby"]   = { fg = c.red, bg = c.none, style = "bold" },
  ["@punctuation.bracket"]          = { fg = c.white, bg = c.none },
  ["@punctuation.delimiter"]        = { fg = c.white, bg = c.none },
  ["@markup.list"]                  = { fg = c.purple, bg = c.none },
  ["@operator"]                     = { fg = c.purple, bg = c.none },
  ["@underline"]                    = { fg = c.none, bg = c.none, style = "bold" },
  ["@string.regexp"]                = { fg = c.orange, bg = c.none },
  ["@boolean"]                      = { fg = c.orange, bg = c.none, style = "italic" },
  ["@tag"]                          = { fg = c.red, bg = c.none, style = "bold" },
  ["@markup"]                       = { fg = c.white, bg = c.none },
  ["@tag.attribute"]                = { fg = c.yellow, bg = c.none, style = "italic" },
  ["@lsp.type.class"]               = { style = c.none },
  ["@lsp.type.decorator"]           = { fg = c.blue, style = "bold" },
  ["@lsp.type.enum"]                = { style = c.none },
  ["@lsp.type.enumMember"]          = { fg = c.yellow, style = c.none },
  ["@lsp.type.function"]            = { style = c.none },
  ["@lsp.type.interface"]           = { style = c.none },
  ["@lsp.type.macro"]               = { fg = c.blue, style = c.none },
  ["@lsp.type.method"]              = { fg = c.blue, style = "bold" },
  ["@lsp.type.namespace"]           = { style = c.none },
  -- ["@lsp.type.parameter"]      = { fg = c.white, style = c.none },
  ["@lsp.type.property"]            = { fg = c.red, style = c.none },
  ["@lsp.type.struct"]              = { style = c.none },
  ["@lsp.type.type"]                = { fg = c.yellow, style = "italic" },
  ["@lsp.type.typeParameter"]       = { fg = c.purple, style = c.none },
  ["@lsp.type.variable"]            = { fg = c.white, style = c.none },
  ["@lsp.mod.default_library.ruby"] = { fg = c.yellow, bg = c.none, style = "italic" },
  BiscuitColor                      = { fg = c.grey_dim, style = "italic" },
  WinSeparator                      = { bg = c.bg0, fg = c.bg0 },
  VisualYank                        = { bg = c.bg4 },
  FloatBorder                       = { bg = c.bg1, fg = c.purple },
  CursorLineNr                      = { fg = c.yellow, bg = c.bg0, style = c.none },
  CursorLineNrNC                    = { fg = c.fg, bg = c.bg0, style = c.none },
  LineNr                            = { fg = c.grey_dim, bg = c.bg0 },
  LineNrNC                          = { fg = c.grey_dim, bg = c.bg0 },
  CursorLine                        = { bg = c.cursor_line, style = "nocombine" },
  CursorLineNC                      = { bg = c.bg0 },
  CursorLineSign                    = { bg = c.bg0 },
  QuickFixLineNC                    = { bg = c.line_red },
  QuickFixLine                      = { bg = c.line_red },
  DapStoppedLine                    = { bg = c.line_red },
  IncSearch                         = { fg = c.bg1, bg = c.green },
  Type                              = { fg = c.red, bg = c.none, style = "italic" },
  Structure                         = { fg = c.red, bg = c.none, style = "italic" },
  StorageClass                      = { fg = c.red, bg = c.none, style = "italic" },
  Identifier                        = { fg = c.orange, bg = c.none, style = "italic" },
  Constant                          = { fg = c.orange, bg = c.none, style = "italic" },
  CursorColumn                      = { fg = c.none, bg = c.bg2, style = c.none },
  CurrentWord                       = { fg = c.none, bg = c.none, style = c.none },
  ErrorMsg                          = { fg = c.red, bg = c.none, style = "bold" },
  Comment                           = { fg = c.grey_dim, bg = c.none, style = "italic" },
  SpecialComment                    = { fg = c.grey_dim, bg = c.none, style = "italic" },
  Todo                              = { fg = c.purple, bg = c.none, style = "italic" },
  FoldColumn                        = { fg = c.grey_light, bg = c.bg0, style = "bold" },
  SignColumn                        = { bg = c.bg0 },
  SignColumnNC                      = { bg = c.bg0 },
  Folded                            = { bg = c.bg2 },
  StatusColumnBorder                = { fg = c.line_blue, bg = c.bg0 },
  StatusColumnBuffer                = { fg = c.none, bg = c.none },
  StatusColumnBufferCursorLine      = { fg = c.none, bg = c.cursor_line },
  IndentBlanklineEven               = { fg = c.grey_dim, bg = c.none, style = "nocombine" },
  IndentBlanklineOdd                = { fg = c.grey_dim, bg = c.none, style = "nocombine" },
  IndentBlanklineContext            = { fg = c.orange, bg = c.none, style = "nocombine" },
  GitSignsAdd                       = { fg = c.bg_green, bg = c.bg0 },
  GitSignsChange                    = { fg = c.blue, bg = c.bg0 },
  GitSignsDelete                    = { fg = c.red, bg = c.bg0 },
  GitSignsUntracked                 = { fg = c.purple, bg = c.bg0 },
  GitSignsAddAdd                    = { fg = c.bg_green, bg = c.bg0 },
  ErrorText                         = { fg = c.red, bg = c.none, style = "bold", sp = c.red },
  WarningText                       = { fg = c.yellow, bg = c.none, style = "bold", sp = c.yellow },
  InfoText                          = { fg = c.blue, bg = c.none, style = "bold", sp = c.blue },
  HintText                          = { fg = c.green, bg = c.none, style = "bold", sp = c.green },
  MatchParen                        = { fg = c.orange, bg = c.grey_dim, style = "bold" },
  MatchParenCur                     = { fg = c.orange, bg = c.grey_dim, style = "bold" },
  MatchWord                         = { fg = c.orange, bg = c.none, style = "italic" },
  MatchWordCur                      = { fg = c.orange, bg = c.none, style = "italic" },
  ActiveWindow                      = { fg = c.none, bg = c.none },
  InactiveWindow                    = { fg = c.none, bg = c.bg0 },
  NormalFloat                       = { bg = c.bg1 },
  DiagnosticError                   = { fg = c.red, bg = c.bg1, style = "bold" },
  DiagnosticWarn                    = { fg = c.orange, bg = c.bg1, style = "bold" },
  DiagnosticInfo                    = { fg = c.blue, bg = c.bg1, style = "bold" },
  DiagnosticHint                    = { fg = c.green, bg = c.bg1, style = "bold" },
  DiagnosticUnderlineError          = { fg = c.red, style = "undercurl" },
  DiagnosticUnderlineWarn           = { fg = c.orange, style = "undercurl" },
  DiagnosticUnderlineInfo           = { fg = c.blue, style = "undercurl" },
  DiagnosticUnderlineHint           = { fg = c.green, style = "undercurl" },
  DiagnosticLineError               = { bg = c.error_bg },
  DiagnosticLineWarn                = { bg = c.warn_bg },
  DiagnosticLineInfo                = { bg = c.info_bg },
  DiagnosticLineHint                = { bg = c.hint_bg },
  PmenuSel                          = { bg = c.bg1, fg = c.none },
  Pmenu                             = { fg = c.fg, bg = c.bg0 },
  CmpItemAbbrDeprecated             = { fg = c.grey, bg = c.none, style = "strikethrough" },
  CmpItemAbbrMatch                  = { fg = c.blue, bg = c.none, style = "bold" },
  CmpItemAbbrMatchFuzzy             = { fg = c.blue, bg = c.none, style = "bold" },
  CmpItemMenu                       = { fg = c.purple, bg = c.none, style = "italic" },
  CmpItemKindField                  = { fg = c.lt_red, bg = c.bg_red },
  CmpItemKindProperty               = { fg = c.lt_red, bg = c.bg_red },
  CmpItemKindEvent                  = { fg = c.lt_red, bg = c.bg_red },
  CmpItemKindNone                   = { fg = c.lt_red, bg = c.bg_red },
  CmpItemKindText                   = { fg = c.lt_green, bg = c.bg_green },
  CmpItemKindEnum                   = { fg = c.lt_green, bg = c.bg_green },
  CmpItemKindKeyword                = { fg = c.lt_green, bg = c.bg_green },
  CmpItemKindKeywordOperator        = { fg = c.lt_green, bg = c.bg_green },
  CmpItemKindKeywordConditional     = { fg = c.lt_green, bg = c.bg_green },
  CmpItemKindConstant               = { fg = c.lt_yellow, bg = c.bg_yellow },
  CmpItemKindConstructor            = { fg = c.lt_yellow, bg = c.bg_yellow },
  CmpItemKindReference              = { fg = c.lt_yellow, bg = c.bg_yellow },
  CmpItemKindCopilot                = { fg = c.lt_yellow, bg = c.bg_yellow },
  CmpItemKindFunction               = { fg = c.lt_purple, bg = c.bg_purple },
  CmpItemKindStruct                 = { fg = c.lt_purple, bg = c.bg_purple },
  CmpItemKindClass                  = { fg = c.lt_purple, bg = c.bg_purple },
  CmpItemKindModule                 = { fg = c.lt_purple, bg = c.bg_purple },
  CmpItemKindOperator               = { fg = c.lt_purple, bg = c.bg_purple },
  CmpItemKindVariable               = { fg = c.fg, bg = c.grey },
  CmpItemKindVariableMember         = { fg = c.fg, bg = c.grey },
  CmpItemKindFile                   = { fg = c.fg, bg = c.grey },
  CmpItemKindNospell                = { fg = c.fg, bg = c.grey },
  CmpItemKindUnit                   = { fg = c.lt_orange, bg = c.bg_orange },
  CmpItemKindSnippet                = { fg = c.lt_orange, bg = c.bg_orange },
  CmpItemKindFolder                 = { fg = c.lt_orange, bg = c.bg_orange },
  CmpItemKindMethod                 = { fg = c.lt_blue, bg = c.bg_blue },
  CmpItemKindValue                  = { fg = c.lt_blue, bg = c.bg_blue },
  CmpItemKindEnumMember             = { fg = c.lt_blue, bg = c.bg_blue },
  CmpItemKindInterface              = { fg = c.lt_cyan, bg = c.bg_cyan },
  CmpItemKindColor                  = { fg = c.lt_cyan, bg = c.bg_cyan },
  CmpItemKindTypeParameter          = { fg = c.lt_cyan, bg = c.bg_cyan },
  TelescopeSelection                = { bg = c.bg4, fg = c.active },
  TelescopeSelectionCaret           = { bg = c.bg4, fg = c.active },
  TelescopeMultiSelection           = { fg = c.orange },
  TelescopeNormal                   = { fg = c.fg, bg = c.bg1 },
  TelescopeResultsBorder            = { bg = c.bg1 },
  TelescopePreviewBorder            = { fg = c.bg0, bg = c.bg1 },
  TelescopePromptCounter            = { fg = c.grey_dim, bg = c.line_purple, style = "italic" },
  TelescopePromptNormal             = { bg = c.bg4 },
  TelescopePromptBorder             = { bg = c.bg4 },
  TelescopePromptTitle              = { fg = c.active, bg = c.bg4 },
  TelescopeResultsTitle             = { fg = c.bg1, bg = c.bg1 },
  TelescopePreviewTitle             = { fg = c.bg1, bg = c.bg1 },
  TelescopeMatching                 = { fg = c.orange },
  NotifyERRORBorder                 = { fg = c.bg_red },
  NotifyERRORIcon                   = { fg = c.red },
  NotifyERRORTitle                  = { fg = c.red },
  NotifyWARNBorder                  = { fg = c.bg_orange },
  NotifyWARNIcon                    = { fg = c.orange },
  NotifyWARNTitle                   = { fg = c.orange },
  NotifyINFOBorder                  = { fg = c.bg_blue },
  NotifyINFOIcon                    = { fg = c.blue },
  NotifyINFOTitle                   = { fg = c.blue },
  NotifyDEBUGBorder                 = { fg = c.bg_purple },
  NotifyDEBUGIcon                   = { fg = c.purple },
  NotifyDEBUGTitle                  = { fg = c.purple },
  NotifyTRACEBorder                 = { fg = c.bg_green },
  NotifyTRACEIcon                   = { fg = c.green },
  NotifyTRACETitle                  = { fg = c.green },
  LspSignatureActiveParameter       = { bg = c.active, fg = c.black },
  IlluminatedWordText               = { bg = c.none, style = "nocombine" },
  IlluminatedWordWrite              = { bg = c.none, style = "bold" },
  IlluminatedWordRead               = { bg = c.bg2, style = "nocombine" },
  MiniJump                          = { fg = c.orange, style = "bold" },
  MiniIndentscopeSymbol             = { fg = c.orange },
  MiniIndentscopePrefix             = { fg = c.grey_dim, bg = c.none, style = c.none },
  DiffAdd                           = { fg = c.green, bg = c.line_green },
  DiffChange                        = { fg = c.blue, bg = c.line_blue },
  DiffDelete                        = { fg = c.red, bg = c.line_red },
  NeogitNormal                      = { bg = c.bg0, },
  -- NeogitSubtleText                  = { fg = c.grey_dim },
  -- NeogitObjectId                    = { fg = c.grey_dim, style = "italic" },
  NeogitWinSeparator                = { bg = c.bg0, fg = c.bg_blue },
  -- NeogitNotification                = { bg = c.bg0, },
  NeogitCursorLine                  = { bg = c.bg15, },
  -- NeogitCursorLineNr                = { fg = c.yellow, bg = c.bg15 },
  -- NeogitDiffHeader                  = { bg = c.bg4, fg = c.blue, style = "underline" },
  -- NeogitDiffHeaderHighlight         = { bg = c.bg4, fg = c.orange, style = "bold,underline" },
  -- NeogitDiffContext                 = { bg = c.bg15 },
  -- NeogitDiffContextHighlight        = { bg = c.bg2 },
  -- NeogitHunkHeader                  = { bg = c.grey, fg = c.bg0, style = "bold" },
  -- NeogitHunkHeaderHighlight         = { bg = c.md_purple, fg = c.bg0, style = "bold" },
  HighlightCommentFixme             = { bg = c.red, fg = c.white, style = "bold" },
  HighlightCommentTodo              = { bg = c.blue, fg = c.black, style = "bold" },
  HighlightCommentNote              = { bg = c.green, fg = c.black, style = "bold" },
}
