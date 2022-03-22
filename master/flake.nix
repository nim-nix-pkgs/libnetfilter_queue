{
  description = ''libnetfilter_queue wrapper for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-libnetfilter_queue-master.flake = false;
  inputs.src-libnetfilter_queue-master.ref   = "refs/heads/master";
  inputs.src-libnetfilter_queue-master.owner = "ba0f3";
  inputs.src-libnetfilter_queue-master.repo  = "libnetfilter_queue.nim";
  inputs.src-libnetfilter_queue-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-libnetfilter_queue-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-libnetfilter_queue-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}