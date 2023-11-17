return {
  { "codota/tabnine-nvim", build = "./dl_binaries.sh" },
-- Disable the tab and s tab in luasnip so it doesn't interfere with the tab operation in tabnine
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
}
