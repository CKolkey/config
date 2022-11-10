local M = {}

M.colors = {
  none = "NONE",

  black      = "#181a1b",
  bg0        = "#22252A",
  bg1        = "#282C34",
  bg2        = "#363a4e",
  bg3        = "#393e53",
  bg4        = "#3f445b",
  grey_dim   = "#5c6071",
  grey       = "#7e8294",
  grey_light = "#959da9",
  fg         = "#c5cdd9",
  white      = "#fcfcfc",

  line_red    = "#4e363b",
  line_green  = "#364e3e",
  line_orange = "#4e3e36",
  line_blue   = "#363a4e",
  line_purple = "#41364e",

  red       = "#E06C75",
  bg_red    = "#b5585f",
  lt_red    = "#eed8da",
  orange    = "#FFCB6B",
  bg_orange = "#d4a959",
  lt_orange = "#f5ebd9",
  yellow    = "#FFE082",
  bg_yellow = "#d4bb6c",
  lt_yellow = "#f5efdd",
  green     = "#C3E88D",
  bg_green  = "#9fbd73",
  lt_green  = "#f3f6ed",
  cyan      = "#6ce0cf",
  bg_cyan   = "#58b5a8",
  lt_cyan   = "#d8eeeb",
  blue      = "#82AAFF",
  bg_blue   = "#6c8ed4",
  lt_blue   = "#dde5f5",
  purple    = "#C792EA",
  bg_purple = "#a377bf",
  lt_purple = "#eadff0",

  active   = "#98c379",
  inactive = "#90AB7B",
}

local c = M.colors

M.icons = {
  error    = " ",
  warning  = " ",
  info     = " ",
  hint     = " ",
  debug    = " ",
  trace    = " ",
  added    = " ",
  removed  = " ",
  modified = " ",
}

M.highlights = {
  ["@number"]                = { fg = c.red, bg    = c.none },
  ["@float"]                 = { fg = c.yellow, bg = c.none },
  ["@label"]                 = { fg = c.red, bg    = c.none, style = "italic,bold" },
  ["@variable"]              = { fg = c.white, bg  = c.none },
  ["@variable.builtin"]      = { fg = c.yellow, bg = c.none, style = "italic" },
  ["@variable.global"]       = { fg = c.cyan, bg   = c.none, style = "bold" },
  ["@function.builtin"]      = { fg = c.purple, bg = c.none },
  ["@type"]                  = { fg = c.yellow, bg = c.none, style = "italic" },
  ["@field"]                 = { fg = c.blue, bg   = c.none, style = "bold" },
  ["@symbol"]                = { fg = c.red, bg    = c.none, style = "bold" },
  ["@symbol.ruby"]           = { fg = c.red, bg    = c.none, style = "bold" },
  ["@punctuation.bracket"]   = { fg = c.white, bg  = c.none },
  ["@punctuation.delimiter"] = { fg = c.white, bg  = c.none },
  ["@punctuation.special"]   = { fg = c.purple, bg = c.none },
  ["@operator"]              = { fg = c.purple, bg = c.none },
  ["@underline"]             = { fg = c.none, bg   = c.none, style = "bold" },
  ["@string.regex"]          = { fg = c.orange, bg = c.none },
  ["@boolean"]               = { fg = c.orange, bg = c.none, style = "italic" },
  ["@tag"]                   = { fg = c.red, bg    = c.none, style = "bold" },
  ["@text"]                  = { fg = c.white, bg  = c.none },
  ["@tag.attribute"]         = { fg = c.yellow, bg = c.none, style = "italic" },

  WinSeparator = { bg = c.bg0, fg = c.inactive },
  VisualYank   = { bg = c.line_purple },
  FloatBorder    = { bg = c.bg1, fg      = c.purple },
  CursorLineNr   = { fg = c.yellow, bg   = c.none, style = c.none },
  CursorLine     = { fg = c.none, bg     = c.bg2,  style  = c.none },
  IncSearch      = { fg = c.bg1, bg      = c.green },

  Type           = { fg = c.red, bg      = c.none, style = "italic" },
  Structure      = { fg = c.red, bg      = c.none, style = "italic" },
  StorageClass   = { fg = c.red, bg      = c.none, style = "italic" },
  Identifier     = { fg = c.orange, bg   = c.none, style = "italic" },
  Constant       = { fg = c.orange, bg   = c.none, style = "italic" },
  CursorColumn   = { fg = c.none, bg     = c.bg2,  style  = c.none },
  CurrentWord    = { fg = c.none, bg     = c.none, style = c.none },
  ErrorMsg       = { fg = c.red, bg      = c.none, style = "bold" },
  Comment        = { fg = c.grey_dim, bg = c.none, style = "italic" },
  SpecialComment = { fg = c.grey_dim, bg = c.none, style = "italic" },
  Todo           = { fg = c.purple, bg   = c.none, style = "italic" },

  -- ScrollView          = { fg = c.none, bg     = c.fg },
  -- CleverFDefaultLabel = { fg = c.red, bg      = c.none, style = "bold" },
  -- BiscuitColor        = { fg = c.grey_dim, bg = c.none, style = "italic" },

  IndentBlanklineEven    = { fg = c.grey_dim, bg = c.none, style = "nocombine" },
  IndentBlanklineOdd     = { fg = c.grey_dim, bg = c.none, style = "nocombine" },
  IndentBlanklineContext = { fg = c.orange, bg   = c.none, style = "nocombine" },

  GitSignsAdd    = { fg = c.green, bg = c.none, style = c.none },
  GitSignsChange = { fg = c.blue, bg  = c.none, style = c.none },
  GitSignsDelete = { fg = c.red, bg   = c.none, style = c.none },

  ErrorText   = { fg = c.red, bg    = c.none, style = "bold", sp = c.red },
  WarningText = { fg = c.yellow, bg = c.none, style = "bold", sp = c.yellow },
  InfoText    = { fg = c.blue, bg   = c.none, style = "bold", sp = c.blue },
  HintText    = { fg = c.green, bg  = c.none, style = "bold", sp = c.green },

  MatchParen    = { fg = c.orange, bg = c.none, style = "bold" },
  MatchParenCur = { fg = c.orange, bg = c.none, style = "bold" },
  MatchWord     = { fg = c.orange, bg = c.none, style = "italic" },
  MatchWordCur  = { fg = c.orange, bg = c.none, style = "italic" },

  ActiveWindow   = { fg = c.none, bg = c.none },
  InactiveWindow = { fg = c.none, bg = c.bg0 },

  DiagnosticError          = { fg  = c.red, bg    = c.none, style = "bold" },
  DiagnosticWarn           = { fg  = c.orange, bg = c.none, style = "bold" },
  DiagnosticInfo           = { fg  = c.blue, bg   = c.none, style = "bold" },
  DiagnosticHint           = { fg  = c.green, bg  = c.none, style = "bold" },
  DiagnosticUnderlineError = { style = "underline" },
  DiagnosticUnderlineWarn  = { style = "underline" },
  DiagnosticUnderlineInfo  = { style = "underline" },
  DiagnosticUnderlineHint  = { style = "underline" },

  PmenuSel = { bg = c.bg1, fg = c.none },
  Pmenu    = { fg = c.fg, bg  = c.bg0 },

  CmpItemAbbrDeprecated    = { fg = c.grey, bg      = c.none, style = "strikethrough" },
  CmpItemAbbrMatch         = { fg = c.blue, bg      = c.none, style = "bold" },
  CmpItemAbbrMatchFuzzy    = { fg = c.blue, bg      = c.none, style = "bold" },
  CmpItemMenu              = { fg = c.purple, bg    = c.none, style = "italic" },
  CmpItemKindField         = { fg = c.lt_red, bg    = c.bg_red },
  CmpItemKindProperty      = { fg = c.lt_red, bg    = c.bg_red },
  CmpItemKindEvent         = { fg = c.lt_red, bg    = c.bg_red },
  CmpItemKindText          = { fg = c.lt_green, bg  = c.bg_green },
  CmpItemKindEnum          = { fg = c.lt_green, bg  = c.bg_green },
  CmpItemKindKeyword       = { fg = c.lt_green, bg  = c.bg_green },
  CmpItemKindConstant      = { fg = c.lt_yellow, bg = c.bg_yellow },
  CmpItemKindConstructor   = { fg = c.lt_yellow, bg = c.bg_yellow },
  CmpItemKindReference     = { fg = c.lt_yellow, bg = c.bg_yellow },
  CmpItemKindFunction      = { fg = c.lt_purple, bg = c.bg_purple },
  CmpItemKindStruct        = { fg = c.lt_purple, bg = c.bg_purple },
  CmpItemKindClass         = { fg = c.lt_purple, bg = c.bg_purple },
  CmpItemKindModule        = { fg = c.lt_purple, bg = c.bg_purple },
  CmpItemKindOperator      = { fg = c.lt_purple, bg = c.bg_purple },
  CmpItemKindVariable      = { fg = c.fg, bg        = c.grey },
  CmpItemKindFile          = { fg = c.fg, bg        = c.grey },
  CmpItemKindUnit          = { fg = c.lt_orange, bg = c.bg_orange },
  CmpItemKindSnippet       = { fg = c.lt_orange, bg = c.bg_orange },
  CmpItemKindFolder        = { fg = c.lt_orange, bg = c.bg_orange },
  CmpItemKindMethod        = { fg = c.lt_blue, bg   = c.bg_blue },
  CmpItemKindValue         = { fg = c.lt_blue, bg   = c.bg_blue },
  CmpItemKindEnumMember    = { fg = c.lt_blue, bg   = c.bg_blue },
  CmpItemKindInterface     = { fg = c.lt_cyan, bg   = c.bg_cyan },
  CmpItemKindColor         = { fg = c.lt_cyan, bg   = c.bg_cyan },
  CmpItemKindTypeParameter = { fg = c.lt_cyan, bg   = c.bg_cyan },

  TelescopeSelection      = { bg = c.bg4, fg    = c.active },
  TelescopePromptNormal   = { bg = c.bg4 },
  TelescopeSlectionCaret  = { fg = c.active },
  TelescopeMultiSelection = { fg = c.active },
  TelescopeNormal         = { fg = c.fg, bg     = c.bg1 },
  TelescopeResultsBorder  = { bg = c.bg1 },
  TelescopePreviewBorder  = { fg = c.bg0, bg    = c.bg1 },
  TelescopePromptBorder   = { bg = c.bg4 },
  TelescopePromptTitle    = { fg = c.active, bg = c.bg4 },
  TelescopeResultsTitle   = { fg = c.bg1, bg    = c.bg1 },
  TelescopePreviewTitle   = { fg = c.bg1, bg    = c.bg1 },
  TelescopeMatching       = { fg = c.orange },

  NotifyERRORBorder = { fg = c.bg_red },
  NotifyERRORIcon   = { fg = c.red },
  NotifyERRORTitle  = { fg = c.red },
  NotifyWARNBorder  = { fg = c.bg_orange },
  NotifyWARNIcon    = { fg = c.orange },
  NotifyWARNTitle   = { fg = c.orange },
  NotifyINFOBorder  = { fg = c.bg_blue },
  NotifyINFOIcon    = { fg = c.blue },
  NotifyINFOTitle   = { fg = c.blue },
  NotifyDEBUGBorder = { fg = c.bg_purple },
  NotifyDEBUGIcon   = { fg = c.purple },
  NotifyDEBUGTitle  = { fg = c.purple },
  NotifyTRACEBorder = { fg = c.bg_green },
  NotifyTRACEIcon   = { fg = c.green },
  NotifyTRACETitle  = { fg = c.green },

  LspSignatureActiveParameter = { bg = c.active, fg = c.black },

  MiniJump              = { fg = c.orange, style  = "bold" },
  MiniCursorword        = { bg = c.bg2 },
  MiniCursorwordCurrent = { bg = c.none },
  MiniIndentscopeSymbol = { fg = c.orange },
  MiniIndentscopePrefix = { fg = c.grey_dim, bg = c.none, style = c.none },

  LeapBackdrop       = { fg = c.grey_light },
  LeapMatch          = { fg = c.orange, style = "bold" },
  LeapLabelPrimary   = { fg = c.red, style    = "italic" },
  LeapLabelSecondary = { fg = c.red, style    = "italic" },

  NeoTreeCursorLine         = { bg    = c.line_red },
  NeoTreeDimText            = { fg    = c.grey },
  NeoTreeDirectoryIcon      = { fg    = c.orange },
  NeoTreeDirectoryName      = { fg    = c.blue },
  NeoTreeDotfile            = { fg    = c.grey_light },
  NeoTreeFileName           = { fg    = c.white },
  NeoTreeHarpoonIcon        = { fg    = c.grey_dim, style = "italic" },
  NeoTreeFileNameOpened     = { fg    = c.yellow, style   = "italic" },
  NeoTreeModified           = { style = "italic" },
  NeoTreeFilterTerm         = { fg    = c.white, style    = "italic" },
  NeoTreeSymbolicLinkTarget = { fg    = c.cyan },
  NeoTreeGitAdded           = { fg    = c.green },
  NeoTreeGitConflict        = { fg    = c.red, style      = "bold" },
  NeoTreeGitDeleted         = { fg    = c.red },
  NeoTreeGitIgnored         = { fg    = c.grey_light },
  NeoTreeGitModified        = { fg    = c.purple },
  NeoTreeGitRenamed         = { fg    = c.green, style    = "italic" },
  NeoTreeGitUntracked       = { fg    = c.grey_light },
  NeoTreeHiddenByName       = { fg    = c.grey_dim },
  NeoTreeIndentMarker       = { fg    = c.bg_orange },
  NeoTreeNormal             = { bg    = c.bg1 },
  NeoTreeNormalNC           = { bg    = c.bg1 },
  NeoTreeFloatBorder        = { bg    = c.bg1, fg         = c.inactive },
  NeoTreeFloatTitle         = { bg    = c.bg1, fg         = c.grey_dim },
  NeoTreeRootName           = { bg    = c.none, fg        = c.purple },
  NeoTreeTitleBar           = { bg    = c.none, fg        = c.purple },

  NeotestPassed       = { fg = c.green },
  NeotestRunning      = { fg = c.orange },
  NeotestFailed       = { fg = c.red },
  NeotestSkipped      = { fg = c.yellow },
  NeotestTest         = { fg = c.white },
  NeotestNamespace    = { fg = c.orange, style = "bold" },
  NeotestFocused      = { fg = c.purple },
  NeotestFile         = { fg = c.fg, style     = "italic" },
  NeotestDir          = { fg = c.blue },
  NeotestBorder       = { fg = c.yellow },
  NeotestIndent       = { fg = c.yellow },
  NeotestExpandMarker = { fg = c.yellow },
  NeotestAdapterName  = { fg = c.red, style    = "italic" },

  DiffAdd    = { fg = c.green, bg = c.line_green },
  DiffChange = { fg = c.blue, bg  = c.line_blue },
  DiffDelete = { fg = c.red, bg   = c.line_red },

  NeogitNotificationInfo       = { fg = c.blue },
  NeogitNotificationWarning    = { fg = c.yellow },
  NeogitNotificationError      = { fg = c.red },
  NeogitDiffAddHighlight       = { fg = c.green, bg = c.line_green },
  NeogitDiffAddCLHighlight     = { fg = c.green, bg = c.line_green, style = "bold" },
  NeogitDiffDeleteHighlight    = { fg = c.red, bg   = c.line_red },
  NeogitDiffDeleteCLHighlight  = { fg = c.red, bg   = c.line_red, style   = "bold" },
  NeogitDiffContextHighlight   = { fg = c.blue, bg  = c.line_blue },
  NeogitDiffContextCLHighlight = { fg = c.blue, bg  = c.line_blue, style  = "bold" },
  NeogitHunkHeaderHighlight    = { fg = c.bg1, bg   = c.none },
  NeogitHunkHeaderCLHighlight  = { fg = c.bg1, bg   = c.none },
}

return M
