-- CodeCompanion（AI Agent）配置

-- Read the OAuth token dynamically from Claude Code's credentials file
local function get_claude_token()
  local path = vim.fn.expand("~/.claude/.credentials.json")
  local f = io.open(path, "r")
  if not f then return "" end
  local content = f:read("*a")
  f:close()
  local ok, data = pcall(vim.fn.json_decode, content)
  if ok and data and data.claudeAiOauth then
    return data.claudeAiOauth.accessToken or ""
  end
  return ""
end

local default_adapter = "claude_code"

require("codecompanion").setup({
  interactions = {
    background = {
      adapter = { name = "claude_code" },
      chat = { opts = { enabled = true } },  -- 自动生成会话标题
    },
    chat = { adapter = default_adapter },
    inline = { adapter = default_adapter },
    cmd = { adapter = default_adapter },
  },
  adapters = {
    acp = {
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {
          env = {
            CLAUDE_CODE_OAUTH_TOKEN = get_claude_token(),
          },
        })
      end,
    },
  },
  display = {
    chat = {
      show_reasoning = false,  -- 隐藏 thinking 过程
      fold_context = true,     -- 折叠上下文引用
    },
  },
})

-- 命令别名
vim.cmd([[cab cc CodeCompanion]])

-- 快捷键：toggle Chat 面板（复用同一会话）、对选区进行内联补全/解释
vim.keymap.set({ "n", "v" }, "<leader>ac", ":CodeCompanionChat Toggle<CR>", { desc = "AI Chat toggle" })
vim.keymap.set("v", "<leader>ai", ":CodeCompanion<CR>", { desc = "AI 内联（选区）" })

-- Fidget spinner：请求进行中时显示 adapter 名称和进度
local spinner_handles = {}

local function format_adapter(adapter)
  local parts = { adapter.formatted_name }
  if adapter.model and adapter.model ~= "" then
    table.insert(parts, "(" .. adapter.model .. ")")
  end
  return table.concat(parts, " ")
end

local function setup_spinner()
  local ok, progress = pcall(require, "fidget.progress")
  if not ok then return end

  local group = vim.api.nvim_create_augroup("codecompanion.spinner", {})

  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    callback = function(args)
      spinner_handles[args.data.id] = progress.handle.create({
        title = "",
        message = "  Sending...",
        lsp_client = { name = format_adapter(args.data.adapter) },
      })
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionRequestFinished",
    group = group,
    callback = function(args)
      local handle = spinner_handles[args.data.id]
      spinner_handles[args.data.id] = nil
      if handle then
        local msgs = { success = "󰗡 Completed", error = " Error", cancelled = "󰜺 Cancelled" }
        handle.message = msgs[args.data.status] or "󰜺 Cancelled"
        handle:finish()
      end
    end,
  })
end

setup_spinner()

