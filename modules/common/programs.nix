{ pkgs, ... }:
{
   environment.systemPackages = with pkgs; [
     # add packages according to alphabet

     textadept
     just
     minio-client
     pwgen
  ];

  programs = {
    bash = {
      enable = true;
      promptInit = ''
        # Simple readable prompt (Crostini has poor defaults)
        export PS1="\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ "

        # Better defaults
        export EDITOR=nvim
        export PAGER=less

        # History improvements
        export HISTSIZE=10000
        export HISTFILESIZE=20000
        shopt -s histappend
        shopt -s checkwinsize

        # Direnv hook
        eval "$(direnv hook bash)"

        # fzf keybindings
        #[ -f ${pkgs.fzf}/share/fzf/key-bindings.bash ] && source ${pkgs.fzf}/share/fzf/key-bindings.bash
        #[ -f ${pkgs.fzf}/share/fzf/completion.bash ] && source ${pkgs.fzf}/share/fzf/completion.bash
       '';

      shellAliases = {
        grep = "rg";

        cd = "z";
        ".." = "cd ..";
        "..." = "cd ../..";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
  };


}
