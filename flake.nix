{
  description = "snowflake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      overlays = [
        inputs.neovim-nightly.overlays.default
      ];
      nixosModules = import ./modules;
      homeManagerModules = import ./modules/home;
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/laptop

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kbeerta = {
              imports = [
                outputs.homeManagerModules.snowflake
              ];

              system.snowflake.home = {
                enable = true;
                user = "kbeerta";
              };
            };
            home-manager.extraSpecialArgs = { inherit inputs outputs; };
          }
        ];
      };
    };
}
