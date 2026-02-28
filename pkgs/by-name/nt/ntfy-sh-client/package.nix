{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  curl,
}:

stdenv.mkDerivation {
  pname = "ntfy-sh-client";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "virusdave";
    repo = "ntfy-sh-client";
    rev = "v1.0.2";
    hash = "sha256-gwtXDTzhjVRqCBiqM0k7+awppQbSn7NN/mH3ldNFb1s=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ curl ];

  installPhase = ''
    mkdir -p $out/bin
    cp ntfy-sh-client.sh $out/bin/ntfy-sh-client
    chmod +x $out/bin/ntfy-sh-client

    wrapProgram $out/bin/ntfy-sh-client \
      --prefix PATH : ${lib.makeBinPath [ curl ]}
  '';

  meta = {
    description = "A convenience flake CLI wrapper around curl for using ntfy.sh alerting";
    homepage = "https://github.com/virusdave/ntfy-sh-client";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ virusdave ];
    platforms = lib.platforms.all;
    mainProgram = "ntfy-sh-client";
  };
}
