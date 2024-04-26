local M = {}

M.goto_line_at_same_indent = function(direction)
  local count = vim.v.count
  local startingLineNum, startingColumn = unpack(vim.api.nvim_win_get_cursor(0))
  local finalLine
  if direction == 1 then
    finalLine = vim.fn.line("$")
  else
    finalLine = 0
  end
  local startingIndent = vim.fn.indent(".")

  for lineNum = startingLineNum + direction, finalLine, direction do
    local thisIndent = vim.fn.indent(lineNum)
    if thisIndent == startingIndent then
      local lineText = vim.api.nvim_buf_get_lines(0, lineNum - 1, lineNum, false)[1]
      if lineText ~= nil and vim.trim(lineText) ~= "" then
        vim.api.nvim_win_set_cursor(0, { lineNum, startingColumn })
        count = count - 1
        if count < 1 then
          break
        end
      end
    end
  end
end

M.goto_prev_line_at_same_indent = function()
  M.goto_line_at_same_indent(-1)
end

M.goto_next_line_at_same_indent = function()
  M.goto_line_at_same_indent(1)
end

return M
