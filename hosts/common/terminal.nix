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
    rg
    fzf
    zoxide
    xclip
    wl-clipboard
    ripgrep

    eza
    nushell
    zellij
    nvim
  ];
}
