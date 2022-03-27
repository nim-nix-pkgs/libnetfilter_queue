{
  description = ''libnetfilter_queue wrapper for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-libnetfilter_queue-0_1_0.flake = false;
  inputs.src-libnetfilter_queue-0_1_0.ref   = "refs/tags/0.1.0";
  inputs.src-libnetfilter_queue-0_1_0.owner = "ba0f3";
  inputs.src-libnetfilter_queue-0_1_0.repo  = "libnetfilter_queue.nim";
  inputs.src-libnetfilter_queue-0_1_0.dir   = "";
  inputs.src-libnetfilter_queue-0_1_0.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-libnetfilter_queue-0_1_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-libnetfilter_queue-0_1_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}