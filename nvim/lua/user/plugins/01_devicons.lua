return {
  "nvim-tree/nvim-web-devicons",

  opts = function()
    local devicons = require('nvim-web-devicons')

    -- Nerd Font 判定関数
    local function has_nerd_font()
      local ok, icon = pcall(require("nvim-web-devicons").get_icon, "init.lua")
      if not ok or not icon then
        return false
      end
      -- get_iconが空文字や?を返す場合はNG
      if icon == "" or icon:match("[%?□�]") then
        return false
      end
      return true
    end

    -- local function has_nerd_font()
    --   -- GitHub アイコン（）などNerd Font固有の文字
    --   local test_icon = ""
    --   local width = vim.fn.strwidth(test_icon)
    --   -- widthが0や大きすぎる場合は文字化けとみなす
    --   return width > 0 and width <= 2
    -- end

    local icons = devicons.get_icons()

    if not has_nerd_font() then
      -- Nerd Font 無 → フォールバック (□アイコンなど)
      for _, config in pairs(icons) do
        config.icon = "■"
      end
      return {
        override = icons,
        default_icon = "■",
      }
    else
      -- Nerd Font 有 → 元のアイコンを使う
      return {
        override = icons,
        default = true,
      }
    end
  end,
}
