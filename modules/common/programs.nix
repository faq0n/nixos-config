{ pkgs, ... }:
{
   environment.systemPackages = with pkgs; [
     # add packages according to alphabet

     just
     minio-client
     pwgen
  ];

}
