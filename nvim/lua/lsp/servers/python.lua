-- Python Language Server Configuration
return {
	ruff = {},
	-- Other Python servers you might want to add:
	-- pyright = {},
	pyright = {
		settings = {
			-- Disable type checking and diagnostics
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				-- Disable all diagnostics from Pyright
				diagnosticMode = "off",
				-- Or use "openFilesOnly" if you want some type hints
				typeCheckingMode = "off",
			},
		},
	},
}
