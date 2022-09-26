local M = {}

-- Install plugins
local userPlugins = require "plugins.configs" -- path to table

M.plugins = {
   install = userPlugins,
}

return M

