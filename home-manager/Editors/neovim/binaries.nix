{ pkgs, ... }:
let
  binaries = with pkgs; [ wl-clipboard 
  nixd # for lsp server 
  
  stylua # for formatting lua code
  lua-language-server # for lua lsp
  ];
in
binaries
