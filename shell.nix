{
  pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
    };
  },
}:

pkgs.mkShellNoCC {
  nativeBuildInputs = with pkgs; [
    nixfmt
  ];
}
