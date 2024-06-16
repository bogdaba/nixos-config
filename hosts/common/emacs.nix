{ inputs, config, lib, pkgs, ... }:

{
  services.emacs = {
    enable = true;
    # package = pkgs.emacs29;
  };
  environment.systemPackages = with pkgs; [
    emacsPackages.vterm
    cmake   # vterm so doctor doesn't complain
    gnumake # vterm so doctor doesn't complain
    emacsPackages.graphviz-dot-mode
    graphviz # so doom doctor doesn't complain
    emacsPackages.pipenv
    pipenv
    ripgrep
    fd
    coreutils
    cmigemo # jap input
    nixfmt-rfc-style # nix
    ruby
    shellcheck
  ];
}
