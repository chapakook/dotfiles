-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 산문 파일타입. LazyVim의 lazyvim_wrap_spell 그룹이 이미 wrap + spell을 켜는데,
-- 이 그룹이 그 뒤에 실행되므로 여기 값이 이긴다.
-- 순 효과: breakindent 추가(줄바꿈된 줄이 들여쓰기 유지) + 한글 전체에 밑줄을 긋는
-- 영어 스펠체크 해제.
-- CJK 노이즈 없이 영어 오타만 잡고 싶으면 spell = false 대신:
--   vim.opt_local.spell = true
--   vim.opt_local.spelllang = { "en", "cjk" }  -- "cjk" = CJK 문자는 건너뜀
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("rocky_wrap_prose", { clear = true }),
  pattern = { "markdown", "markdown.mdx", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.spell = false -- 오타 밑줄이 필요하면 true
  end,
})

-- 마크다운은 코드가 아니라 문서로 읽는다: 본문 옆 편집기 크롬을 걷어낸다.
-- 되돌리기: <leader>ul(줄번호) / <leader>um(마크다운 렌더 토글)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("rocky_markdown_reading", { clear = true }),
  pattern = { "markdown", "markdown.mdx" },
  callback = function(event)
    -- 줄번호/사인칼럼: 본문 왼쪽에 붙는 숫자와 글리프 제거
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"

    -- listchars(탭/공백 표시)는 산문에서 노이즈
    vim.opt_local.list = false

    -- snacks 인덴트 가이드가 산문 빈 줄에 '│'를 그린다 (버퍼 단위로만 해제)
    vim.b[event.buf].snacks_indent = false
  end,
})
