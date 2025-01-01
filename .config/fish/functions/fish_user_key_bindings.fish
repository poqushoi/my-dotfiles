function fish_user_key_bindings
  if not type -q fzf
    fzf --fish | source
  end
end
