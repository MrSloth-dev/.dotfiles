if functions -q deactivate-lua
    deactivate-lua
end

function deactivate-lua
    if test -x '/home/joao-pol/.dotfiles/nvim/.tests/data/nvim/lazy-rocks/hererocks/bin/lua'
        eval ('/home/joao-pol/.dotfiles/nvim/.tests/data/nvim/lazy-rocks/hererocks/bin/lua' '/home/joao-pol/.dotfiles/nvim/.tests/data/nvim/lazy-rocks/hererocks/bin/get_deactivated_path.lua' --fish)
    end

    functions -e deactivate-lua
end

set -gx PATH '/home/joao-pol/.dotfiles/nvim/.tests/data/nvim/lazy-rocks/hererocks/bin' $PATH
