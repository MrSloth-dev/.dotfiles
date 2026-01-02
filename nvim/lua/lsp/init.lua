-- Aggregate all LSP server configurations
-- This file imports all language-specific server configs and combines them

local servers = {}

-- Import server configurations by language
local lua_servers = require("lsp.servers.lua")
local cpp_servers = require("lsp.servers.cpp")
local python_servers = require("lsp.servers.python")
local arduino_servers = require("lsp.servers.arduino")

-- Merge all server configurations into a single table
servers = vim.tbl_extend("force", servers, lua_servers, cpp_servers, python_servers, arduino_servers)

return servers
