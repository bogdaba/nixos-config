{ inputs, config, pkgs, ... }:

let
  my-python-packages = ps: with ps; [
    pandas
    requests
    # other python packages
  ];
in

{
  imports = [
    ./vscode.nix
  ];

environment.systemPackages = with pkgs; [
    (python3.withPackages my-python-packages)
    python3
    poetry
    
  ];
}