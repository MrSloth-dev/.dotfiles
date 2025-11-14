-- C/C++ Language Server Configuration
return {
	clangd = {
		cmd = { "clangd", "-Wall", "-Werror", "-Wextra", "-std=c++98" },
	},
}
