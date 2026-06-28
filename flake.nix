{
  description = "Neovim Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      neovim-wrapped = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
        extraPackages = with pkgs; [
          cargo
          fd
          fzf
          gcc
          gnumake
          go
          ripgrep
          tree-sitter
          unzip
        ];
        sideloadInitLua = true;
        vimAlias = true;
        viAlias = true;
        waylandSupport = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = false;
        wrapRc = false;
      };
    in
    {
      packages.${system}.default = neovim-wrapped;
      devShells.${system}.nvim = pkgs.mkShell {
        buildInputs = [ neovim-wrapped ];
      };

      homeManagerModules = {
        default = { config, pkgs, ... }: {
          home.packages = [ neovim-wrapped ];
        };
        nvim = self.homeManagerModules.default;
      };
    };
}
