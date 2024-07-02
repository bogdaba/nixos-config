# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  voicevox = pkgs.callPackage ./voicevox { };
  voicevox-core = pkgs.callPackage ./voicevox-core { };
  voicevox-engine = pkgs.callPackage ./voicevox-engine { };
}
