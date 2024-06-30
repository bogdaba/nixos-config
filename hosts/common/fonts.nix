{ config, pkgs, ... }:
  
{
  fonts.packages = with pkgs; [
    nerdfonts
    mplus-outline-fonts.githubRelease
    noto-fonts
    iosevka
    fira
    fira-code
    ibm-plex
    open-sans
    source-serif-pro
    source-sans-pro
    fg-virgil
  ];
  fonts.fontconfig.defaultFonts.sansSerif = [
    "M PLUS 2"
  ];
}
