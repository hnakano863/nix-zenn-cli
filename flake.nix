{
  description = "zenn cli for nix user.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/21.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: let
    inherit (flake-utils.lib) eachDefaultSystem;
  in {

    overlay = final: prev: eachDefaultSystem (system: {
      zenn-cli = (import ./. {
        inherit system;
        pkgs = final;
      }).zenn-cli;
    });

  } // eachDefaultSystem (system: {

    defaultPackage = (import nixpkgs {
      inherit system;
      overlays = [ self.overlay ];
    }).zenn-cli."${system}";

    defaultApp = let
      d = self.defaultPackage."${system}";
    in {
      type = "app";
      program = "${d}/bin/zenn";
    };

  });
}
