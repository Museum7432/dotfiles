{ config, pkgs, ... }:
{
  programs.fzf.enable = true;
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";

    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # HISTFILE / HISTSIZE / SAVEHIST
    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.histfile";
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

      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      bindkey "^[[1;5C" forward-word

      source <(${pkgs.fzf}/bin/fzf --zsh)
    '';
  };
}
