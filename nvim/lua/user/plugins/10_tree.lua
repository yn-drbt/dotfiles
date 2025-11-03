-- dotfiles/nvim/lua/user/plugins/10_tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "left",
        width = 30,
      },
      filesystem = {
        follow_current_file = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false 
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
