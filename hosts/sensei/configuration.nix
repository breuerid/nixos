{ config, pkgs, ... }:

{
  # Sensei is de persoonlijke pc van David W. Breuer.

  # Imports
  imports = [
    ./hardware-configuration.nix
    ../../modules/firefox.nix
  ];

  # Nix
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nixpkgs.config.allowUnfree = true;

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Netwerk
  networking.hostName = "sensei";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

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

  environment.etc."xdg/autostart/sensei-xfce-desktop.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Sensei XFCE desktopinstellingen
    Comment=Pas de vaste XFCE-desktopinstellingen toe
    Exec=/etc/xdg/sensei-xfce-desktop
    OnlyShowIn=XFCE;
    X-GNOME-Autostart-enabled=true
  '';

  environment.etc."xdg/sensei-xfce-desktop" = {
    mode = "0755";
    text = ''
      #!${pkgs.runtimeShell}
      ${pkgs.xfconf}/bin/xfconf-query --channel xfwm4 --property /general/workspace_count --create --type int --set 1
      ${pkgs.xfconf}/bin/xfconf-query --channel xfce4-panel --property /panels/panel-1/position --create --type string --set "p=11;x=0;y=0"
      ${pkgs.xfconf}/bin/xfconf-query --channel xfce4-panel --property /panels/panel-1/length --create --type uint --set 100
      ${pkgs.xfconf}/bin/xfconf-query --channel xfce4-panel --property /panels/panel-1/position-locked --create --type bool --set true
      ${pkgs.xfce4-panel}/bin/xfce4-panel --restart || true
    '';
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

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

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
    packages = with pkgs; [ ];
  };

  # Systeempakketten
  environment.systemPackages = [
    pkgs.fastfetch
    pkgs.git
    pkgs.zed-editor
    pkgs.thunderbird
    pkgs.onlyoffice-desktopeditors
    pkgs.nil
    pkgs.nixd
    pkgs.nixfmt
  ];

  # Git
  programs.git = {
    enable = true;
    config = {
      user.name = "David W. Breuer";
      user.email = "184601608+breuerid@users.noreply.github.com";
      init.defaultBranch = "main";
    };
  };

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
