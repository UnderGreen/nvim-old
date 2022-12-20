local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local navic_ok, navic = pcall(require, "nvim-navic")
local winbar_cfg = {}
local inactive_winbar_cfg = {}
if navic_ok then
  winbar_cfg = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { "filename", path = 1, color = { bg = "NONE" } },
      { navic.get_location, cond = navic.is_available },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  }
  inactive_winbar_cfg = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { "filename", path = 1, color = { bg = "NONE" } },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  }
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = true,
  always_visible = true,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local location = {
  "location",
  padding = 1,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "alpha", "dashboard" },
      winbar = {
        "NvimTree",
        "Outline",
        "toggleterm",
        "alpha",
        "dap-repl",
        "packer",
      },
    },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diagnostics },
    lualine_x = { diff, spaces, "encoding", filetype },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = winbar_cfg,
  inactive_winbar = inactive_winbar_cfg,
  extensions = { "nvim-tree", "quickfix", "fugitive", "symbols-outline", "toggleterm", "nvim-dap-ui" },
})
