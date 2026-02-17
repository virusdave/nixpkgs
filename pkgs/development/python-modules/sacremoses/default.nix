{
  buildPythonPackage,
  lib,
  fetchFromGitHub,
  click,
  joblib,
  tqdm,
  regex,
  pytest,
}:

buildPythonPackage rec {
  pname = "sacremoses";
  version = "0.1.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "hplt-project";
    repo = "sacremoses";
    rev = version;
    sha256 = "sha256-ked6/8oaGJwVW1jvpjrWtJYfr0GKUHdJyaEuzid/S3M=";
  };

  propagatedBuildInputs = [
    click
    joblib
    tqdm
    regex
  ];

  nativeCheckInputs = [ pytest ];
  # ignore tests which call to remote host
  checkPhase = ''
    pytest -k 'not truecase'
  '';

  meta = {
    homepage = "https://github.com/alvations/sacremoses";
    description = "Python port of Moses tokenizer, truecaser and normalizer";
    mainProgram = "sacremoses";
    license = lib.licenses.lgpl21Plus;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ pashashocky ];
  };
}
