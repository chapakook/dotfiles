return {
  -- render-markdown: 마크다운 인라인 렌더링
  -- avante의 의존성이 아니라 독립 스펙으로 둔다. avante를 빼도 마크다운 렌더링은 남는다.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdx", "Avante" },
    opts = {
      file_types = { "markdown", "markdown.mdx", "Avante" },
      render_modes = { "n", "c", "t" },

      -- 커서가 있는 줄은 원본 마크업(#, **, `)을 보여줘서 편집이 예측 가능하게 한다.
      -- 단, 폭이 변하는 요소(헤딩 배경/아이콘, 표 테두리, 코드 배경)는 예외로 두어
      -- 커서를 움직일 때 문서가 흔들리지 않게 한다.
      anti_conceal = {
        enabled = true,
        ignore = {
          head_background = true,
          head_border = true,
          head_icon = true,
          code_background = true,
          code_border = true,
          table_border = true,
          sign = true,
        },
      },

      -- 헤딩/코드 블록을 창 폭 전체가 아니라 내용 폭(block)으로 칠한다.
      -- 넓은 창에서 배경 띠가 화면을 가로지르지 않게 하고, min_width로 최소 폭을 보장한다.
      heading = {
        sign = false, -- signcolumn 헤딩 글리프 제거 (autocmds.lua에서 signcolumn도 끈다)
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        width = "block",
        min_width = 60,
        left_pad = 0,
        right_pad = 2,
      },
      code = {
        sign = false,
        width = "block",
        min_width = 60,
        left_pad = 2,
        right_pad = 2,
        border = "thick",
      },
      bullet = {
        icons = { "●", "○", "◆", "◇" },
      },
      pipe_table = {
        preset = "round",
      },
    },
  },

  -- LazyVim markdown extra가 켜는 markdownlint를 끈다.
  -- MD013(줄 길이) / MD060(표 스타일) 같은 미용 규칙이 virtual text로 표와 본문 위에
  -- 덮어써져서 가독성을 오히려 해친다. 구조 파악은 marksman(LSP)이 담당한다.
  -- 다시 쓰려면 이 블록을 지우고 .markdownlint-cli2.yaml로 규칙을 줄이는 편이 낫다.
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = {}
      opts.linters_by_ft["markdown.mdx"] = {}
    end,
  },

  -- 저장 시 포매터도 prettier만 쓴다 (extra가 끼워 넣는 markdownlint-cli2 / markdown-toc 제외)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.markdown = { "prettier" }
      opts.formatters_by_ft["markdown.mdx"] = { "prettier" }
    end,
  },

  -- markdown-preview 빌드 수정.
  -- LazyVim 기본 build는 mkdp#util#install()을 인자 없이 호출하는데, 그 분기는
  -- 터미널 잡을 띄우고 즉시 반환하는 비동기 경로다(autoload/mkdp/util.vim:152).
  -- lazy는 반환을 곧 완료로 보고 build 성공으로 기록하지만 17MB 다운로드는 끝나지 않았고,
  -- nvim이 종료되면 잡도 죽어서 app/bin이 빈 채로 남는다. headless에서는 항상 실패한다.
  -- install_sync는 '!cmd' 블로킹 분기(v:true)를 타므로 :Lazy build / headless 모두 완결된다.
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install_sync"]()
    end,
  },
}
