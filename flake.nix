{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: (
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      packages.${system}.default = pkgs.callPackage nix/scip-typescript {};

      devShells.${system}.default = pkgs.mkShell {
        inputsFrom = [self.packages.${system}.default];

        packages = with pkgs; [
          typescript-language-server
          scip
        ];
      };

      formatter.${system} = pkgs.alejandra;
    }
  );
}
