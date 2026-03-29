{
  description = "A Nix-flake-based development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self , nixpkgs ,... }: let
    # system should match the system you are running on
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      packages = with pkgs; [
        clang_tools
      ];

      buildInputs = with pkgs; [
        meson
        pkg-config
        cmake
        ninja
      ];

      shellHook = ''
        echo "Entered dev env"
        export SHELL=${pkgs.zsh}/bin/zsh
        exec ${pkgs.zsh}/bin/zsh
      '';
    };
  };
}
