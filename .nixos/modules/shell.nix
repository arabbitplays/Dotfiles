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
}