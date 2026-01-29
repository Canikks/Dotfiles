{ pkgs, inputs, lib, ... }:
let
  # Define available terminals
  availableTerminals = {
    ghostty = import ./ghostty.nix { inherit pkgs inputs; };
    kitty = import ./kitty.nix { inherit pkgs inputs; };
    rio = import ./rio.nix { inherit pkgs inputs; };
    wezterm = import ./wezterm.nix { inherit pkgs inputs; };
  };

  # Function to enable selected terminals
  enableTerminals = terminals: lib.genAttrs terminals (name: availableTerminals.${name});
in
{
  # Enable selected terminals
  programs = enableTerminals [ "ghostty" "wezterm" ]; # Default selection
}