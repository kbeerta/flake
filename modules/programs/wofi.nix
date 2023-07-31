{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi
  ];

  home.file = {
    ".config/wofi/config" = {
      text=''
        width=280
	lines=10
	xoffset=5
	yoffset=5
	location=1
	prompt=Search...
	filter_rate=100
	allow_markup=false
	no_actions=true
	halign=fill
	orientation=vertical
	content-halign=fill
	insensitive=true
	hide_scroll=true
      '';
    };
  };
}
