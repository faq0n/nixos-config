{ pkgs, config }: {

   programs.neovim.enable = true;
   programs.neovim.vimAlias = true;
   progams.neovim.defaultEditor = true;
   programs.neovim.configure = {
     customRC = ''
    " here your custom VimScript configuration goes!
  '';
  customLuaRC = ''
    -- here your custom Lua configuration goes!
  '';
  packages.myVimPackage = with pkgs.vimPlugins; {
    # loaded on launch
    start = [ fugitive 
	obsidian-nvim
    ];
    # manually loadable by calling `:packadd $plugin-name`
    opt = [ opencode-nvim ];
  };
  environment.systemPackages =  with pkgs; [ fzf ripgrep ];

}
