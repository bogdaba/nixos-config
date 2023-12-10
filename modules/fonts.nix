{ config, pkgs, ... }:
  
{
  fonts.packages = with pkgs; [
    nerdfonts
    mplus-outline-fonts.githubRelease
    noto-fonts
    iosevka
  ];
  fonts.fontconfig.defaultFonts.sansSerif = [
    "M PLUS 2"
  ];
}