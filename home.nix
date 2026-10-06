{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];
  
  home.username = "eren";
  home.homeDirectory = "/home/eren";

  home.stateVersion = "26.05";

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
    };
    
    widget = {
      privacy = {
        type = "privacy";
        hide_inactive = true;
        icon_spacing = 6;
      };
    };
  };
};
}
