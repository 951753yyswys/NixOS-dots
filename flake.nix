{
  description = "NixOS flake-configuration with Noctalia";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  }; 

  outputs = inputs@{ self, winapps, nixpkgs, home-manager, ... }: {
    packages.x86_64-linux = {
      space-grotesk = import ./font/space-grotesk.nix {
        inherit (nixpkgs.legacyPackages.x86_64-linux) lib stdenv fetchzip;
      };
      nody-greeter = import ./pkgs/nody-greeter {
        inherit (nixpkgs.legacyPackages.x86_64-linux) lib stdenv dpkg fetchurl;
      };
      lightdm-webkit2-theme-glorious = import ./pkgs/lightdm-webkit2-theme-glorious {
        inherit (nixpkgs.legacyPackages.x86_64-linux) lib stdenv fetchzip;
      };
    };

    nixosConfigurations.Qaaxaap = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit self inputs winapps; };
      modules = [
        ./configuration.nix
        ./noctalia.nix
        ./chinese.nix
        ./niri.nix
        ./zsh.nix
        ./home.nix
        ./network.nix
        ./winapps.nix
        ./nh.nix
        ./lightdm.nix
        home-manager.nixosModules.home-manager
      ];
    }; 
  };
}
