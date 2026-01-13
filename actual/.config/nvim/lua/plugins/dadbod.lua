-- NOTE: The default behavior of auto-execution of queries on save is disabled
-- this is useful when you have a big query that you don't want to run every time
-- you save the file running those queries can crash neovim to run use the
-- default keymap: <leader>S
vim.g.db_ui_execute_on_save = false
-- NOTE: To add connection:
-- CMD :DBUIAddConnection<CR>
-- Enter connection url: <database>://<user>:<password>@<url>:<port>/<db_name>
-- e.g.: mariadb://root:1056@localhost:3306/railways<CR>
vim.keymap.set("n", "<leader>b", ":DBUIToggle<CR>", { silent = true, desc = "DataBases" })

return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
  },
  lazy = true,
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
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
  end,
}
