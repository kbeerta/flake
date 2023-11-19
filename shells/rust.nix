with import <nixpkgs> {};
let 
    rust-overlay = builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz";
    pkgs = import <nixpkgs> {
        overlays = [ (import rust-overlay) ];
    };
in
pkgs.mkShell {
    name = "rust-env";
    buildInputs = with pkgs; [
        rust-bin.stable.latest.default
        rust-analyzer
    ];
}
