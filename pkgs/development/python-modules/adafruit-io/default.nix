{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  paho-mqtt,
  pytestCheckHook,
  requests,
  setuptools-scm,
}:

buildPythonPackage rec {
  pname = "adafruit-io";
  version = "2.8.2";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "adafruit";
    repo = "Adafruit_IO_Python";
    tag = version;
    hash = "sha256-JYQKrGg4FRzqq3wy/TqafC16rldvPEi+/xEI7XGvWM8=";
  };

  nativeBuildInputs = [ setuptools-scm ];

  propagatedBuildInputs = [
    paho-mqtt
    requests
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "Adafruit_IO" ];

  disabledTestPaths = [
    # Tests requires valid credentials
    "tests/test_client.py"
    "tests/test_errors.py"
    "tests/test_mqtt_client.py"
  ];

  meta = {
    description = "Module for interacting with Adafruit IO";
    homepage = "https://github.com/adafruit/Adafruit_IO_Python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
  };
}
