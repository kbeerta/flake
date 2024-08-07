
local M = {}

local colors = {
  bg = "#181926",
  fg = "#cad3f5",

  black = "#24273a",
  white = "#f4dbd6",
  red = "#ed8796",
  green = "#a6da95",
  blue = "#8aadf4",
  yellow = "#eed49f",
  magenta = "#c6a0f6",
  cyan = "#91d7e3",

  none = "NONE",
}


local theme = {
  Cursor      = { fg = colors.bg, bg = colors.fg },
  Normal      = { fg = colors.fg, bg = colors.none },
  NormalNC    = { fg = colors.fg, bg = colors.none },

  Keyword     = { fg = colors.red },
  String      = { fg = colors.green },
  Type        = { fg = colors.yellow },
  Function    = { fg = colors.magenta },
  Statement   = { fg = colors.magenta },
}

function M.setup()
  for group, hl in pairs(theme) do
    hl = type(hl) == "string" and { link = hl } or hl
    vim.api.nvim_set_hl(0, group, hl)
  end
end

return M
