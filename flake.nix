{
  description = "nixos config";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; 
    
    home-manager = { 
      url = "github:nix-community/home-manager"; 
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      system = "x86_64-1inux"; 
      pkgs = nixpkgs.legacyPackages.${system}; 
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem { 
          specialArgs = {inherit inputs;}; 
          modules = [ 
            ./nixos-config/hosts/default/configuration.nix 
            inputs.home-manager.nixosModules.default
          ];
        };
     };
}
