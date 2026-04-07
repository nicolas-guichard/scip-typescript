{
  lib,
  mkYarnModules,
  mkYarnPackage,
  typescript,
  pnpm_9,
}: let
  pname = "scip-typescript";
  version = "unstable";

  src = lib.fileset.toSource {
    root = ../..;
    fileset = lib.fileset.unions [
      ../../src
      ../../snapshots
      ../../.eslintrc.js
      ../../.prettierignore
      ../../.prettierrc
      ../../package.json
      ../../renovate.json
      ../../tsconfig.json
      ../../yarn.lock
    ];
  };

  snapshots = mkYarnModules {
    pname = "${pname}-snapshots-modules";
    inherit version;

    packageJSON = ../../snapshots/package.json;
    yarnLock = ../../snapshots/yarn.lock;
  };
in
  mkYarnPackage {
    inherit pname version src;

    configurePhase = ''
      runHook preConfigure

      ln -s "$node_modules" node_modules

      runHook postConfigure
    '';

    nativeBuildInputs = [typescript];

    buildPhase = ''
      runHook preBuild

      export HOME=$(mktemp -d)
      tsc -b .

      runHook postBuild
    '';

    doCheck = true;
    nativeCheckInputs = [pnpm_9];
    checkPhase = ''
      runHook preCheck

      # We have two dependency-less test projects that need to be installed for the tests to pass
      # This is what the prepare script normally does on yarn install
      pushd snapshots/input/multi-project
      yarn --offline install
      popd
      pushd snapshots/input/pnpm-workspaces
      pnpm --offline install
      popd

      ln -s "${snapshots}/node_modules" snapshots/node_modules
      yarn --offline test

      runHook postCheck
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p "$out"/{bin,libexec}
      mv dist $out/libexec/${pname}
      mv node_modules $out/libexec/${pname}/node_modules
      chmod +x $out/libexec/${pname}/src/main.js
      ln -s $out/libexec/${pname}/src/main.js $out/bin/${pname}

      runHook postInstall
    '';

    distPhase = "true";
  }
