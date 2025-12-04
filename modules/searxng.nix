{ config, lib, pkgs, ... }:

let
  cfg = config.services.mySearxng;
in
{
  options.services.mySearxng = {
    enable = lib.mkEnableOption "Enable custom SearXNG instance";

    domain = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Domain name for reverse proxy. Leave empty for no proxy.";
    };

    port = lib.mkOption {
      type = lib.types.int;
      default = 8080;
      description = "Port SearXNG will listen on.";
    };

    secretKey = lib.mkOption {
      type = lib.types.str;
      default = "changeme-super-secret";
      description = "Secret key for SearXNG.";
    };

    enableRedis = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Redis and use it for rate-limiting & caching.";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Extra SearXNG settings merged with defaults.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Redis (optional)
    services.redis = lib.mkIf cfg.enableRedis {
      enable = true;
    };

    # Core SearXNG config
    services.searxng = {
      enable = true;

      settings = {
        server = {
          port = cfg.port;
          bind_address = "127.0.0.1";
          secret_key = cfg.secretKey;
        };

        # Add redis if enabled
        limiter = lib.mkIf cfg.enableRedis {
          backend = "redis";
          host = "localhost";
          port = 6379;
        };
      } // cfg.settings;  # merge user overrides
    };

    # Optional Reverse Proxy
    services.nginx = lib.mkIf (cfg.domain != "") {
      enable = true;
      virtualHosts.${cfg.domain} = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString cfg.port}/";
        };
      };
    };

    # ACME for TLS
    security.acme = lib.mkIf (cfg.domain != "") {
      acceptTerms = true;
      defaults.email = "admin@${cfg.domain}";
    };
  };
}

