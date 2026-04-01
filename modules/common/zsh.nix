{
  programs.zsh = {
    enable = true;
    enableLsColors = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
  
  programs.zsh.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
  };


