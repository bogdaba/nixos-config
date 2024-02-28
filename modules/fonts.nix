{ config, pkgs, ... }:
  
{
  fonts.packages = with pkgs; [
    nerdfonts
    mplus-outline-fonts.githubRelease
    noto-fonts
    iosevka
    fira
    fira-code
  ];
  fonts.fontconfig.defaultFonts.sansSerif = [
    "M PLUS 2"
  ];
}