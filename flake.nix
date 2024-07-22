{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          cmake
          glib.dev
          glib.out
          libfprint
          libpam-wrapper
          libxml2
          linux-pam
          meson
          ninja
          pkg-config
          polkit.dev
          systemd.dev
        ];
      };
      formatter = pkgs.alejandra;
    });
}
