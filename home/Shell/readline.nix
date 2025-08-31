{
  programs = {
    readline = {
      enable = true;
      includeSystemConfig = true;
      variables = {
        expand-tilde = true;
        completion-ignore-case = true;
        show-all-if-ambiguous = true;
        colored-stats = true;
        visible-stats = true;
        mark-symlinked-directories = true;
        colored-completion-prefix = true;
      };
    };
  };
}
