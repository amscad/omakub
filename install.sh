# Exit immediately if a command exits with a non-zero status
set -e


# Function to detect the desktop environment
detect_desktop_environment() {
    if [ -n "$XDG_CURRENT_DESKTOP" ]; then
        echo "Desktop Environment: $XDG_CURRENT_DESKTOP"
        return 0
    elif [ -n "$GNOME_DESKTOP_SESSION_ID" ]; then
        echo "Desktop Environment: GNOME"
        return 0
    elif [ -n "$KDE_FULL_SESSION" ]; then
        echo "Desktop Environment: KDE"
        return 0
    elif [ -n "$MATE_DESKTOP_SESSION_ID" ]; then
        echo "Desktop Environment: MATE"
        return 0
    elif [ -n "$XDG_SESSION_DESKTOP" ]; then
        echo "Desktop Environment: $XDG_SESSION_DESKTOP"
        return 0
    else
        echo "Desktop Environment: Unknown"
        return 1
    fi
}

# Detect if any desktop environment is running
if detect_desktop_environment; then
    DESKTOP_RUNNING=true
else
    DESKTOP_RUNNING=false
fi

# Desktop software and tweaks will only be installed if we're running Gnome
# RUNNING_GNOME=$([[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] && echo true || echo false)

# Check the distribution name and version and abort if incompatible
source ~/.local/share/omakub/install/check-version.sh

# if $RUNNING_GNOME; then
if $DESKTOP_RUNNING; then
  # Ensure computer doesn't go to sleep or lock while installing
  gsettings set org.gnome.desktop.screensaver lock-enabled false
  gsettings set org.gnome.desktop.session idle-delay 0

  echo "Get ready to make a few choices..."
  source ~/.local/share/omakub/install/terminal/required/app-gum.sh >/dev/null
  source ~/.local/share/omakub/install/first-run-choices.sh

  echo "Installing terminal and desktop tools.."
else
  echo "Only installing terminal tools..."
fi

# Install terminal tools
source ~/.local/share/omakub/install/terminal.sh

# if $RUNNING_GNOME; then
if $DESKTOP_RUNNING; then
  # Install desktop tools and tweaks
  source ~/.local/share/omakub/install/desktop.sh

  # Revert to normal idle and lock settings
  gsettings set org.gnome.desktop.screensaver lock-enabled true
  gsettings set org.gnome.desktop.session idle-delay 300
fi
