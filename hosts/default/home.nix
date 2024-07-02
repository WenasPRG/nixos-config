{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # Adjust according to your Home Manager version

  security.polkit.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4"; # Use the Super key as the modifier
      terminal = "kitty"; # Set kitty as the default terminal
      startup = [
        { command = "firefox"; } # Launch Firefox on start
      ];
    };
  };

  # Additional Sway configuration
  xdg.portal.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;

  # Optional: setting brightness and volume control keys
  users.users.xyfr.extraGroups = [ "video" ];
  programs.light.enable = true;

  sway.config = ''
    bindsym XF86MonBrightnessDown exec light -U 10
    bindsym XF86MonBrightnessUp exec light -A 10
    bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
    bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
    bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
  '';
}
