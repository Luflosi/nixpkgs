{ testers, fetchipfs, ... }:

let
  url = "https://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz";
  ipfs = "QmXPGg3wEu8WT3MRqtNCynbESgyTxNj2RNkdRtqwdjiuFY";
  #ipfs = "QmUXj4zS3dqbdmASP3DThRhUPrGSYhzc9jtSW7o2MVfw5K";
  #ipfs = "QmWyj65ak3wd8kG2EvPCXKd6Tij15m4SwJz6g2yG2rQ7w8"; Why is this wrong??
in
{
  simple = testers.invalidateFetcherByDrvHash fetchipfs {
    inherit url ipfs;
    sha256 = "sha256-tBws6cfY1e23oTv3qu2Oc1Q6ev1YtUrgAmGS6uh7ocY=";
  };

  postFetch = testers.invalidateFetcherByDrvHash fetchipfs {
    inherit url ipfs;
    sha256 = "sha256-SIRbJwZ7eMq97XqEVCV9AvZW0hn7DX5YN0VLHylMqrg=";
    postFetch = ''
      touch $out/file
    '';
  };
}
