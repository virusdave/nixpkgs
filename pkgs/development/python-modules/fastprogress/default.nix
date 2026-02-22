{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  fastcore,
  numpy,
  fasthtml,
  ipython,
}:

buildPythonPackage (finalAttrs: {
  pname = "fastprogress";
  version = "1.1.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "fastai";
    repo = "fastprogress";
    tag = finalAttrs.version;
    hash = "sha256-hP61+gbETHlkQMy0KMAW5uGPyo2Kga/yJ5u9LvA+lgs=";
  };

  build-system = [ setuptools ];

  dependencies = [
    fastcore
    numpy
    fasthtml
    ipython
  ];

  # no real tests
  doCheck = false;
  pythonImportsCheck = [ "fastprogress" ];

  meta = {
    homepage = "https://github.com/fastai/fastprogress";
    changelog = "https://github.com/AnswerDotAI/fastprogress/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    description = "Simple and flexible progress bar for Jupyter Notebook and console";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ris ];
  };
})
