{ inputs, config, lib, pkgs, ... }:

{
  services.emacs = {
    enable = true;
    # package = pkgs.emacs29;
  };
  environment.systemPackages = with pkgs; [
    emacsPackages.vterm
    ripgrep
    fd
    coreutils
  ];
}
