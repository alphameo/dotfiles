return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      "kristijanhusak/vim-dadbod-completion",
    },
    lazy = true,
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    ft = { "sql", "mysql", "plsql" },
    config = function()
      local data_path = vim.fn.stdpath "data"

      vim.g.db_ui_auto_execute_table_helpers = 1
      -- vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_save_location = vim.fn.getcwd() .. "/sql/"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true
      vim.g.db_ui_table_helpers = {
        postgresql = {
          ["Table Size"] = [[
select table_name, pg_size_pretty(pg_total_relation_size(quote_ident(table_name))), pg_total_relation_size(quote_ident(table_name)) from information_schema.tables where table_schema = 'public' and table_name = '{table}';
]],
          ["Count"] = [[
select count(*) from {table};
]],
        },
      }

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <leader>S
      vim.g.db_ui_execute_on_save = false
      vim.keymap.set("n", "<leader>ld", ":DBUIToggle<CR>", { silent = true, desc = "DBUI" })
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    lazy = true,
    ft = { "sql", "mysql", "plsql" },
    config = function()
      vim.cmd [[
                autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
                autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
            ]]
    end,
  },
}
