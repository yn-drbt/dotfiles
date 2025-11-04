return {
  "nvim-tree/nvim-web-devicons",

  opts = function()
    local icons = require'nvim-web-devicons'.get_icons()

    for _, config in pairs(icons) do
      config.icon = "■"
    end

    -- setup() に渡す設定テーブルを返します
    return {
      override = icons,
      default_icon = "■",
    }
  end,
}
