{
  lib,
  buildPythonPackage,
  fetchPypi,
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

  src = fetchPypi {
    inherit (finalAttrs) pname version;
    hash = "sha256-L3Bxvrk84mHdtR1mskOoUXtCFWOgEHSY5Yhe0tkTb8o=";
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
    description = "Simple and flexible progress bar for Jupyter Notebook and console";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ris ];
  };
})
