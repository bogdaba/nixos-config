{ inputs, config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # wezterm
    wezterm

    # yazi and dependencies
    yazi
    file
    ffmpegthumbnailer
    unar
    jq
    poppler
    fd
    ripgrep
    fzf
    zoxide
    xclip
    wl-clipboard
    ripdrag

    eza
    nushell
    zellij
    htop
    zathura
    qpdf
    unstable.yt-dlp
    curl
    git
    wget
    fastfetch
  ];

  programs = {
    neovim.enable = true;
    fish.enable = true;
    starship.enable = true;
  };
}
