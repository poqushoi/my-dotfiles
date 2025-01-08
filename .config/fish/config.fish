if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Check if Starship is installed
if not type -q starship
    echo "Starship is not installed. Installing..."
    curl -sS https://starship.rs/install.sh | sh
else
    # Initialize Starship
    set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
    starship init fish | source
end

set -gx VISUAL /usr/bin/nvim
set -gx EDITOR $VISUAL

# Check if FZF is installed
if not type -q fzf
    echo "FZF is not installed. Please install it by following the instructions at:"
    echo "https://github.com/junegunn/fzf#installation"
else
    # Initialize FZF
    fzf --fish | source
end

# Add local bin to path
fish_add_path ~/.local/bin/

# Add scripts to path
fish_add_path ~/.local/scripts/

# Add python path
fish_add_path /home/groot/venvs/python/my_global_venv/.venv/bin

# nvm
if not test -d $HOME/.nvm/
  echo "nvm is not installed"
else
  function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
  end

  set -x NVM_DIR ~/.nvm
  nvm use default --silent
end

# Add deno for peek markdown preview
if not test -d $HOME/.deno
  echo "Deno not installed"
else
  fish_add_path /home/groot/.deno/bin
end
