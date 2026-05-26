{ config, lib, pkgs, ... }: {
  # --- Users ---
  users.users.utkar = {
    linger = true;
    isNormalUser = true;
    name = "utkar";
    autoSubUidGidRange = true;
    description = "utkar";
    extraGroups = [
      "sddm"
      "btrfs"
      "nix"
      "hermes"
      "searx"
      "input"
      "docker"
      "pihole"
      "aria2"
      "internet"
      "greeter"
      "pipewire"
      "libvirtd"
      "qemu-libvirtd"
      "aria2"
      "flatpak"
      "networkmanager"
      "wheel"
      "podman"
      "kvm"
      "video"
      "audio"
      "power"
    ];
    packages = with pkgs; [
      hello
    ];
    shell = lib.mkForce pkgs.zsh;
  };
}