{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi
  ];

  home.file = {
    ".config/wofi/config".text = ''
      width=280
      lines=10
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
	    background-color: #111111;
	    color: #FDF3ED;
      }

      #input {
        all: unset;
	min-height: 20px;
	padding: 4px 10px;
	margin: 4px;
	border: none;
	color: #FDF3ED;
	font-weight: bold;
	background-color: #111111;
	    outline: #F16A87;
      }

      #inner-box {
        font-weight: bold;
	    border-radius: 0px;
      }

      #outer-box {
        margin: 0px;
	padding: 3px;
	border: none;
	border: 1px solid #F16A87;
      }

    #text {
        color: #C9C2BD;
    }

      #text:selected {
        background-color: F16A87;
	color: #FDF3ED;
      }

      #entry:selected {
        background-color: F16A87;
      }
    '';
  };
}
