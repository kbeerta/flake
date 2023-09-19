with import <nixpkgs> {};
let 
  llvm = pkgs.llvmPackages_latest;
in
pkgs.mkShell {
  name = "c-env";
  stdenv = pkgs.clangStdenv;
  buildInputs = with pkgs; [
    gnumake

    clang-tools

    llvm.libstdcxxClang
    llvm.lldb
    llvm.libcxx
    llvm.libllvm
  ];
}
