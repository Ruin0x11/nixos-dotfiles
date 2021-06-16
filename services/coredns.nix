{ config, pkgs, ... }:

{
  services.coredns.enable = true;
  services.coredns.config = ''
    . {
      # Cloudflare and Google
      forward . 8.8.8.8 8.8.4.4
      cache
    }

    daikon {
      template IN A  {
          answer "{{ .Name }} 0 IN A 192.168.1.100"
      }
    }
  '';
}
