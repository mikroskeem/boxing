{
  description = "Box86 & Box64";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      supportedSystems = [
        "aarch64-linux"
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages.box86 = pkgs.callPackage ./box86.nix {
          inherit (pkgs.pkgsCross.armv7l-hf-multiplatform) stdenv;
        };

        packages.box64 = pkgs.callPackage ./box64.nix { };
      });
}
