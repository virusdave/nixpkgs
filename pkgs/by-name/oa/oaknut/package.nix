{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  ninja,
}:
stdenv.mkDerivation {
  pname = "oaknut";
  version = "1.2.2-unstable-2024-03-01";

  src = fetchFromGitHub {
    owner = "merryhime";
    repo = "oaknut";
    rev = "94c726ce0338b054eb8cb5ea91de8fe6c19f4392";
    hash = "sha256-IhP/110NGN42/FvpGIEm9MgsSiPYdtD8kNxL0cAWbqM=";
  };

  nativeBuildInputs = [
    cmake
    ninja
  ];

  meta = {
    description = "Header-only library that allows one to dynamically assemble code in-memory at runtime";
    homepage = "https://github.com/merryhime/oaknut";
    maintainers = with lib.maintainers; [ marcin-serwin ];
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
