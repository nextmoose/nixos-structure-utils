{ pkgs ? import ( fetchTarball "https://github.com/NixOS/nixpkgs/archive/bf972dc380f36a3bf83db052380e55f0eaa7dcb6.tar.gz" ) {} } :
  pkgs.mkShell
    {
      buildInputs =
        [
	  pkgs.emacs
	  pkgs.coreutils
	  pkgs.git
	] ;
      shellHook =
        ''
	  ${ pkgs.coreutils }/bin/echo STRUCTURE FLAKE DEVELOPMENT UTILITIES ENVIRONMENT
	'' ;
    }
