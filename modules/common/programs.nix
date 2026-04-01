{ pkgs, ... }:
{
   environment.systemPackages = with pkgs; [
     # add packages according to alphabet

     textadept
     just
     minio-client
     pwgen
  ];

}
