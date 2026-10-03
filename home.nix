{ config, pkgs, ... }:

{
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
}
