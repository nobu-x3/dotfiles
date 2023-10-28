# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.lightdm.enable = true;
    desktopManager = {
      xfce.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
	i3status
	i3lock
	i3blocks
      ];
    };
  };
  services.picom = {
    enable = true;
    fade = true;
    inactiveOpacity = 0.9;
    shadow = true;
    fadeDelta = 4;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
#  services.pipewire = {
#    enable = true;
#    alsa.enable = true;
#    alsa.support32Bit = true;
#    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
#  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "armcord-3.2.4"
      "electron-24.8.6"
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nobu = {
    isNormalUser = true;
    description = "Dominik Kurasbediani";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      thunderbird
      armcord
      obs-studio
      obsidian
      slack
      spotify
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    jq
    wget
    neovim
    vimPlugins.packer-nvim
    tmux
    ripgrep
    fd
    oh-my-zsh
    alacritty
    xclip
    polybar
    i3
    rofi
    gtk3
    dunst
    feh
    python311
    feh
    cmake
    nerdfonts
    llvmPackages_16.libllvm
    llvmPackages_16.libcxx
    llvmPackages_16.bintools
    llvmPackages_16.libcxxClang
  ];

programs.zsh = {
  enable = true;
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
  };
  histSize = 10000;
  histFile = "~/zsh/history";
};
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = ["git" "history" "man" "tmux"];
    theme = "amuse";
  };


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  hardware.opengl.extraPackages = [
    pkgs.mesa
    pkgs.amdvlk
  ];
  hardware.opengl.driSupport = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    font-awesome
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
