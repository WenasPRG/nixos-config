{ config, pkgs, inputs, home-manager, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # Adjust according to your Home Manager version

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4"; # Use the Super key as the modifier
      terminal = "kitty"; # Set kitty as the default terminal
      startup = [
        { command = "firefox"; } # Launch Firefox on start
      ];
    };
  };
}
