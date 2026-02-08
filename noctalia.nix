{ pkgs, inputs, ... }:
{
  home-manager.users.Qaaxaap = {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    programs.noctalia-shell = {
      enable = true;
      settings = {
        bar = {
          density = "compact";
          position = "left";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
            ];
            center = [
              {
	        hideUnoccupied = false;
		id = "Workspace";
		iabelMode = "none";
              }
            ];
	    right = [
	      {
	        alwaysShowPercentage = false;
		id = "Battery";
		warningThreshold = 30;
	      }
	      {
	        formatHorizontal = "HH:mm";
		formatVertical = "HH mm";
		id = "Clock";
		useMonospacedFont = true;
		usePrimaryColor = true;
	      }
	    ];
          };
        };
	colorSchemes.predefinedScheme = "Monochrome";
	general = {
	  avatarImage = "/home/Qaaxaap/.face";
	  radiusRatio = 0.2;
	};
	location = {
	  monthBeforDay = true;
	  name = "Xi'an, China";
	};
      };
    };
  };
}
