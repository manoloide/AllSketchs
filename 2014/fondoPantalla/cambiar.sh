#!/bin/bash

clear 

echo "Cambiar fondo"
	
DIR="$HOME/Dropbox(Wannabe)/2014/fondoPantalla/image"
RPIC=$(ls $DIR/* | shuf -n1)

PIC=${1:-RPIC} 
echo $PIC

gsettings set org.gnome.desktop.background picture-options "spanned"
gsettings set org.gnome.desktop.background picture-uri "file://$PIC" 

#gconftool -t string -s /desktop/gnome/background/picture_filename "$PIC"
#pcmanfm --set-wallpaper=$PIC

#defaults write com.apple.desktop Background "{default = {ImageFilePath='$PIC'; };}"; killall Dock
