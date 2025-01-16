return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java", -- Enable only on .java file extensions
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("lspconfig").jdtls.setup {}
      local dap = require "dap"
      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }
    end,
  },
}
