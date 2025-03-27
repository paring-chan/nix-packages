{
  description = "Packages that does not exist on nixpkgs for my use";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      packages.${system} = (
        lib.attrsets.mergeAttrsList (
          import ./packages (
            {
              inherit pkgs;
            }
            // inputs
          )
        )
      );
    };
}
