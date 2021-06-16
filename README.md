# NixOS Config

To setup:

1. Install [dotfiles](https://github.com/Ruin0x11/dotfiles) manually under `/home/nori`. (no home-manager).
2. Symlink vim configuration to `/root`.
3. Setup [server\_config](https://github.com/Ruin0x11/meguca_server) under `/home/nori/build/server_config`.
4. Setup [evergarden](https://github.com/Ruin0x11/evergarden) under `/home/nori/build/work/evergarden`. Edit `evergarden.rb` with szurubooru auth token.
5. `docker network create misaka`
6. Mount ZFS pool, set as legacy mount. Regenerate hardware configuration.
7. Go ham.
