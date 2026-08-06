# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

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
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."eren" = {
    isNormalUser = true;
    description = "Eren Gülüm";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Bluetooth
  hardware.bluetooth = {
	enable = true;
	powerOnBoot = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.firewall.checkReversePath = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
	kitty
	firefox
	nautilus
	discord
	git
	btop
	pkgs.starship
	pkgs.zed-editor
	wireguard-tools
	proton-vpn
	iw
	waybar
	yazi
	rustup # After installation run "rustup install stable"
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default	
  ];
 
  
  services.system76-scheduler.enable = true;

  # Desktop Environments
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  
  services.displayManager.sddm = {
	enable = false;
	wayland.enable = false;
  };

  services.desktopManager.cosmic.enable = true;

  services.displayManager.cosmic-greeter.enable = false;

  services.power-profiles-daemon = {
	enable = true;
  };

  services.upower = {
	enable = true;
  };

  services.flatpak = {
    enable = true;

    packages = [
	"org.vinegarhq.Sober"
    ];
  };
  
  programs.steam = {
    enable = true;
  };

  programs.zoxide = {
	enable = true;
  };

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };

  programs.noctalia-greeter = {
    enable = true;
    # Optional: extra flags after `--` on noctalia-greeter-session
    greeter-args = "";
    # Full declarative greeter.toml (overwritten each activation). See examples/greeter.toml.
    settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
    };
  };

  services.hydration-notifier = {
    enable = true;

    interval = 900;
    duration = 10;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      
      starship init fish | source
    '';
  };

  users.extraUsers.eren = {
	shell = pkgs.fish;
  };

programs.starship = {
  enable = true;

  settings = {
    "$schema" = "https://starship.rs/config-schema.json";

    continuation_prompt = "[.](bright-black) ";

    character = {
      success_symbol = "[>](bold green)";
      error_symbol = "[x](bold red)";
      vimcmd_symbol = "[<](bold green)";
      vimcmd_visual_symbol = "[<](bold yellow)";
      vimcmd_replace_symbol = "[<](bold purple)";
      vimcmd_replace_one_symbol = "[<](bold purple)";
    };

    git_commit = {
      tag_symbol = " tag ";
    };

    git_status = {
      ahead = ">";
      behind = "<";
      diverged = "<>";
      renamed = "r";
      deleted = "x";
    };

    aws.symbol = "aws ";
    azure.symbol = "az ";

    battery = {
      full_symbol = "full ";
      charging_symbol = "charging ";
      discharging_symbol = "discharging ";
      unknown_symbol = "unknown ";
      empty_symbol = "empty ";
    };

    buf.symbol = "buf ";
    bun.symbol = "bun ";
    c.symbol = "C ";
    cpp.symbol = "C++ ";
    cobol.symbol = "cobol ";
    conda.symbol = "conda ";
    container.symbol = "container ";
    crystal.symbol = "cr ";
    cmake.symbol = "cmake ";
    daml.symbol = "daml ";
    dart.symbol = "dart ";
    deno.symbol = "deno ";

    dotnet = {
      format = "via [$symbol($version )(target $tfm )]($style)";
      symbol = ".NET ";
    };

    directory.read_only = " ro";

    docker_context.symbol = "docker ";
    elixir.symbol = "exs ";
    elm.symbol = "elm ";
    erlang.symbol = "erl ";
    fennel.symbol = "fnl ";
    fortran.symbol = "fortran ";

    fossil_branch = {
      symbol = "fossil ";
      truncation_symbol = "...";
    };

    gcloud.symbol = "gcp ";

    git_branch = {
      symbol = "git ";
      truncation_symbol = "...";
    };

    gleam.symbol = "gleam ";
    golang.symbol = "go ";
    gradle.symbol = "gradle ";
    guix_shell.symbol = "guix ";
    haskell.symbol = "haskell ";
    haxe.symbol = "hx ";
    helm.symbol = "helm ";

    hg_branch = {
      symbol = "hg ";
      truncation_symbol = "...";
    };

    hostname.ssh_symbol = "ssh ";

    java.symbol = "java ";
    jobs.symbol = "*";
    julia.symbol = "jl ";
    kotlin.symbol = "kt ";
    kubernetes.symbol = "kubernetes ";
    lua.symbol = "lua ";
    maven.symbol = "maven ";
    nodejs.symbol = "nodejs ";
    memory_usage.symbol = "memory ";

    meson = {
      symbol = "meson ";
      truncation_symbol = "...";
    };

    mojo.symbol = "mojo ";
    nats.symbol = "nats ";
    netns.symbol = "netns ";
    nim.symbol = "nim ";
    nix_shell.symbol = "nix ";
    ocaml.symbol = "ml ";
    odin.symbol = "odin ";
    opa.symbol = "opa ";
    openstack.symbol = "openstack ";

    os.symbols = {
      AIX = "aix ";
      Alpaquita = "alq ";
      AlmaLinux = "alma ";
      Alpine = "alp ";
      ALTLinux = "alt ";
      Amazon = "amz ";
      Android = "andr ";
      AOSC = "aosc ";
      Arch = "rch ";
      Artix = "atx ";
      Bluefin = "blfn ";
      CachyOS = "cach ";
      CentOS = "cent ";
      Debian = "deb ";
      DragonFly = "dfbsd ";
      Elementary = "elem ";
      Emscripten = "emsc ";
      EndeavourOS = "ndev ";
      Fedora = "fed ";
      FreeBSD = "fbsd ";
      Garuda = "garu ";
      Gentoo = "gent ";
      HardenedBSD = "hbsd ";
      Illumos = "lum ";
      Ios = "ios ";
      InstantOS = "inst ";
      Kali = "kali ";
      Linux = "lnx ";
      Mabox = "mbox ";
      Macos = "mac ";
      Manjaro = "mjo ";
      Mariner = "mrn ";
      MidnightBSD = "mid ";
      Mint = "mint ";
      NetBSD = "nbsd ";
      NixOS = "nix ";
      Nobara = "nbra ";
      OpenBSD = "obsd ";
      OpenCloudOS = "ocos ";
      openEuler = "oeul ";
      openSUSE = "osuse ";
      OracleLinux = "orac ";
      PikaOS = "pika ";
      Pop = "pop ";
      Raspbian = "rasp ";
      Redhat = "rhl ";
      RedHatEnterprise = "rhel ";
      RockyLinux = "rky ";
      Redox = "redox ";
      Solus = "sol ";
      SUSE = "suse ";
      Ubuntu = "ubnt ";
      Ultramarine = "ultm ";
      Unknown = "unk ";
      Uos = "uos ";
      Void = "void ";
      Windows = "win ";
      Zorin = "zorn ";
    };

    package.symbol = "pkg ";
    perl.symbol = "pl ";
    php.symbol = "php ";

    pijul_channel = {
      symbol = "pijul ";
      truncation_symbol = "...";
    };
    
    time = {
      format = "[ $time ]($style)";
      style = "bold yellow bg:0x33658A";
      use_12hr = false;
      disabled = false;
      utc_time_offset = "local";
      time_format = "%T";
    };

    pixi.symbol = "pixi ";
    pulumi.symbol = "pulumi ";
    purescript.symbol = "purs ";
    python.symbol = "py ";
    quarto.symbol = "quarto ";
    raku.symbol = "raku ";
    red.symbol = "red ";
    rlang.symbol = "r ";
    ruby.symbol = "rb ";
    rust.symbol = "rs ";
    scala.symbol = "scala ";
    shlvl.symbol = "shlvl ";
    spack.symbol = "spack ";
    solidity.symbol = "solidity ";

    status = {
      symbol = "[x](bold red) ";
      not_executable_symbol = "noexec";
      not_found_symbol = "notfound";
      sigint_symbol = "sigint";
      signal_symbol = "sig";
    };

    sudo.symbol = "sudo ";
    swift.symbol = "swift ";
    typst.symbol = "typst ";
    vagrant.symbol = "vagrant ";
    terraform.symbol = "terraform ";
    xmake.symbol = "xmake ";
    zig.symbol = "zig ";
  };
};

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
  system.stateVersion = "26.05"; # Did you read the comment?

}
