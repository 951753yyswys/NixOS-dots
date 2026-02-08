{ pkgs, inputs, ... }:
let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (pkgs.lib.splitString " " cmd);
in
{
  imports = [ inputs.niri.nixosModules.niri ];
  programs.niri.enable = true;
  home-manager.users.Qaaxaap = 
    { config, lib, ... }:
    {
      programs = {
        niri = {
	  settings = {
	    spawn-at-startup = [
	      {
	        command = [
		  "noctalia-shell"
		];
	      }
	    ];
	    binds = with config.lib.niri.actions; {
	      "Mod+Return".action.spawn = "kitty";
	      "Mod+A".action.spawn = noctalia "launcher toggle";
	    };
	  };
	};
      };
    };
}
