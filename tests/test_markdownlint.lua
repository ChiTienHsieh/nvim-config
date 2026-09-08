-- A15: local markdownlint opts merge into locked LazyVim nvim-lint initializer.
-- Run with: nvim --clean -l tests/test_markdownlint.lua
-- Does not start a live LazyVim session or touch lockfiles.
-- Paths are resolved from this test file so any cwd / relocated checkout works.

local function fail(msg)
  io.stderr:write("FAIL: " .. msg .. "\n")
  vim.cmd("cquit 1")
end

local function ok(msg)
  io.stdout:write("ok: " .. msg .. "\n")
end

local function assert_eq(actual, expected, label)
  if actual ~= expected then
    fail(string.format("%s: expected %s, got %s", label, tostring(expected), tostring(actual)))
  end
end

local function assert_true(cond, label)
  if not cond then
    fail(label)
  end
end

local function contains(list, value)
  for _, item in ipairs(list or {}) do
    if item == value then
      return true
    end
  end
  return false
end

local function deep_copy(value)
  if type(value) ~= "table" then
    return value
  end
  local out = {}
  for k, v in pairs(value) do
    out[k] = deep_copy(v)
  end
  return out
end

-- Resolve repo root from this script path (not cwd, not controller /tmp hardcodes).
local source = debug.getinfo(1, "S").source
assert_true(type(source) == "string" and source:sub(1, 1) == "@", "test script path unavailable")
local test_file = source:sub(2)
local tests_dir = vim.fn.fnamemodify(test_file, ":p:h")
local repo_root = vim.fn.fnamemodify(tests_dir, ":h")

-- Isolate HOME/TMPDIR so the harness never loads a live user Neovim config.
local isolation_root = vim.fn.tempname() .. "-nvim-a15-test"
assert_true(vim.fn.mkdir(isolation_root, "p") == 1, "failed to create isolation root")
local isolated_home = isolation_root .. "/home"
local isolated_tmpdir = isolation_root .. "/tmp"
assert_true(vim.fn.mkdir(isolated_home, "p") == 1, "failed to create isolated HOME")
assert_true(vim.fn.mkdir(isolated_tmpdir, "p") == 1, "failed to create isolated TMPDIR")
vim.env.HOME = isolated_home
vim.env.TMPDIR = isolated_tmpdir
vim.env.XDG_CONFIG_HOME = isolated_home .. "/.config"
vim.env.XDG_DATA_HOME = isolated_home .. "/.local/share"
vim.env.XDG_STATE_HOME = isolated_home .. "/.local/state"
vim.env.XDG_CACHE_HOME = isolated_home .. "/.cache"

-- Locked upstream source vendored under tests/fixtures (not live LazyVim).
local upstream_path = repo_root .. "/tests/fixtures/lazyvim-linting.lua"
local local_path = repo_root .. "/lua/plugins/markdownlint-settings.lua"

assert_true(vim.fn.filereadable(upstream_path) == 1, "missing fixture: " .. upstream_path)
assert_true(vim.fn.filereadable(local_path) == 1, "missing local spec: " .. local_path)

local upstream = dofile(upstream_path)[1]
local local_spec = dofile(local_path)[1]

assert_true(type(upstream.config) == "function", "upstream must provide config")
assert_true(local_spec.config == nil, "local spec must not override config")
assert_true(type(local_spec.opts) == "table", "local spec must provide opts")
assert_true(
  type(local_spec.opts.linters) == "table"
    and type(local_spec.opts.linters.markdownlint) == "table"
    and type(local_spec.opts.linters.markdownlint.prepend_args) == "table",
  "local opts.linters.markdownlint.prepend_args required"
)

local required_args = { "--disable", "MD012", "MD013", "MD022", "MD033", "MD041" }
for _, arg in ipairs(required_args) do
  assert_true(
    contains(local_spec.opts.linters.markdownlint.prepend_args, arg),
    "local args missing " .. arg
  )
end

-- Stub lint module + autocmd surface the way the audit repro did.
local autocmd_events = 0
local autocmd_event_list = nil
local lint = {
  linters = {
    markdownlint = {
      -- Locked nvim-lint ca6ea12 default; custom rules must keep --stdin.
      args = { "--stdin" },
    },
  },
  linters_by_ft = {},
  _resolve_linter_by_ft = function()
    return {}
  end,
  try_lint = function() end,
}
package.loaded.lint = lint

_G.LazyVim = {
  warn = function() end,
}

vim.api.nvim_create_augroup = function()
  return 1
end
vim.api.nvim_create_autocmd = function(events, _opts)
  autocmd_events = autocmd_events + 1
  autocmd_event_list = events
end
vim.uv = vim.uv or {}
vim.uv.new_timer = function()
  return {
    start = function() end,
    stop = function() end,
  }
end

-- lazy.nvim merges plugin opts; user config absence keeps upstream config.
local merged_opts = vim.tbl_deep_extend("force", deep_copy(upstream.opts or {}), deep_copy(local_spec.opts or {}))

-- Seed filetype mapping from upstream opts so config can assign it.
assert_true(type(merged_opts.linters_by_ft) == "table", "merged opts keep linters_by_ft")
assert_true(type(merged_opts.events) == "table", "merged opts keep events")
assert_true(contains(merged_opts.events, "BufWritePost"), "BufWritePost event preserved")

upstream.config(upstream, merged_opts)

assert_eq(autocmd_events, 1, "autocmd count")
assert_true(type(autocmd_event_list) == "table", "autocmd events recorded")
assert_true(contains(autocmd_event_list, "BufWritePost"), "autocmd includes BufWritePost")

assert_true(next(lint.linters_by_ft) ~= nil, "linters_by_ft configured from upstream opts")
assert_true(lint.linters_by_ft.fish ~= nil, "fish filetype mapping survives")

local args = lint.linters.markdownlint.args
assert_true(type(args) == "table", "markdownlint.args present after merge")
assert_true(contains(args, "--stdin"), "default stdin flag survives custom rules")
for _, arg in ipairs(required_args) do
  assert_true(contains(args, arg), "merged args missing " .. arg)
end

ok("local opts merge preserves autocmd, filetypes, and markdownlint args")
ok("local spec has no config override")
ok("resolved repo_root=" .. repo_root)
vim.cmd("qa!")
