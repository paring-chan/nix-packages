{ pkgs, ... }:
{
  proxmox-offline-mirror = pkgs.callPackage ./package.nix { };
}
