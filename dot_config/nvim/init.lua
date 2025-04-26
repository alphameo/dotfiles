require "options"
require "filetypes"
require "mappings"
require "autocmds"
require "diagnostics"
require "lazyvim"

require("langmapper").automapping { global = true, buffer = true }
