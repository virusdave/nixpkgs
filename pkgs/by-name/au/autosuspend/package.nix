{
  lib,
  dbus,
  fetchFromGitHub,
  python3,
}:

python3.pkgs.buildPythonApplication (finalAttrs: {
  pname = "autosuspend";
  version = "10.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "languitar";
    repo = "autosuspend";
    tag = "v${finalAttrs.version}";
    hash = "sha256-o9Jpb4i2/SJ3s3h5sclNjpaN/UFk1YbpPf7b3rGXLRg=";
  };

  build-system = with python3.pkgs; [
    setuptools
  ];

  dependencies = with python3.pkgs; [
    dbus-python
    icalendar
    jsonpath-ng
    lxml
    mpd2
    psutil
    pygobject3
    python-dateutil
    requests
    requests-file
    tzdata
    tzlocal
  ];

  nativeCheckInputs = with python3.pkgs; [
    dbus
    freezegun
    pytest-cov-stub
    pytest-datadir
    pytest-httpserver
    pytest-mock
    pytestCheckHook
    python-dbusmock
  ];

  # Disable tests that need root
  disabledTests = [
    "test_smoke"
    "test_multiple_sessions"
  ];

  meta = {
    description = "Daemon to automatically suspend and wake up a system";
    homepage = "https://autosuspend.readthedocs.io";
    changelog = "https://github.com/languitar/autosuspend/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [
      bzizou
      anthonyroussel
    ];
    mainProgram = "autosuspend";
    platforms = lib.platforms.linux;
  };
})
