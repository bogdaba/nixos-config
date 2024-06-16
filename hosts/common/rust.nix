{ inputs, config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rustup
    rust-analyzer
    cargo
    rustc
    rustfmt
    gcc
  ];
}
