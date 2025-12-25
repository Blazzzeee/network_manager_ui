{
  runCommand,
  ruff,
  dmenu,
  python3,
  python3Packages,
  networkmanager,
  gobject-introspection,
  writeText,
  wrapGAppsHook3,
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
    wrapGAppsHook3
    makeWrapper
  ];
  src = ./.;
  
  pyproject = true;
  build-system = [ python3Packages.setuptools ];

  buildInputs = [
    networkmanager
  ];

  doCheck = false;

  propagatedBuildInputs = with python3Packages; [
    dmenu
    pygobject3
  ];

  checkPhase = ''
    python -m mypy $src/network_manager_ui.py
    ruff check $src/network_manager_ui.py
  '';
}
