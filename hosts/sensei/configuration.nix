{ config, pkgs, ... }:

{
  # Sensei is de persoonlijke pc van David W. Breuer.

  # Imports
  imports = [
    ./hardware-configuration.nix
    ../../modules/firefox.nix
  ];

  # Nix
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Netwerk
  networking.hostName = "sensei";
  networking.networkmanager.enable = true;

  # Lokalisatie
  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "nl_NL.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Desktop
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "euro";
  };

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printen
  services.printing.enable = true;

  # Gebruikers
  users.users."david" = {
    isNormalUser = true;
    description = "David W. Breuer";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0UTksg6tcUn/iQWcRt4piukTnUIAoPmh9Qd75cnE0a"
    ];
    packages = with pkgs; [
      # thunderbird
    ];
  };

  # Systeempakketten
  environment.systemPackages = [
    pkgs.fastfetch
    pkgs.git
    pkgs.zed-editor
    pkgs.nil
    pkgs.nixd
    pkgs.nixfmt
  ];

  # Services
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    openFirewall = true;
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  # Niet wijzigen zonder migratie; zie `man configuration.nix`.
  system.stateVersion = "26.05";
}
