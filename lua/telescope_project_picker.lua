local picker = {}

local Path = require('plenary.path')
local finders = require('telescope.builtin').fd
local pickers = require('telescope.pickers')
local config = require('telescope.config').values
local make_entry = require('telescope.make_entry')
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local action_state = require('telescope.actions.state')

local function find_project_root(path)
  local root_indicators = {'_root_dir_', '__pycache__', '.config', '.git', '.gitignore'}

  local function contains_indicator(path_, indicator)
    local indicator_path = Path:new(path_, indicator)
    return indicator_path:exists()
  end

  for _, indicator in ipairs(root_indicators) do
    if contains_indicator(path, indicator) then
      return path
    end
  end

  local parent = path:parent()
  if parent == nil or parent.filename == '/' then
    return nil
  end

  return find_project_root(parent)
end

function picker.project_root_finder(opts)
  opts = opts or {}

  local cwd = vim.fn.expand('%:p:h')
  local root = find_project_root(Path:new(cwd))

  if not root then
    print("No root directory found")
    return
  end

  finders {
    search_dirs = {root.filename},
    hidden = true,
    no_ignore_vcs = true,
    prompt_title = "Project Root File Picker",
    attach_mappings = function(_, map)
      -- Map the default select action to open in a vertical split
      map('i', '<CR>', function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('vsp ' .. entry.value)
      end)

      -- Map the default select action in normal mode to open in a vertical split
      map('n', '<CR>', function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('vsp ' .. entry.value)
      end)

      -- Add the default mappings back
      actions.select_default:replace(function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('vsp ' .. entry.value)
      end)

      return true
    end,
  }
end

return picker
