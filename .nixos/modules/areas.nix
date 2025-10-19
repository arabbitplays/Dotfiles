{ lib, config, pkgs, ... }:

let
    area_dir = ./areas;
in
{
    imports =
    [ 
        "${area_dir}/art.nix"    
        "${area_dir}/music.nix"
    ];
}