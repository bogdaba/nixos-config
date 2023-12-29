{ inputs, config, pkgs, ... }:

let
  my-python-packages = ps: with ps; [
    pandas
    requests
    # other python packages
  ];
in

{
  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    (python3.withPackages my-python-packages)
    python3
    poetry
    
  ];
}