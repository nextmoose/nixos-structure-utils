{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs" ; flake-utils.url = "github:numtide/flake-utils"; } ;
  outputs =
    { self , nixpkgs , flake-utils } :
      flake-utils.lib.eachDefaultSystem
      (
        system :
          let
            pkgs = builtins.getAttr system nixpkgs.legacyPackages ;
            in
            {
              lib =
	        {
		  dollar = expression : builtins.concatStringsSep "" [ "$" "{" ( type "string" expression ) "}" ] ;
		  try =
		    trial :
		      let
		        test =
			  seed :
			    let
		              predicate = type "bool" ( builtins.getAttr "predicate" result ) ;
			      result = type "set" ( trial seed ) ;
			      in if predicate then builtins.getAttr "value" result else trial ( seed + 1 ) ;
		      in trial 0 ;
		    throw =
		      uuid : message :
		        if builtins.typeOf uuid == "string" && builtins.typeOf message == "string" then builtins.throw "${ uuid }:  ${ message }"
			else if builtins.typeOf uuid == "string" then builtins.throw ${ uuid }
			else if builtins.tryEval builtins.toString uuid then builtins.throw ${ builtins.toString uuid }
			else builtins.throw "8bdfb521-586d-455a-8fb4-157163d84372" ;
		    type =
		      type : value :
		        if builtins.typeOf value == builtins.toString ( type ) then value else throw "b7d9dfe4-90a7-426e-a15b-c10124e1c3d4" "Value is a ${ builtins.typeOf value } not a ${ builtins.toString type }." ;
	        } ;
            }
      ) ;
}
