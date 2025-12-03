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

	-- Pyright: Type checking and intellisense
	pyright = {
		settings = {
			pyright = {
				-- Let Ruff handle imports
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					-- Type checking mode: "off", "basic", "standard", "strict"
					typeCheckingMode = "basic",
					-- Only check open files for better performance
					diagnosticMode = "openFilesOnly",
					-- Auto-import completions
					autoImportCompletions = true,
					-- Auto search paths
					autoSearchPaths = true,
					-- Use library code for types
					useLibraryCodeForTypes = true,
					-- Inlay hints
					inlayHints = {
						variableTypes = true,
						functionReturnTypes = true,
						parameterTypes = true,
					},
					-- Diagnostics severity overrides
					diagnosticSeverityOverrides = {
						reportUnusedImport = "information",
						reportUnusedVariable = "information",
						reportMissingTypeStubs = "none",
						reportOptionalMemberAccess = "warning",
					},
				},
			},
		},
	},
}
