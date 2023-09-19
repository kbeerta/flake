with import <nixpkgs> {};
pkgs.mkShell {
  name = "dotnet-env";
  buildInputs = with pkgs; [
    dotnet-sdk_8
    omnisharp-roslyn
  ];
}
