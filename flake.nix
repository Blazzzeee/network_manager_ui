{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.treefmt-nix.url = "github:numtide/treefmt-nix";

  outputs =
    {
      nixpkgs,
      flake-utils,
      treefmt-nix,
      self,
    }:
    flake-utils.lib.eachSystem
      (with flake-utils.lib.system; [
        x86_64-linux
        aarch64-linux
      ])
      (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
          network_manager_ui = pkgs.callPackage ./default.nix { };
        in
        {
          devShells.default = network_manager_ui.inputDerivation;
          packages.network_manager_ui = network_manager_ui;
          formatter = treefmtEval.config.build.wrapper;
          checks.formatting = treefmtEval.config.build.check self;
          checks.builds = network_manager_ui;
        }
      );
}
