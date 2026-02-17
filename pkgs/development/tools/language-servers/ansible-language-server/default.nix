{
  lib,
  fetchFromGitHub,
  pkgs,
}:
let
  pname = "ansible-language-server";
  version = "26.1.3";

  src = fetchFromGitHub {
    owner = "ansible";
    repo = "vscode-ansible";
    tag = "v${version}";
    hash = "sha256-DsEW3xP8Fa9nwPuyEFVqG6rvAZgr4TDB6jhyixdvqt8=";
  };

  # Fixed-output derivation to fetch yarn berry dependencies
  offlineCache = pkgs.stdenvNoCC.mkDerivation {
    name = "${pname}-${version}-yarn-cache";
    inherit src;

    nativeBuildInputs = [
      pkgs.yarn-berry
      pkgs.nodejs
      pkgs.cacert
    ];

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-NYbHhvlVoSL7lT1EdFkNJlmzRzQ0Gudo5pF0t6JtSic=";

    buildPhase = ''
      export HOME=$TMPDIR
      export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt

      yarn config set enableTelemetry false
      yarn config set enableGlobalCache false
      yarn config set cacheFolder .yarn/cache
      yarn install --mode=skip-build

      mkdir -p $out
      cp -r .yarn/cache/* $out/
      cp .yarnrc.yml $out/ || true
    '';

    dontInstall = true;
  };

in
pkgs.stdenvNoCC.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = with pkgs; [
    yarn-berry
    nodejs
    makeWrapper
  ];

  buildPhase = ''
    export HOME=$TMPDIR

    # Set up yarn cache from our FOD
    mkdir -p .yarn/cache
    for f in ${offlineCache}/*; do
      if [ "$(basename $f)" != ".yarnrc.yml" ]; then
        cp -r "$f" .yarn/cache/
      fi
    done

    yarn config set enableTelemetry false
    yarn config set enableGlobalCache false
    yarn config set cacheFolder .yarn/cache
    yarn config set enableNetwork false

    # Only install deps for ansible-language-server workspace
    yarn workspaces focus @ansible/ansible-language-server

    # Build ansible-language-server (exclude tests)
    cd packages/ansible-language-server
    rm -rf test
    yarn run compile
  '';

  installPhase = ''
    mkdir -p $out/lib/node_modules/ansible-language-server
    cp -r out package.json $out/lib/node_modules/ansible-language-server/

    # Copy node_modules (yarn berry installs them at workspace root)
    # Use -L to dereference symlinks (yarn creates symlinks for workspace packages)
    cd ../..
    cp -rL node_modules $out/lib/node_modules/ansible-language-server/

    mkdir -p $out/lib/node_modules/ansible-language-server/bin
    cp packages/ansible-language-server/bin/ansible-language-server $out/lib/node_modules/ansible-language-server/bin/

    mkdir -p $out/bin
    makeWrapper ${pkgs.nodejs}/bin/node $out/bin/ansible-language-server \
      --prefix PATH : ${pkgs.python3}/bin \
      --add-flags "$out/lib/node_modules/ansible-language-server/out/server/src/server.js"
  '';

  meta = with lib; {
    changelog = "https://github.com/ansible/vscode-ansible/releases/tag/v${version}";
    description = "Ansible Language Server";
    mainProgram = "ansible-language-server";
    homepage = "https://github.com/ansible/vscode-ansible";
    license = licenses.mit;
    maintainers = with lib.maintainers; [ dtvillafana ];
  };
}
