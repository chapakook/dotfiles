return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      -- 설정은 plugins/markdown.lua에 있다 (Avante 파일타입 포함)
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
      provider = "gemini",
      providers = {
        gemini = {
          api_key_name = "GEMINI_API_KEY",
          model = "gemini-2.5-flash",
          timeout = 30000,
          extra_request_body = {
            generationConfig = {
              temperature = 0.7,
            },
          },
        },
      },
    },
  },
}
