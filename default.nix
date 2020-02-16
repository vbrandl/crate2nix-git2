{ pkgs ? import <nixpkgs> { }
, callPackage ? pkgs.callPackage
}:

let
  cargoNix = callPackage ./Cargo.nix {
    defaultCrateOverrides = pkgs.defaultCrateOverrides // {
      # git2 = attrs: {
      #   buildInputs = [ pkgs.openssl ];
      # };
      libgit2-sys = attrs: {
        features = [
          "default"
          "https"
          # "vendored-openssl"
        ];
        # propagatedBuildInputs = [
        #   pkgs.openssl
        # ];
        buildInputs = [
          pkgs.openssl
          # pkgs.cacert
          pkgs.pkg-config
          pkgs.libgit2
          pkgs.zlib
          pkgs.curl
        ];
      };
    };
  };

  foo = cargoNix.rootCrate.build;
in
pkgs.symlinkJoin {
  name = foo.name;
  version = foo.crateVersion;
  paths = [ foo ];
  buildInputs = [
    pkgs.git
    pkgs.libgit2
    pkgs.zlib
    pkgs.cacert
    pkgs.curl
  ];

  postBuild = ''
    rm -rf $out/bin/crate2nix_git2.d
  '';
}
