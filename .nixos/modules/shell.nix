{ lib, config, pkgs, ... }:

{
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    environment.systemPackages = with pkgs; [
        zinit # zsh plugin manager
        jq # command line json processor
        fzf # fuzzy finder
        zoxide # better cd
    ];

    environment.variables = {
        ZINIT_HOME = "${pkgs.zinit}/share/zinit";
    };

    programs.zsh.interactiveShellInit = ''
      # Keep zinit's self-completion symlink pointed at the current nix store path.
      if [[ -n "$ZINIT_HOME" && -f "$ZINIT_HOME/_zinit" ]]; then
        _zinit_comp="$HOME/.local/share/zinit/completions/_zinit"
        if [[ "$(readlink -f "$_zinit_comp" 2>/dev/null)" != "$ZINIT_HOME/_zinit" ]]; then
          mkdir -p "''${_zinit_comp:h}"
          ln -sfn "$ZINIT_HOME/_zinit" "$_zinit_comp"
        fi
        unset _zinit_comp
      fi
    '';
}
