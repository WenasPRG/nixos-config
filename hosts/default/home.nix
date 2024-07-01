{ config, pkgs, inputs, ... }:

{
  home.username = "xyfr";
  home.homeDirectory = "/home/xyfr";
  home.stateVersion = "24.05";

  home.packages = [
    # Add any packages you need here
  ];

  home.file = {
    # Add any dotfiles you need here
  };

  home.sessionVariables = {
    # Add any session variables you need here
  };

  programs.home-manager.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";  # Set the modifier key to "Mod4" (usually the Super/Windows key)
      terminal = "kitty";  # Use kitty as the default terminal
      startup = [
        { command = "firefox"; }  # Launch Firefox on start
      ];
    };
  };
}
