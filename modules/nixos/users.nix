{
  lib,
  pkgs,
  ...
}: {
  # --- Users ---
  users.mutableUsers = false;
  users.users.utkar = {
    linger = true;
    isNormalUser = true;
    name = "utkar";
    autoSubUidGidRange = true;
    description = "utkar";
    hashedPassword = "$y$j9T$5tJVCvNQ/W6zacrpox1WX/$6tUI9ywJSFw1W9PGBpr3Ex3K44AOICwpfRrobVRhaF6";
    extraGroups = [
      "sddm"
      "btrfs"
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
      "flatpak"
      "networkmanager"
      "wheel"
      "podman"
      "kvm"
      "video"
      "audio"
      "power"
      "minecraft"
      "qbittorrent"
    ];
    packages = with pkgs; [
      hello
    ];
    shell = lib.mkForce pkgs.zsh;
  };
}
