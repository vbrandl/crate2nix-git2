{ pkgs ? import <nixpkgs> { }
, callPackage ? pkgs.callPackage
}:

let
  cargoNix = callPackage ./Cargo.nix {
    defaultCrateOverrides = pkgs.defaultCrateOverrides // {
      git2 = attrs: {
        buildInputs = [ pkgs.openssl ];
      };
      libgit2-sys = attrs: {
        buildInputs = [ pkgs.openssl pkgs.cacert ];
      };
    };
  };

  foo = cargoNix.rootCrate.build;
in
pkgs.symlinkJoin {
  name = foo.name;
  version = foo.crateVersion;
  paths = [ foo ];

  postBuild = ''
    rm -rf $out/bin/foo.d
  '';
}
