local wezterm = require 'wezterm'
local config = {}

-- config.color_scheme = 'Batman'

-- disable bar at the top
config.window_decorations = "RESIZE" -- "TITLE | RESIZE"

config.window_background_opacity = 0.85

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
}

return config
