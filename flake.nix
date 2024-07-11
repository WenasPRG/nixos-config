{
  description = "nixos config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, ... } @ inputs: 
    let 
      system = "x86_64-linux"; 
      pkgs = nixpkgs.legacyPackages.${system}; 
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in 
    { 
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        }; 
    };
}
