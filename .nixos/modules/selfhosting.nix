{ lib, config, pkgs, ... }:

let
    selfhost_dir = ./selfhosting;
in
{
    imports =
    [ 
        "${selfhost_dir}/postgres.nix"    
        "${selfhost_dir}/docker.nix"    
        "${selfhost_dir}/minecraft.nix"    
    ];
}