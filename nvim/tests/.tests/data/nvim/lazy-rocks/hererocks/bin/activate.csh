which deactivate-lua >&/dev/null && deactivate-lua

alias deactivate-lua 'if ( -x '\''/home/joao-pol/.dotfiles/nvim/tests/.tests/data/nvim/lazy-rocks/hererocks/bin/lua'\'' ) then; setenv PATH `'\''/home/joao-pol/.dotfiles/nvim/tests/.tests/data/nvim/lazy-rocks/hererocks/bin/lua'\'' '\''/home/joao-pol/.dotfiles/nvim/tests/.tests/data/nvim/lazy-rocks/hererocks/bin/get_deactivated_path.lua'\''`; rehash; endif; unalias deactivate-lua'

setenv PATH '/home/joao-pol/.dotfiles/nvim/tests/.tests/data/nvim/lazy-rocks/hererocks/bin':"$PATH"
rehash
