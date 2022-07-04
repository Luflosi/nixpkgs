{ testers, fetchipfs, ... }:

let
  url = "https://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz";
  ipfs = "QmWyj65ak3wd8kG2EvPCXKd6Tij15m4SwJz6g2yG2rQ7w8";
in
{
  simple = testers.invalidateFetcherByDrvHash fetchipfs {
    inherit url ipfs;
    sha256 = "1im1gglfm4k10bh4mdaqzmx3lm3kivnsmxrvl6vyvmfqqzljq75l";
  };

  postFetch = testers.invalidateFetcherByDrvHash fetchipfs {
    inherit url ipfs;
    sha256 = "sha256-7sAOzKa+9vYx5Xy0dHxeY2ffWAjOsgCkXC9anK6cuV0=";
    postFetch = ''touch $out/file'';
  };
}
