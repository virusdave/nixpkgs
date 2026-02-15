{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools-scm,
}:

buildPythonPackage rec {
  pname = "napari-plugin-engine";
  version = "0.2.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "napari";
    repo = "napari-plugin-engine";
    tag = "v${version}";
    hash = "sha256-GdOip1ekw4MUzGugiaYQQvBKkZaKVoWI/rASelrNmAU=";
  };

  nativeBuildInputs = [ setuptools-scm ];

  # Circular dependency: napari
  doCheck = false;

  pythonImportsCheck = [ "napari_plugin_engine" ];

  meta = {
    description = "First generation napari plugin engine";
    homepage = "https://github.com/napari/napari-plugin-engine";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ SomeoneSerge ];
  };
}
