{ pkgs, ... }:
{
  neohtop = pkgs.callPackage ./package.nix { };
}
