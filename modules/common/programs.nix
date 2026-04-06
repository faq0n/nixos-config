{ pkgs, ... }:
{
   environment.systemPackages = with pkgs; [
     # add packages according to alphabet
	
     nixfmt-tree
     textadept
     just
     minio-client
     pwgen
  ];

}
