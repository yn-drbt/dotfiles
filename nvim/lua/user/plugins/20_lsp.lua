-- dotfiles/nvim/lua/user/plugins/20_lsp.lua

return {
  -- LSP インストーラ
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()


    end,
  },

  -- mason と lspconfig を繋ぐ
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },

  -- LSP 本体
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- (補完機能から capabilities をもらうため)
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        -- キーマップ設定のヘルパー
        --
        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = "LSP: " .. desc })
        end

        -- 1. プレフィックスなしのキーマップ
        -- (これらは <leader> を押さないため which-key のポップアップ対象外です)
        bufmap("n", "K", vim.lsp.buf.hover, "Hover")
        bufmap("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        
        -- ★ ご要望のキーマップ
        bufmap("n", "gl", vim.diagnostic.open_float, "Show Diagnostics")


        -- 2. <leader> 付きのキーマップ
        -- (which-key で表示させやすくするため <leader>rn -> <leader>r, <leader>ca -> <leader>c に変更推奨)
        bufmap("n", "<leader>r", vim.lsp.buf.rename, "Rename")
        bufmap("n", "<leader>c", vim.lsp.buf.code_action, "Code Action")
        -- (もし <leader>rn, <leader>ca のままが良い場合は、下の register も変更が必要です)


        -- 3. which-key に <leader> キーマップを登録
        -- (which-key プラグインがロードされているか安全に確認)
        local wk_status, wk = pcall(require, "which-key")
        if wk_status then
          wk.register({
            ["<leader>"] = {
              r = "LSP: Rename",
              c = "LSP: Code Action",
              -- (もし <leader>rn, <leader>ca のままの場合)
              -- r = { n = "LSP: Rename" },
              -- c = { a = "LSP: Code Action" },
            }
          }, {
            mode = "n",
            prefix = "<leader>", -- <leader> (スペース) をプレフィックスとして
            buffer = bufnr,     -- このバッファでのみ有効にする
          })
        end
      end
    end
  },
}
