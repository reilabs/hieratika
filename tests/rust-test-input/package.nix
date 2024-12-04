# This package is responsible for building IR from the `rust-test-input` crate,
# using our custom Rust target.
#
# Most importantly, this compilation step includes `compiler_builtins`, `core`
# and `alloc` built for our custom target.
{
  lib,
  stdenvNoCC,
  naersk,
  rust-src,
  fd,
  zstd,
}: let
  targetDir = naersk.buildPackage {

    src = ./.;

    nativeBuildInputs = [
      fd
    ];

    release = false;

    cargoBuildOptions = x: x ++ [
      "--target=${../../cairo-starkware-none.json}"
      "-Z" "build-std=core,alloc"
    ];

    additionalCargoLock = rust-src + "/lib/rustlib/src/rust/library/Cargo.lock";

    copyTarget = true;
  };

  fd' = lib.concatStringsSep " " [
    "fd"
    "--no-ignore"
    "--hidden"
  ];
in stdenvNoCC.mkDerivation (self: {
  name = "rust-test-input-llvm-ir";
  src = targetDir + "/target.tar.zst";

  strictDeps = true;
  __structuredAttrs = true;

  nativeBuildInputs = [
    fd
    zstd
  ];

  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  desiredLlFiles = [
    "alloc"
    "compiler_builtins"
    "core"
    "hieratika_rust_test_input"
  ];

  installPhase = ''
    runHook preInstall

    mkdir "$out"
    for llName in "''${desiredLlFiles[@]}"; do
      ${fd'} -t f \
        "^$llName-.+\.ll$" \
        -x cp "{}" "$out/$llName.ll"
    done

    runHook postInstall
  '';
})
