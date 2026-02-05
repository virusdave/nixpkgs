{
  buildGoModule,
  fetchFromGitHub,
  lib,
  nix-update-script,
  versionCheckHook,
}:

buildGoModule (finalAttrs: {
  pname = "whosthere";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "ramonvermeulen";
    repo = "whosthere";
    tag = "v${finalAttrs.version}";
    hash = "sha256-EuEq3HG7j5kz0GomJELcVy+POtbA+NtIM/Y/G3kGZn4=";
  };

  vendorHash = "sha256-YVPsWpIXC5SLm+T2jEGqF4MBcKOAAk0Vpc7zCIFkNw8=";

  ldflags = [
    "-s"
    "-X"
    "main.versionStr=${finalAttrs.version}"
  ];

  checkFlags =
    let
      # Skip tests that require filesystem access
      skippedTests = [
        "TestResolveLogPath"
        "TestStateDir"
      ];
    in
    [ "-skip=^${builtins.concatStringsSep "$|^" skippedTests}$" ];

  nativeInstallCheckInputs = [
    versionCheckHook
  ];
  doInstallCheck = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Local Area Network discovery tool";
    longDescription = ''
      Local Area Network discovery tool with a modern Terminal User Interface
      (TUI) written in Go. Discover, explore, and understand your LAN in an
      intuitive way. Knock Knock.. who's there?
    '';
    homepage = "https://github.com/ramonvermeulen/whosthere";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ matthiasbeyer ];
    platforms = lib.platforms.linux;
    mainProgram = "whosthere";
  };
})
