{
  description = "Efficient Python Nested Structure Library";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/21.05";

    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: inputs.utils.lib.eachSystem [
    "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin"
  ] (system:
    let pkgs = import nixpkgs {
          inherit system;
        };
    in {
      devShell = pkgs.mkShell rec {
        name = "cnest-dev";

        packages = with pkgs; [
          poetry
        ];

        shellHook = ''
          export PS1="$(echo -e '\uf3e2') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
        '';
      };

      packages = let
        cnestTestEnv = pkgs.python3.withPackages (pyPkgs: with pyPkgs; let
          cnest = pyPkgs.callPackage ./default.nix {};
        in [
          cnest
          pytest
        ]);
      in {
        testShell = pkgs.mkShell rec {
          name = "cnest-test-shell";

          packages = with pkgs; [
            cnestTestEnv
            poetry
          ];

          shellHook = ''
            export PS1="$(echo -e '\uf3e2') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
          '';
        };
      };
    });
}
