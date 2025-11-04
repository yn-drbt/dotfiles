-- dotfiles/nvim/lua/user/plugins/10_tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  config = function()
    require("neo-tree").setup({
      default_component_configs = {
        icon = {
          default = "■",         -- どのファイルタイプにも一致しない場合のアイコン
          folder_closed = "└─", -- フォルダ（閉）のアイコンを空白に
          folder_open = "├─",   -- フォルダ（開）のアイコンを空白に
          folder_empty = "├─",  -- 空フォルダのアイコンを空白に
          folder_empty_open = "├─", -- 開いた空のフォルダ

          symlink = "↗",             -- シンボリックリンク（ファイル）
          symlink_target = "↘",     -- シンボリックリンクの参照先 (デフォルトは "  "）

          highlight = "NeoTreeFileIcon", -- アイコン全体に適用するハイライトグループ
          use_diagnostic_colors = true, -- エラーや警告に応じてアイコンの色を変えるか
          use_filtered_colors = true,   -- (git ignoreなどで)フィルターされたファイルの色を変えるか
        }
      },
      window = {
        position = "left",
        width = 30,
      },
      filesystem = {
        follow_current_file = {
            enabled = true,
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        }
      },
    })

    -- キーマップ: <leader>e でツリーを開閉
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {
      desc = "Explorer: Toggle Neo-tree",
      silent = true,
    })
  end,
}
