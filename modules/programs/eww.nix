#
# Eww
#
# Gets imported in Window Manager
#

{ config, lib, pkgs, user, ...}:
{
  home.packages = with pkgs; [
    eww-wayland
  ];

  home.file = {
      ".config/eww/eww.yuck".text = ''
      (defwidget bar []
  (centerbox :orientation "h"
    (workspaces)
    (music)
    (sidestuff)))

(defwidget sidestuff []
  (box :class "sidestuff" :orientation "h" :space-evenly false :halign "end"
    (metric :label "🔊"
            :value volume
            :onchange "amixer -D pulse sset Master {}%")
    (metric :label ""
            :value {EWW_RAM.used_mem_perc}
            :onchange "")
    (metric :label "💾"
            :value {round((1 - (EWW_DISK["/"].free / EWW_DISK["/"].total)) * 100, 0)}
            :onchange "")
    time))

(defwidget workspaces []
  (box :class "workspaces"
       :orientation "h"
       :space-evenly true
       :halign "start"
       :spacing 10
    (button :onclick "wmctrl -s 0" 1)
    (button :onclick "wmctrl -s 1" 2)
    (button :onclick "wmctrl -s 2" 3)
    (button :onclick "wmctrl -s 3" 4)
    (button :onclick "wmctrl -s 4" 5)
    (button :onclick "wmctrl -s 5" 6)
    (button :onclick "wmctrl -s 6" 7)
    (button :onclick "wmctrl -s 7" 8)
    (button :onclick "wmctrl -s 8" 9)))

(defwidget music []
  (box :class "music"
       :orientation "h"
       :space-evenly false
       :halign "center"
    {music != "" ? "🎵$${music}" : ""}))


(defwidget metric [label value onchange]
  (box :orientation "h"
       :class "metric"
       :space-evenly false
    (box :class "label" label)
    (scale :min 0
           :max 101
           :active {onchange != ""}
           :value value
           :onchange onchange)))



(deflisten music :initial ""
  "playerctl --follow metadata --format '{{ artist }} - {{ title }}' || true")

(defpoll volume :interval "1s"
  "scripts/getvol")

(defpoll time :interval "10s"
  "date '+%H:%M %b %d, %Y'")

(defwindow bar
  :monitor 0
  :windowtype "dock"
  :geometry (geometry :x "0%"
                      :y "0%"
                      :width "90%"
                      :height "10px"
                      :anchor "top center")
  :reserve (struts :side "top" :distance "4%")
  (bar))
      '';
      ".config/eww/eww.scss".text = ''
      * {
  all: unset; //Unsets everything so you can style everything from scratch
}

//Global Styles
.bar {
  background-color: #3a3a3a;
  color: #b0b4bc;
  padding: 10px;
}

// Styles on classes (see eww.yuck for more information)

.sidestuff slider {
  all: unset;
  color: #ffd5cd;
}

.metric scale trough highlight {
  all: unset;
  background-color: #D35D6E;
  color: #000000;
  border-radius: 10px;
}
.metric scale trough {
  all: unset;
  background-color: #4e4e4e;
  border-radius: 50px;
  min-height: 3px;
  min-width: 50px;
  margin-left: 10px;
  margin-right: 20px;
}
.metric scale trough highlight {
  all: unset;
  background-color: #D35D6E;
  color: #000000;
  border-radius: 10px;
}
.metric scale trough {
  all: unset;
  background-color: #4e4e4e;
  border-radius: 50px;
  min-height: 3px;
  min-width: 50px;
  margin-left: 10px;
  margin-right: 20px;
}
.label-ram {
  font-size: large;
}
.workspaces button:hover {
  color: #D35D6E;
}

* {
      all: unset; //Unsets everything so you can style everything from scratch
}

//Global Styles
.bar {
      background-color: #3a3a3a;
        color: #b0b4bc;
          padding: 10px;
}

// Styles on classes (see eww.yuck for more information)

.sidestuff slider {
      all: unset;
        color: #ffd5cd;
}

.metric scale trough highlight {
      all: unset;
        background-color: #D35D6E;
          color: #000000;
            border-radius: 10px;
}
.metric scale trough {
      all: unset;
        background-color: #4e4e4e;
          border-radius: 50px;
            min-height: 3px;
              min-width: 50px;
                margin-left: 10px;
                  margin-right: 20px;
}
.metric scale trough highlight {
      all: unset;
        background-color: #D35D6E;
          color: #000000;
            border-radius: 10px;
}
.metric scale trough {
      all: unset;
        background-color: #4e4e4e;
          border-radius: 50px;
            min-height: 3px;
              min-width: 50px;
                margin-left: 10px;
                  margin-right: 20px;
}
.label-ram {
      font-size: large;
}
.workspaces button:hover {
      color: #D35D6E;
}

      '';
      ".config/eww/scripts/getvol".text = ''
        pamixer --get-volume
      '';
  };
}

