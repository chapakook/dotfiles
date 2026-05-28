return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    keys = {
      { "<leader>rr", function() require("kulala").run() end, desc = "Run request" },
      { "<leader>rl", function() require("kulala").replay() end, desc = "Re-run last request" },
      { "<leader>re", function() require("kulala").set_selected_env() end, desc = "Select environment" },
      { "<leader>rt", function() require("kulala").toggle_view() end, desc = "Toggle headers/body" },
      { "<leader>rc", function() require("kulala").copy() end, desc = "Copy as cURL" },
      { "<leader>rs", function() require("kulala").scratchpad() end, desc = "Open scratchpad" },
    },
    opts = {
      global_keymaps = false,
      default_view = "body",
      winbar = true,
    },
  },
}
