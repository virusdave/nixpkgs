{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  taglib,
  cython,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "pytaglib";
  version = "3.2.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "supermihi";
    repo = "pytaglib";
    tag = "v${version}";
    hash = "sha256-529U71Lvs6QufcG3yBeywyGc2ukYYfFHIf6TFjt+k3U=";
  };

  buildInputs = [
    cython
    taglib
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "taglib" ];

  meta = {
    description = "Python bindings for the Taglib audio metadata library";
    mainProgram = "pyprinttags";
    homepage = "https://github.com/supermihi/pytaglib";
    changelog = "https://github.com/supermihi/pytaglib/blob/${src.tag}/CHANGELOG.md";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ mrkkrp ];
  };
}
