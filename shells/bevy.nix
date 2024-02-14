{
  description = "flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.rust-overlay.url = "github:oxalica/rust-overlay";

  outputs = inputs @ { self, nixpkgs, rust-overlay }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (import rust-overlay)
      ];
    };
  in {
    devShells.${system}.default = pkgs.mkShell rec {
      buildInputs = with pkgs; [
        (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
          extensions = [ "rust-analyzer" ];
        }))

        udev 
        alsa-lib 

        xorg.libX11
        xorg.libXcursor 
        xorg.libXrandr 
        xorg.libXi
        
        vulkan-tools 
        vulkan-headers 
        vulkan-loader 
        vulkan-validation-layers

        libxkbcommon
        libGL

        pkg-config
      ];
      shellHook = ''
        exec $SHELL
      '';
      LD_LIBRARY_PATH = (pkgs.lib.makeLibraryPath buildInputs);
    };
  };
}
