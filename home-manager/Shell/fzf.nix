{
  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--height 40%"
      "--border"
    ];

    fileWidgetCommand = ''fd --type file --type directory --hidden --exclude .git'';

    changeDirWidgetCommand = "fd --type directory --hidden --exclude .git";

    # Default command that is executed for fzf - $FZF_DEFAULT_COMMAND
    defaultCommand = "fd --type file --hidden --exclude .git";
  };
}
