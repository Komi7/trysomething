{
  description = "NixOS Flake configuration for ThinkPad T470s with Hyprland (Unstable)";

  nixConfig = {
    extra-substituters = [
      "https://komi7.cachix.org"
    ];

    extra-trusted-public-keys = [
      "komi7.cachix.org-1:NsBPk8UBIBaDuax0VWe6zfYwHoBI1/PJ40EBzWD895I="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, stylix, ... }:
    let
      system = "x86_64-linux";
      username = "shousuke";
      hostname = "komi";

      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit username hostname;
        };

        modules = [
          stylix.nixosModules.stylix
          nixos-hardware.nixosModules.lenovo-thinkpad-t470s

          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.${username} = import ./home/home.nix;

            home-manager.extraSpecialArgs = {
              inherit username;
            };
          }
        ];
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git
          nixpkgs-fmt
        ];
      };
    };
}