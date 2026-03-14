function npgj
    if test (count $argv) -ne 2
        echo "Usage: npgj <owner> <repo>"
        return 1
    end

    nix-prefetch-github $argv[1] $argv[2] | nix eval --impure --expr "builtins.fromJSON (builtins.readFile /dev/stdin)"
end
