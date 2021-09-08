# nix-zenn-cli
zenn-cli for NixOS user.

## quick start

```console
$ nix run github:hnakano863/nix-zenn-cli
```

## using flake registry

You can run the command more conveniently if you add the flake to your flake registry.

```console
$ nix registry add zenn github:hnakano863/nix-zenn-cli
```

then, you can run by

```console
$ nix run zenn
```

## overlay

```nix flake.nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.zenn-cli.url = "github:hnakano863/nix-zenn-cli";

  outputs = { self, nixpkgs, flake-utils, zenn-cli }:
    flake-utils.lib.eachDefaultSystem (system:
	  let
	    pkgs = import nixpkgs {
		  inherit system;
		  overlays = [ zenn-cli.overlay ];
	    }
      in
	    {
		  devShell = with pkgs; mkShell {
		    buildInputs = [ zenn-cli ];
		  };
	    }
	);
```

then,

```console
$ nix shell

$ zenn
```
