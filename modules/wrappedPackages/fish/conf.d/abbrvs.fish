# Nix Ecosystem
abbr -a npu nix-prefetch-url
abbr -a npg nix-prefetch-github
abbr -a nho "nh os switch"
abbr -a nhf "nix hash file"
abbr -a nhp "nix hash path"

# Eza "L-iases"
set -l eza_base "eza --icons --git --git-ignore"

abbr -a l "eza --icons"
abbr -a ll "$eza_base -l --group-directories-first --header"
abbr -a la "$eza_base -la --group-directories-first --header"
abbr -a lt "$eza_base --tree"
abbr -a lt2 "$eza_base --tree --level=2"
abbr -a lg "$eza_base -l"
abbr -a ls "$eza_base -lh"
abbr -a lx "$eza_base -la --git-repos --group-directories-first --header --time-style=long-iso"
