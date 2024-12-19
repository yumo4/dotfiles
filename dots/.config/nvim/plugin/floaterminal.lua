-- Floaterminal
-- credit: TJ
local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}
-- Function to create a centered floating window
local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.with or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the starting position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a new buffer for the floating window
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
  end

  -- Set window options for the floating window
  local win_config = {
    relative = "editor", -- Position relative to the entire Neovim editor
    width = width, -- Width of the window
    height = height, -- Height of the window
    col = col, -- Horizontal starting position
    row = row, -- Vertical starting position
    style = "minimal", -- No UI decorations
    border = "rounded", -- Add a rounded border
  }

  -- Open the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
    vim.cmd("startinsert") -- "spawn" in insert mode
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- fixes colors
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })

-- Example usage
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<space>tt", toggle_terminal)
