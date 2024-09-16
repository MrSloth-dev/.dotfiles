-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/home/joao-pol/.dotfiles/nvim/tests/.tests/data/nvim/lazy-rocks/hererocks" };
}
variables = {
   LUA_DIR = "/home/joao-pol/.dotfiles/nvim/tests/.tests/data/nvim/lazy-rocks/hererocks";
   LUA_BINDIR = "/home/joao-pol/.dotfiles/nvim/tests/.tests/data/nvim/lazy-rocks/hererocks/bin";
   LUA_VERSION = "5.1";
   LUA = "/home/joao-pol/.dotfiles/nvim/tests/.tests/data/nvim/lazy-rocks/hererocks/bin/lua";
}
