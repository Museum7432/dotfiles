{ config, pkgs, ... }:
{

  # zsh
  programs.fzf.enable = true;
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";

    enableCompletion = true;

    completionInit = ''
      autoload -Uz compinit
      compinit -d "${config.home.homeDirectory}/.shell/zcompdump"
    '';


    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # HISTFILE / HISTSIZE / SAVEHIST
    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.shell/zsh_history";
      extended = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      findNoDups = true;
      saveNoDups = true;
    };

    shellAliases = {
      ls = "${pkgs.coreutils}/bin/ls -hF --color=auto";
      grep = "${pkgs.gnugrep}/bin/grep --color=auto";
      diff = "${pkgs.colordiff}/bin/colordiff";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -I";
      # shell_pixi = "pixi shell";
    };

    setOptions = [
      "HIST_BEEP"
    ];

    initContent = ''
      PROMPT='%F{blue}%~ %(?.%F{green}.%F{red})❯%b%f '

      export PATH="$PATH:$HOME/.local/bin"
      export EDITOR=vim

      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      bindkey "^[[1;5C" forward-word

      source <(${pkgs.fzf}/bin/fzf --zsh)

    '';
  };

  # BASH
  programs.bash = {
    enable = true;
    enableCompletion = true;

    historyFile = "${config.home.homeDirectory}/.shell/bash_history";
    historySize = 10000;
    historyFileSize = 10000;

    historyControl = [ "ignoredups" "ignorespace" "erasedups" ];
    historyIgnore = [ "ls" "cd" "exit" "clear" ];

    shellOptions = [
      "histappend"
      "cmdhist"
      "checkwinsize"
      "extglob"
      "globstar"
      "checkjobs"
      "autocd"
    ];

    shellAliases = {
      ls = "${pkgs.coreutils}/bin/ls -hF --color=auto";
      grep = "${pkgs.gnugrep}/bin/grep --color=auto";
      diff = "${pkgs.colordiff}/bin/colordiff";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -I";
    };

    initExtra = ''
      # %F{blue}%~ %(?.%F{green}.%F{red})❯%f
      PS1='\[\e[34m\]\w \[$(if [ $? = 0 ]; then printf "\e[32m"; else printf "\e[31m"; fi)\]❯\[\e[0m\] '

      export PATH="$PATH:$HOME/.local/bin"
      export EDITOR=vim
    '';
  };


  # git
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
  # make git place the config into .shell for persistence
  home.sessionVariables.GIT_CONFIG_GLOBAL = "${config.home.homeDirectory}/.shell/gitconfig";


  home.persistence."/persist/shell" = {
    directories = [
      ".shell"
    ];
  };

}
