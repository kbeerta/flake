{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi
  ];

  home.file = {
    ".config/wofi/config".text = ''
      width=380
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

      #window {
        margin: 0px;
	    background-color: rgba(17, 17, 17, 0.8);
	    color: #FDF8ED;
      }

      #input {
        all: unset;
	    min-height: 20px;
	    padding: 4px 10px;
	    margin: 4px;
	    border: none;
	    color: #FDF8ED;
	    font-weight: bold;
	    background-color: rgba(17, 17, 17, 0.8);
	    outline: #F16A87;
      }

      #input:focus {
	    background-color: rgba(17, 17, 17, 0.8);
      }

      #inner-box {
        font-weight: bold;
	    border-radius: 0px;
      }

      #outer-box {
        margin: 0px;
	padding: 3px;
	border: none;
	border: 1px solid #FCF8ED;
      }

    #text {
        color: #FCF8ED;
    }

      #text:selected {
        background-color: F16A87;
    	color: #FCF8ED;
      }

      #entry:selected {
        background-color: #222222;
      }
    '';
  };
}
