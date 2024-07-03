local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.clang_format,
  }
})

local function is_aha_repo()
  local url = vim.fn.system({"git",  "remote", "get-url", "origin"})
  print(url)

  return url == "git@code.byted.org:lark/aha.git"
end

local function cc_format()
  if (is_aha_repo()) then
    local git_path = vim.fn.system('git rev-parse --show-toplevel')
    print(git_path)
    local format_py_path = git_path .. "tools/vim/clang-format.py"
    vim.cmd({ cmd = 'py3f', args = { format_py_path }})
  else
  end
end

vim.keymap.set("", "<Leader>f", cc_format)
