{ pkgs, ... }:
{
  rquickshare = pkgs.callPackage ./package.nix { };
}
