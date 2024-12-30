if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source

set -gx VISUAL /usr/bin/nvim
set -gx EDITOR $VISUAL

# Set up fzf key bindings
fzf --fish | source

# Add local bin to path
fish_add_path ~/.local/bin/

# Add scripts to path
fish_add_path ~/.local/scripts/

# Add python path
fish_add_path /home/groot/venvs/python/my_global_venv/.venv/bin

# nvm
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent

# Add deno
fish_add_path /home/groot/.deno/bin

