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

    eza
    nushell
    zellij
    htop
    zathura
    qpdf
    pkgsUnstable.yt-dlp
    curl
    git
    wget
  ];

  programs = {
    neovim.enable = true;
    fish.enable = true;
    starship.enable = true;
  };
}
