{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.gcc
              pkgs.gnumake
              pkgs.tree-sitter
              pkgs.ripgrep
              pkgs.fd
              pkgs.lua-language-server
            ];
          };
        };
      });
}
