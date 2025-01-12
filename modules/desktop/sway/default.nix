{ config, lib, pkgs, ... }:
{
  imports = [ ../../programs/wayland/waybar/sway_waybar.nix ];

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs;[
        swaybg
        swayidle
        swaylock-effects
        pamixer
      ];
    };
  };

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };

}
