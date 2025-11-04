-- dotfiles/nvim/lua/user/plugins/50_comment.lua
--
return {
  'numToStr/Comment.nvim',
  event = "VeryLazy",

  -- setup() を自動で呼び出す
  opts = {}, 

  -- 'keys' テーブルでキーマップを定義
  keys = {
    {
      -- Normal モードで 'gc' を押した時
      "gc",
      -- (変更点) Lua APIではなく、プラグイン提供のコマンドを使用
      "<cmd>CommentToggle<CR>",
      mode = "n",
      desc = "Comment: Toggle line (Normal)"
    },
    {
      -- Visual モードで 'gc' を押した時
      "gc",
      -- (変更点) Visual モードでも同じコマンドで動作します
      "<cmd>CommentToggle<CR>",
      mode = "v",
      desc = "Comment: Toggle selection (Visual)"
    }
  }
}
