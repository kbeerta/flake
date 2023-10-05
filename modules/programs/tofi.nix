{ pkgs, ...}:
{
  home.packages = with pkgs; [
    tofi
  ]; 

  xdg.configFile."tofi/config".text = ''
    font = "JetBrainsMono Nerd Font Medium"
    font-size = 16

    default-result-background = #111111

    placeholder-background = #111111
    placeholder-color = #EEEEEE

    prompt-background = #111111
    input-background = #111111

    # selection-color = #D6365D
    selection-color = #CE6F7A

    background-color = #111111
    outline-width = 0
    border-width = 0
    corner-radius = 5

    width = 640
    height = 360
  '';
}
