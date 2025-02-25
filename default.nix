{
  runCommand,
  ruff,
  dmenu,
  python3,
  python3Packages,
  networkmanager,
  gobject-introspection,
  writeText,
  wrapGAppsHook,
  makeWrapper
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

in
python3Packages.buildPythonPackage {
  name = "network_manager_ui";
  nativeBuildInputs = [
    pygobject-stubs'
    python3Packages.mypy
    ruff
    gobject-introspection
    wrapGAppsHook
    makeWrapper
  ];
  src = ./.;

  buildInputs = [
    networkmanager
  ];

  propagatedBuildInputs = with python3Packages; [
    dmenu
    pygobject3
  ];

  checkPhase = ''
    python -m mypy network_manager_ui.py
    ruff check network_manager_ui.py
  '';
}
