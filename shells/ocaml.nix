with import <nixpkgs> {};
pkgs.mkShell {
  name = "ocaml-env";
  buildInputs = with pkgs; [
    ocaml
    ocamlPackages.findlib
    ocamlPackages.ocaml-lsp
    dune_3
  ];
}
