{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  ninja,
  fmt,
  catch2_3,
}:
stdenv.mkDerivation {
  pname = "mcl";
  version = "0.1.13-unstable-2025-03-16";

  src = fetchFromGitHub {
    owner = "azahar-emu";
    repo = "mcl";
    rev = "7b08d83418f628b800dfac1c9a16c3f59036fbad";
    hash = "sha256-uTOiOlMzKbZSjKjtVSqFU+9m8v8horoCq3wL0O2E8sI=";
  };

  nativeBuildInputs = [
    cmake
    ninja
  ];

  buildInputs = [
    fmt
  ];

  checkInputs = [
    catch2_3
  ];

  doCheck = true;
  checkPhase = ''
    tests/mcl-tests
  '';

  meta = {
    description = "Collection of C++20 utilities which is common to a number of merry's projects";
    homepage = "https://github.com/azahar-emu/mcl";
    maintainers = with lib.maintainers; [ marcin-serwin ];
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
