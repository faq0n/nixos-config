# ./template-module.nix
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.browser;
in {
  options.programs.browser = {
    
    # thanks to with lib; we can shorten mkEnableOption
    enable = mkEnableOption "toggle the appropiate browser";

    package = mkOption {
      type = types.package;
      default = pkgs.firefox;
      defaultText = literalExpression "pkgs.firefox";
      description = "browser package to use.";
    };

    extraConfig = mkOption {
      default = "";
      example = ''
        ON_WAYLAND=true
      '';
      type = types.lines;
      description = ''
        Extra settings for wayland
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    #xdg.configFile."foo/foorc" = mkIf (cfg.extraConfig != "") {
    #  text = ''
    #    ${cfg.extraConfig}
    #  '';
    #};
  };
}
