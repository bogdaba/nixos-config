{ inputs, config, pkgs, ... }:

{
environment.systemPackages = with pkgs; [
    (python311.withPackages(ps: with ps; [
      numpy
      toolz
      setuptools
      isort
      pipenv
      nose
      pytest
    ]))
  ];
}
# let
#   py3 = pkgs.python311Packages;
# in
# {
#   environment.systemPackages = with pkgs; [
#     python3
#     py3.numpy
#     py3.pandas
#     py3.isort
#     py3.nose
#     py3.pytest
#     py3.setuptools
#     py3.prompt-toolkit
#     emacsPackages.pipenv
#     pipenv
#   ];
# }
# let
  # my-python-packages = ps: with ps; [
  #   pandas
  #   requests
  #   beautifulsoup4  # other python packages
  # ];
# in

# {

  #nixpkgs = {
    # You can add overlays here
   # overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      #outputs.overlays.additions
      #outputs.overlays.modifications
      #outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    #  (final: prev: {
     #   obsidian-wayland = prev.obsidian.override {electron = final.electron_24;};
      #})
    #];
  #};

  # programs.direnv.enable = true;

  # environment.systemPackages = with pkgs; [
  #   (python3.withPackages my-python-packages)
  #   python3Full
  #   python312
  #   poetry
  #   #python312Packages.fastjsonschema
  #   #python312Packages.poetry-core
  #   #python311Packages.fastjsonschema
  #   #python311Packages.poetry-core

  # ];
# }
