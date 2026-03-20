{ pkgs, ... }:
let
  extraBinaries = with pkgs; [
    # Support for dictionaries
    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
      ]
    ))

    # Common utilities
    fd
    ripgrep
    ripgrep-all

    bash-language-server # bash-language server
    clang-tools # For C development format
    emacs-lsp-booster # Dependency for eglot-booster
    ffmpegthumbnailer # For ready-player
    ffmpeg-full # For ready-player
    imagemagick # For rendering images inside org
    mediainfo # For viewing mediainfo inside emacs
    mpg123 # For music decoding in ready player
    nixd # nix server
    nixfmt # for formatting nix

    # TODO: write an issue for using mupdf's mutool for pdf preview in dirvish.
    # poppler # For viewing pdf metadata
    poppler-utils # for pdftoppm utility

    # Not needed when using emacs-reader package
    # poppler # For pdf reading

    shfmt # for formatting bash
    mupdf # for reader-mode (using mupdf)

    unzip # For Unzipping zip files
    vips # Has vlpsthumbnail for image preview in dirvish
    _7zz-rar # for archive files preview
  ];
in
extraBinaries
