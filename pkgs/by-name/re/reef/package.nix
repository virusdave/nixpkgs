{
  lib,
  rustPlatform,
  fetchFromGitHub,
  versionCheckHook,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "reef";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "ZStud";
    repo = "reef";
    tag = "v${finalAttrs.version}";
    hash = lib.fakeHash;
  };

  cargoHash = lib.fakeHash;

  postInstall = ''
    install -Dm644 fish/functions/*.fish -t $out/share/fish/vendor_functions.d/
    install -Dm644 fish/conf.d/reef.fish -t $out/share/fish/vendor_conf.d/
  '';

  nativeCheckInputs = [ versionCheckHook ];
  doCheck = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Bash compatibility layer for fish shell";
    homepage = "https://github.com/ZStud/reef";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ nadir-ishiguro ];
    mainProgram = "reef";
    platforms = lib.platforms.unix;
  };
})
