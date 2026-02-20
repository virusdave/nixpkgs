{
  lib,
  buildPythonPackage,
  dj-database-url,
  dj-email-url,
  django-cache-url,
  fetchFromGitHub,
  flit-core,
  marshmallow,
  pytestCheckHook,
  python-dotenv,
}:

buildPythonPackage rec {
  pname = "environs";
  version = "14.6.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "sloria";
    repo = "environs";
    tag = version;
    hash = "sha256-TX8C3KIuvAkC+ArGFz9FXyqxd9pfTgmMqnLuYNIlA4o=";
  };

  nativeBuildInputs = [ flit-core ];

  propagatedBuildInputs = [
    marshmallow
    python-dotenv
  ];

  nativeCheckInputs = [
    dj-database-url
    dj-email-url
    django-cache-url
    pytestCheckHook
  ];

  pythonImportsCheck = [ "environs" ];

  meta = {
    description = "Python modle for environment variable parsing";
    homepage = "https://github.com/sloria/environs";
    changelog = "https://github.com/sloria/environs/blob/${version}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
  };
}
