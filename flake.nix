# A flake that sets up the necessary development environment for things.
{
  description = "Hieratika: Compiling LLVM to CairoVM";

  # The things that we want to pin to.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cairo.url = "github:cairo-nix/cairo-nix";
  };

  # The results of our flake.
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    crane,
    fenix,
    naersk,
    cairo,
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # We grab our expected rust version from the Cargo.toml.
        rustVersion = (lib.importTOML ./Cargo.toml).workspace.package.rust-version;

        # Then we set up our libraries for building this thing.
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs) lib;
        fenixLib = fenix.packages.${system};
        toolchainHash = "sha256-s1RPtyvDGJaX/BisLT+ifVfuhDT1nZkZ1NcK8sbwELM=";
        fenixStable = fenixLib.fromToolchainName {
            name = rustVersion;
            sha256 = toolchainHash;
        };

        # As we want nightly Rustfmt, we have to build a custom toolchain.
        fenixToolchain = fenixLib.combine [
          fenixLib.latest.rustfmt  # `fenixLib.latest` is specifically the latest nightly
          (fenixStable.withComponents [
            "cargo"
            "clippy"
            "rust-docs"
            "rust-src"
            "rust-std"
            "rustc"
          ])
        ];

        fenixToolchainUnstable = fenixLib.combine [
          fenixLib.latest.cargo
          fenixLib.latest.clippy
          fenixLib.latest.rust-docs
          fenixLib.latest.rust-src
          fenixLib.latest.rust-std
          fenixLib.latest.rustc
          fenixLib.latest.rustfmt
        ];

        # The crane library configures the Rust toolchain, along with the components we expect it
        # to have.
        craneLib = (crane.mkLib pkgs).overrideToolchain fenixToolchain;

        craneLibUnstable = (crane.mkLib pkgs).overrideToolchain fenixToolchainUnstable;

        # Collect our workspace packages, including our application.
        workspacePackages = pkgs.callPackage ./workspace.nix {
          inherit craneLib;
        };

        workspacePackagesUnstable = pkgs.callPackage ./workspace.nix {
          craneLib = craneLibUnstable;
        };

        naersk' = naersk.lib.${system}.override {
          cargo = fenixToolchainUnstable;
          rustc = fenixToolchainUnstable;
        };

        test-inputs = pkgs.callPackage ./tests/rust-test-input/package.nix {
          naersk = naersk';
          inherit (fenixLib.latest) rust-src;
        };

        # Filter out things that aren't derivations for the `packages` output, or Nix gets mad.
        hieratika = lib.filterAttrs (lib.const lib.isDerivation) workspacePackages;

        hieratikaUnstable = lib.filterAttrs (lib.const lib.isDerivation) workspacePackagesUnstable;

        # And for convenience, collect all the workspace members into a single derivation,
        # so we can check they all compile with one command, `nix build '.#all'`.
        all = pkgs.symlinkJoin {
          name = "hieratika-all";
          paths = lib.attrValues hieratika;
        };

        # We get your default shell to make sure things feel familiar in the dev shell.
        getUserShellCommand = if pkgs.stdenv.hostPlatform.isDarwin then
          "dscl . -read ~ UserShell | cut -d ' ' -f2 | tr -d '\n'"
        else
          "getent passwd $USER | cut -d ':' -f7 | tr -d '\n'";

        # The packages that we want to make available in the dev shells.
        devshellPackages = [
          pkgs.nodejs_22
          pkgs.cargo-deny
        ];
      in {
        packages = {
          inherit all;
          default = hieratika.hieratika-cli;
          unstable = hieratikaUnstable.hieratika-cli;
          inherit test-inputs;
        } // hieratika;

        # The default dev shell puts you in your native shell to make things feel happy.
        devShells.default = craneLib.devShell {
          LLVM_SYS_180_PREFIX = "${pkgs.lib.getDev pkgs.llvmPackages_18.libllvm}";
          inputsFrom = lib.attrValues hieratika;
          packages = devshellPackages;

          rustTestInputs = test-inputs;
          rustTestInputsDest = "crates/compiler/input/compilation";

          shellHook = ''
            mkdir -p "$rustTestInputsDest"
            cp -rv "$rustTestInputs"/* "$rustTestInputsDest"

            exec $(${getUserShellCommand})
          '';
        };

        devShells.unstable = craneLibUnstable.devShell {
          LLVM_SYS_180_PREFIX = "${pkgs.lib.getDev pkgs.llvmPackages_18.libllvm}";
          inputsFrom = lib.attrValues hieratikaUnstable;
          packages = devshellPackages;
          shellHook = ''
            exec $(${getUserShellCommand})
          '';
        };

        # The dev shell for CI allows it to interpret commands properly.
        devShells.ci = craneLib.devShell {
          LLVM_SYS_180_PREFIX = "${pkgs.lib.getDev pkgs.llvmPackages_18.libllvm}";
          inputsFrom = lib.attrValues hieratika;
          packages = devshellPackages;
        };
      }
    );
}
