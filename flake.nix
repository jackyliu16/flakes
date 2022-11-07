{
  description = "My Personal NixOS Configuration";

  inputs =
    # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages

      home-manager = {
        # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {
        url = "github:nix-community/NUR"; # NUR Packages
      };
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, hyprland, ... }: # Function that tells my flake which to use and what do what to do with the dependencies.
    let
      # Variables that can be used in the config files.
      user = "ruixi";
    in
    # Use above variables in ...
    {
      nixosConfigurations = (
        # NixOS configurations
        import ./hosts {
          # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user hyprland; # Also inherit home-manager so it does not need to be defined here.
        }
      );
    };
}
