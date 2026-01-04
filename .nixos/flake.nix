{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";    
    desktop-manager.url = "github:arabbitplays/Desktop-Manager";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./systems/laptop_config.nix
        # inputs.home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./systems/desktop_config.nix
        # inputs.home-manager.nixosModules.default
      ];
    };
  };
}
