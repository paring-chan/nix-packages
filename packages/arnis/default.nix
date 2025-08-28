{ pkgs, ... }:
{
  arnis = pkgs.callPackage ./package.nix { };
}
