#!/bin/sh

# Disable access control for the current user
xhost +SI:localuser:$USER

# Make Java applications aware this is a non-reparenting window manager
export _JAVA_AWT_WM_NONREPARENTING=1

# Set XDG_DATA_DIRS because something in Manjaro broke it :/
#export XDG_DATA_DIRS="/usr/share:$XDG_DATA_DIRS"

# Start authentication daemons
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent /bye

# Make Flatpak apps visible to launcher
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share"

# Make things look nice
compton &
nitrogen --restore &

# Start the PulseAudio daemon to run persistently
pulseaudio --daemonize

# Start Xfce's settings manager
xfsettingsd &

# Turn off the system bell
xset -b

# Remap caps lock to ctrl
setxkbmap -layout us -option ctrl:nocaps

# Load system tray apps
nm-applet &

# Enable Manjaro update checks
#pamac-tray &

# Enable screen locking on suspend
xss-lock -- slock &

# We're in Emacs, yo
export VISUAL=emacsclient
export EDITOR="$VISUAL"

# Fire it up
exec dbus-launch --exit-with-session emacs -mm --use-exwm
