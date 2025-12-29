{
  lib,
  makeSetupHook,
  binutils-unwrapped,
  stdenv,
  callPackage,
}:
makeSetupHook {
  name = "cygwin-dll-link-hook";
  substitutions = {
    objdump = "${lib.getBin binutils-unwrapped}/${stdenv.targetPlatform.config}/bin/objdump";
  };
} ./cygwin-dll-link.sh
