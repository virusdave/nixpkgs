{
  lib,
  buildHomeAssistantComponent,
  fetchFromGitHub,
  aiofiles,
  bcrypt,
  jinja2,
  joserfc,
  python-jose,
}:

buildHomeAssistantComponent rec {
  owner = "christaangoossens";
  domain = "auth_oidc";
  version = "0.6.5-alpha";

  src = fetchFromGitHub {
    owner = "christiaangoossens";
    repo = "hass-oidc-auth";
    tag = "v${version}";
    hash = "sha256-nclrSO6KmPnwXRPuuFwR6iYHsyfqcelPRGERWVJpdyk=";
  };

  dependencies = [
    aiofiles
    bcrypt
    jinja2
    joserfc
    python-jose
  ];

  meta = {
    changelog = "https://github.com/christiaangoossens/hass-oidc-auth/releases/tag/v${version}";
    description = "OpenID Connect authentication provider for Home Assistant";
    homepage = "https://github.com/christiaangoossens/hass-oidc-auth";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hexa ];
  };
}
