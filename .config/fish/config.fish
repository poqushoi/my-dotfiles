if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source

set -gx VISUAL /usr/bin/nvim
set -gx EDITOR $VISUAL

# Set up fzf key bindings
fzf --fish | source
