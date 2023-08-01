{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi
  ];

  home.file = {
    ".config/wofi/config".text = ''
      width=280
      lines=10
      xoffset=5
      yoffset=5
      location=1
      prompt=Search..
      filter_rate=100
      allow_markup=false
      no_actions=true
      halign=fill	
      orientation=vertical
      content-halign=fill
      insensitive=true
      hide_scroll=true
    '';
    ".config/wofi/style.css".text = ''
      * {
        font-family: JetBrainsMono Nerd Font;
      }

      window {
        margin: 0px;
	background-color: rgba(17, 17, 17, 1);
	color: rgba(246, 244, 244, 1);
      }

      #input {
        all: unset;
	min-height: 20px;
	padding: 4px 10px;
	margin: 4px;
	border: none;
	color: rgba(246, 244, 244, 1);
	font-weight: bold;
	background-color: rgba(17, 17, 17, 1);
	outline: rgba(246, 244, 244, 1);
      }

      #inner-box {
        font-weight: bold;
	border-radius: 0px;
      }

      #outer-box {
        margin: 0px;
	padding: 3px;
	border: none;
	border: 1px solid rgba(246, 244, 244, 1);
      }

      #text:selected {
        background-color: rgba(31, 31, 31, 1);
	color: rgba(246, 244, 244, 1);
      }

      #entry:selected {
        background-color: rgba(31, 31, 31, 1);
      }
    '';
  };
}
