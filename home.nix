{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];
  
  home.username = "eren";
  home.homeDirectory = "/home/eren";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    firefox
    nautilus
    discord
    git
    btop
    zed-editor
    proton-vpn
    yazi
    rustup # After installation run "rustup install stable"
    heroic
    godotPackages_4_7.godot
    jetbrains.idea
    bitwarden-desktop
    obs-studio
    gimp
    onlyoffice-desktopeditors
    mediawriter
    mission-center
    vlc
    loupe
    qalculate-gtk
    _7zz
    file-roller
    mpvpaper

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  
  ];

  home.file."Pictures/Screenshots/.keep".text = "";

  programs.kitty = {
    enable = true;

    settings = {
      background_opacity = "0.5";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
    };
  };

  programs.noctalia = {
  enable = true;

  settings = {
    theme = {
      mode = "dark";
    };

    bar = {
      default = {
        position = "top";
      };
    };

    shell = {
      launch_apps_as_systemd_services = true;
      screenshot = {
        save_to_file = true;
	directory = "~/Pictures/Screenshots";
        copy_to_clipboard = true;
        freeze_screen = true;
        show_cursor = false;
        annotate = false;
      };
    };
    
    widget = {
      privacy = {
        type = "privacy";
        hide_inactive = true;
        icon_spacing = 6;
      };
    };

    plugins = {
      enabled = [
        "noctalia/mpvpaper"
        "theblackdon/theme-switcher"
      ];

      auto_update = "all";
    };

    plugin_settings = {
      "noctalia/mpvpaper" = {
      video_directory = "${config.home.homeDirectory}/Videos/wallpapers";
      mute = true;
      hardware_decode = true;
      auto_pause = "full";
      mpv_options = "";
      run_as_systemd = false;
    };  
  };
};
};
}
