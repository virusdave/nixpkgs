{
  nixos,
  lib,
  runCommand,
}:
let
  machine = nixos {
    services.userborn.enable = true;
    hardware.graphics.enable = true;
    programs.nix-required-mounts = {
      enable = true;
      presets.nvidia-gpu.enable = true;
    };
    fileSystems."/".device = "/dev/null";
    boot.loader.grub.enable = false;
    system.stateVersion = lib.trivial.release;
  };
in
runCommand "nix-required-mounts-eval-nvidia-gpu-preset" { } ''
  echo "Successfully evaluated ${machine.config.system.build.toplevel}"
  echo "This means that combining nix-required-mounts with userborn no longer causes infinite recursion (#488199)"
  touch $out
''
