{ pkgs, ... }:
{
  xmcl = pkgs.callPackage ./package.nix { };
}
