{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:

buildGoModule {
  pname = "sif";
  version = "0-unstable-2026-02-08";

  src = fetchFromGitHub {
    owner = "vmfunc";
    repo = "sif";
    rev = "af531850dc7fa37bcff2de4d88c4254776ba4afe";
    hash = "sha256-hXFWqAAhkfTiiel5JKi0GOcY+Q1TLhJWZIJTaWlGthk=";
  };

  vendorHash = "sha256-ztKXnOjZS/jMxsRjtF0rIZ3lKv4YjMdZd6oQFRuAtR4=";

  subPackages = [ "cmd/sif" ];

  env.CGO_ENABLED = 0;

  ldflags = [
    "-s"
    "-w"
  ];

  # network-dependent tests
  doCheck = false;

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version=branch"
      "--version-regex=(0-unstable-.*)"
    ];
  };

  meta = {
    description = "Modular pentesting toolkit written in Go";
    homepage = "https://github.com/vmfunc/sif";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ vmfunc ];
    mainProgram = "sif";
  };
}
