-- Python Language Server Configuration
return {
	-- Ruff: Fast linter and formatter
	ruff = {
		init_options = {
			settings = {
				-- Configuration is read from ruff.toml/pyproject.toml
				-- These settings only apply if no config file is found
				configuration = "~/ruff.toml", -- Use ruff.toml if present
				organizeImports = true,
				fixAll = true,
			},
		},
	},
	ty = {}

}
