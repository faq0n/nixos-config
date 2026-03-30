{ pkgs, config }: {

   programs.neovim.enable = true;
   programs.neovim.vimAlias = true;
   progams.neovim.defaultEditor = true;

   environment.systemPackages =  with pkgs; [ fzf ripgrep ];

}
