{
  description = "{{PROJECT_NAME}}";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in
  {
    devShells = forAllSystems (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        default = pkgs.mkShell {
          packages = with pkgs; [
            (python3.withPackages (python-pkgs: with python-pkgs; [
              # add Python packages here
            ]))
          ];

          buildInputs = with pkgs; [];

          shellHook = ''
            export SHELL=${pkgs.zsh}/bin/zsh
            echo "Entered {{PROJECT_NAME}} dev environment for ${system}"
            exec ${pkgs.zsh}/bin/zsh
          '';
        };
      }
    );
  };
}
