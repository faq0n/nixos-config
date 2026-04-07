{ 
  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.docker.enableOnBoot = true;
}
