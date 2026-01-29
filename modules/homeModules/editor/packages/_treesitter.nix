{ pkgs }:
let
  treeSitterGrammars =
    let
      treesitter-norg = pkgs.tree-sitter-grammars.tree-sitter-norg;
      treesitter-norg-meta = pkgs.tree-sitter-grammars.tree-sitter-norg-meta;
    in
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (
      p:
      with p;
      [
        bash
        comment
        fish
        ini # for ini filetypes
        kdl
        luadoc

        # for markdown
        markdown
        markdown-inline

        query

        html
        latex

        qmljs
        gitignore
        git_rebase
        css
        json
        toml
        yaml
        muttrc
        nix
        c
        cpp
        lua
        regex
        ron
        zathurarc
      ]
      ++ [
        treesitter-norg
        treesitter-norg-meta
      ]
    ));

in
[ treeSitterGrammars ]
