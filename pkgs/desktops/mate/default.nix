{
  pkgs,
  lib,
  config,
}:

let
  packages =
    self: with self; {

      # Update script tailored to mate packages from git repository
      mateUpdateScript =
        {
          pname,
          odd-unstable ? true,
          rev-prefix ? "v",
          url ? null,
        }:
        pkgs.gitUpdater {
          inherit odd-unstable rev-prefix;
          url = if url == null then "https://git.mate-desktop.org/${pname}" else url;
        };

      caja = callPackage ./caja { };
      caja-dropbox = callPackage ./caja-dropbox { };
      caja-extensions = callPackage ./caja-extensions { };
      caja-with-extensions = callPackage ./caja/with-extensions.nix { };
      mate-panel = callPackage ./mate-panel { };
      mate-panel-with-applets = callPackage ./mate-panel/with-applets.nix { };
      mate-settings-daemon = callPackage ./mate-settings-daemon { };
      mate-settings-daemon-wrapped = callPackage ./mate-settings-daemon/wrapped.nix { };

      mate-tweak = callPackage ./mate-tweak { };
      mate-user-guide = callPackage ./mate-user-guide { };
      mate-user-share = callPackage ./mate-user-share { };
      mate-utils = callPackage ./mate-utils { };
      mate-wayland-session = callPackage ./mate-wayland-session { };
      mozo = callPackage ./mozo { };
      pluma = callPackage ./pluma { };
      python-caja = callPackage ./python-caja { };

      # Caja and mate-panel are managed in NixOS module.
      basePackages = [
        libmatekbd
        libmatemixer
        libmateweather
        marco
        mate-common
        mate-control-center
        mate-desktop
        mate-icon-theme
        mate-menus
        mate-notification-daemon
        mate-polkit
        mate-session-manager
        mate-settings-daemon
        mate-settings-daemon-wrapped
        mate-themes
      ];

      extraPackages = [
        atril
        caja-extensions # for caja-sendto
        engrampa
        eom
        mate-applets
        mate-backgrounds
        mate-calc
        mate-indicator-applet
        mate-media
        mate-netbook
        mate-power-manager
        mate-screensaver
        mate-system-monitor
        mate-terminal
        mate-user-guide
        # mate-user-share
        mate-utils
        mozo
        pluma
      ];

      cajaExtensions = [
        caja-extensions
      ];

      panelApplets = [
        mate-applets
        mate-indicator-applet
        mate-netbook
        mate-notification-daemon
        mate-media
        mate-power-manager
        mate-sensors-applet
        mate-utils
      ];
    };

in
lib.makeScope pkgs.newScope packages
// lib.optionalAttrs config.allowAliases {
  atril = lib.warnOnInstantiate "‘mate.atril’ was moved to top-level. Please use ‘pkgs.atril’ directly" pkgs.atril; # Added on 2026-02-08
  engrampa = lib.warnOnInstantiate "‘mate.engrampa’ was moved to top-level. Please use ‘pkgs.engrampa’ directly" pkgs.engrampa; # Added on 2026-02-08
  eom = lib.warnOnInstantiate "‘mate.eom’ was moved to top-level. Please use ‘pkgs.eom’ directly" pkgs.eom; # Added on 2026-02-08
  libmatekbd = lib.warnOnInstantiate "‘mate.libmatekbd’ was moved to top-level. Please use ‘pkgs.libmatekbd’ directly" pkgs.libmatekbd; # Added on 2026-02-08
  libmatemixer = lib.warnOnInstantiate "‘mate.libmatemixer’ was moved to top-level. Please use ‘pkgs.libmatemixer’ directly" pkgs.libmatemixer; # Added on 2026-02-08
  libmateweather = lib.warnOnInstantiate "‘mate.libmateweather’ was moved to top-level. Please use ‘pkgs.libmateweather’ directly" pkgs.libmateweather; # Added on 2026-02-08
  marco = lib.warnOnInstantiate "‘mate.marco’ was moved to top-level. Please use ‘pkgs.marco’ directly" pkgs.marco; # Added on 2026-02-08
  mate-applets = lib.warnOnInstantiate "‘mate.mate-applets’ was moved to top-level. Please use ‘pkgs.mate-applets’ directly" pkgs.mate-applets; # Added on 2026-02-08
  mate-backgrounds = lib.warnOnInstantiate "‘mate.mate-backgrounds’ was moved to top-level. Please use ‘pkgs.mate-backgrounds’ directly" pkgs.mate-backgrounds; # Added on 2026-02-08
  mate-calc = lib.warnOnInstantiate "‘mate.mate-calc’ was moved to top-level. Please use ‘pkgs.mate-calc’ directly" pkgs.mate-calc; # Added on 2026-02-08
  mate-common = lib.warnOnInstantiate "‘mate.mate-common’ was moved to top-level. Please use ‘pkgs.mate-common’ directly" pkgs.mate-common; # Added on 2026-02-08
  mate-control-center = lib.warnOnInstantiate "‘mate.mate-control-center’ was moved to top-level. Please use ‘pkgs.mate-control-center’ directly" pkgs.mate-control-center; # Added on 2026-02-08
  mate-desktop = lib.warnOnInstantiate "‘mate.mate-desktop’ was moved to top-level. Please use ‘pkgs.mate-desktop’ directly" pkgs.mate-desktop; # Added on 2026-02-08
  mate-gsettings-overrides = lib.warnOnInstantiate "‘mate.mate-gsettings-overrides’ was moved to top-level. Please use ‘pkgs.mate-gsettings-overrides’ directly" pkgs.mate-gsettings-overrides; # Added on 2026-02-08
  mate-icon-theme = lib.warnOnInstantiate "‘mate.mate-icon-theme’ was moved to top-level. Please use ‘pkgs.mate-icon-theme’ directly" pkgs.mate-icon-theme; # Added on 2026-02-08
  mate-icon-theme-faenza = lib.warnOnInstantiate "‘mate.mate-icon-theme-faenza’ was moved to top-level. Please use ‘pkgs.mate-icon-theme-faenza’ directly" pkgs.mate-icon-theme-faenza; # Added on 2026-02-08
  mate-indicator-applet = lib.warnOnInstantiate "‘mate.mate-indicator-applet’ was moved to top-level. Please use ‘pkgs.mate-indicator-applet’ directly" pkgs.mate-indicator-applet; # Added on 2026-02-08
  mate-media = lib.warnOnInstantiate "‘mate.mate-media’ was moved to top-level. Please use ‘pkgs.mate-media’ directly" pkgs.mate-media; # Added on 2026-02-08
  mate-menus = lib.warnOnInstantiate "‘mate.mate-menus’ was moved to top-level. Please use ‘pkgs.mate-menus’ directly" pkgs.mate-menus; # Added on 2026-02-08
  mate-netbook = lib.warnOnInstantiate "‘mate.mate-netbook’ was moved to top-level. Please use ‘pkgs.mate-netbook’ directly" pkgs.mate-netbook; # Added on 2026-02-08
  mate-notification-daemon = lib.warnOnInstantiate "‘mate.mate-notification-daemon’ was moved to top-level. Please use ‘pkgs.mate-notification-daemon’ directly" pkgs.mate-notification-daemon; # Added on 2026-02-08
  mate-polkit = lib.warnOnInstantiate "‘mate.mate-polkit’ was moved to top-level. Please use ‘pkgs.mate-polkit’ directly" pkgs.mate-polkit; # Added on 2026-02-08
  mate-power-manager = lib.warnOnInstantiate "‘mate.mate-power-manager’ was moved to top-level. Please use ‘pkgs.mate-power-manager’ directly" pkgs.mate-power-manager; # Added on 2026-02-08
  mate-screensaver = lib.warnOnInstantiate "‘mate.mate-screensaver’ was moved to top-level. Please use ‘pkgs.mate-screensaver’ directly" pkgs.mate-screensaver; # Added on 2026-02-08
  mate-sensors-applet = lib.warnOnInstantiate "‘mate.mate-sensors-applet’ was moved to top-level. Please use ‘pkgs.mate-sensors-applet’ directly" pkgs.mate-sensors-applet; # Added on 2026-02-08
  mate-session-manager = lib.warnOnInstantiate "‘mate.mate-session-manager’ was moved to top-level. Please use ‘pkgs.mate-session-manager’ directly" pkgs.mate-session-manager; # Added on 2026-02-08
  mate-system-monitor = lib.warnOnInstantiate "‘mate.mate-system-monitor’ was moved to top-level. Please use ‘pkgs.mate-system-monitor’ directly" pkgs.mate-system-monitor; # Added on 2026-02-08
  mate-terminal = lib.warnOnInstantiate "‘mate.mate-terminal’ was moved to top-level. Please use ‘pkgs.mate-terminal’ directly" pkgs.mate-terminal; # Added on 2026-02-08
  mate-themes = lib.warnOnInstantiate "‘mate.mate-themes’ was moved to top-level. Please use ‘pkgs.mate-themes’ directly" pkgs.mate-themes; # Added on 2026-02-08
}
