{
  lib,
  ruff,
  rofi,
  dmenu,
  glib,
  gtk3,
  gsettings-desktop-schemas,
  librsvg,
  adwaita-icon-theme,
  python3Packages,
  networkmanager,
  gobject-introspection,
  libnotify,
  wrapGAppsHook3,
  makeWrapper,
  writeText
}:
let
  pygobject-stubs' = python3Packages.pygobject-stubs.overridePythonAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ ([
      networkmanager
      python3Packages.pygobject3
    ]);
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ gobject-introspection ];
    # see https://github.com/pygobject/pygobject-stubs/pull/204
    patches = (old.patches or [ ]) ++ [ ./pygobject.patch ];
    postPatch = ''
      python tools/generate.py NM 1.0 > src/gi-stubs/repository/NM.pyi
    '';
  });

  defaultConfig = writeText "config.ini" ''
    [dmenu]
    dmenu_command = rofi -dmenu -p Networks -i
    wifi_icons = 󰤯󰤟󰤢󰤥󰤨
    format = {name} {icon}
    list_saved = False

    [editor]
    terminal = kitty
  '';

in
python3Packages.buildPythonPackage {
  pname = "network_manager_ui";
  version = "0.0.0";

  src = ../.;

  pyproject = true;

  build-system = [
    python3Packages.setuptools
  ];

  nativeBuildInputs = [
    pygobject-stubs'
    python3Packages.mypy
    ruff
    gobject-introspection
    wrapGAppsHook3
    makeWrapper
  ];

  buildInputs = [
    networkmanager
    rofi
    dmenu
    libnotify
    glib
    gtk3
    gsettings-desktop-schemas
    librsvg
    adwaita-icon-theme
  ];

  propagatedBuildInputs = with python3Packages; [
    pygobject3
  ];

  postPatch = ''
    cp ${./setup.py} setup.py
    substituteInPlace network_manager_ui.py \
      --replace-fail 'CONF.read(expanduser("~/.config/networkmanager/config.ini"))' \
                     'CONF.read([expanduser("~/.config/networkmanager/config.ini"), "${defaultConfig}"])'
  '';

  postFixup = ''
    wrapProgram $out/bin/network_manager_ui \
      --prefix PATH : ${lib.makeBinPath [ rofi -dmenu libnotify ]}
  '';

  doCheck = false;

  checkPhase = ''
    python -m mypy network_manager_ui.py
    ruff check network_manager_ui.py
  '';
}
