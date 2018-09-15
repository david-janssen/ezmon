let
  # rev      = "7673593c85623fa7065ea7ef56bcd0a50f2fbea1";
  # sha256   = "0fc8jgiypb5jima4i719n61qhig684hxq3rk9kyda4zvsr5lh3f0";
  # compiler = "ghc";

  # util     = import ~/proj/nix-util;

  # Import libraries
  nixpkgs = import <nixpkgs> {};

  # Define easy shortcuts
  lib     = nixpkgs.pkgs.haskell.lib;
  hpkgs   = nixpkgs.pkgs.haskell.packages.ghc843;

  # Import the derivation for the project
  proj    = hpkgs.callPackage (import ./ezmon.nix) {};

  # Define the tools to be inserted
  devtools = with nixpkgs.haskellPackages;
    [ cabal2nix cabal-install ghcid hoogle        # devtools
      htags apply-refact stylish-haskell ];      # emacs integration
in
  # Return a new derivation with the inserted tools
  lib.overrideCabal proj (old: { buildTools = devtools ++ (old.buildTools or []); })

  # util.hask-proj {
  #   proj-path = ./ezmon.nix;
  #   inherit rev sha256 compiler;
  # }
