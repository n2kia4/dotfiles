#!/bin/bash

# Load utils
. setup/utils.sh

print_title "System Preferences"

dashboard() {
    # Disable Dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true

    killall "Dock" &> /dev/null

    print_success "Dashboard"
}

dock() {
    # Automatically hide/show the Dock
    defaults write com.apple.dock autohide -bool true

    # Enable spring loading for all Dock items
    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

    # Don’t group windows by application in Mission Control
    defaults write com.apple.dock expose-group-by-app -bool false

    # Change minimize/maximize window effect
    defaults write com.apple.dock mineffect -string 'scale'

    # Minimize windows into their application’s icon
    defaults write com.apple.dock minimize-to-application -bool true

    # Don’t automatically rearrange Spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Show indicator lights for open applications
    defaults write com.apple.dock show-process-indicators -bool true

    # Make icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true

    # Set icon size
    defaults write com.apple.dock tilesize -int 50

    killall "Dock" &> /dev/null

    print_success "Dock"
}

finder() {
    # Allow quitting via ⌘ + Q; doing so will also hide desktop icons
    defaults write com.apple.finder QuitMenuItem -bool true

    # Disable all animations
    defaults write com.apple.finder DisableAllAnimations -bool true

    # Show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Use full POSIX path as window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Use list view in all Finder windows by default
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false

    killall "Finder" &> /dev/null
    
    killall "cfprefsd" &> /dev/null

    print_success "Finder"
}

keyboard() {
    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    # Disable press-and-hold for keys in favor of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    # Set a blazingly fast keyboard repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 10

    # Disable automatic capitalization
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

    # Disable smart dashes
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

    # Disable automatic period substitution
    defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

    # Disable smart quotes
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

    print_success "Keyboard"
}

safari() {
    # Disable opening 'safe' files automatically
    defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

    # Set backspace key to go to the previous page in history
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

    # Enable the 'Develop' menu and the 'Web Inspector'
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

    # Set search type to 'Contains' instead of 'Starts With
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

    # Set home page to 'about:blank'
    defaults write com.apple.Safari HomePage -string 'about:blank'

    # Enable 'Debug' menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Hide bookmarks bar by default
    defaults write com.apple.Safari ShowFavoritesBar -bool false

    # Show the full URL in the address bar
    defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

    # Don’t send search queries to Apple
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true
    defaults write com.apple.Safari UniversalSearchEnabled -bool false

    # Add a context menu item for showing the 'Web Inspector' in web views
    defaults write -g WebKitDeveloperExtras -bool true

    killall "Safari" &> /dev/null

    print_success "Safari"
}

terminal() {
    # Make the focus automatically follow the mouse
    defaults write com.apple.terminal FocusFollowsMouse -string true

    # Only use UTF-8
    defaults write com.apple.terminal StringEncodings -array 4

    # Use a modified version of the Solarized Dark theme by default
    . setup/preferences/set_solarized.applescript

    print_success "Terminal"
}

trackpad() {
    # Enable tap to click
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    print_success "Trackpad"
}

ui_and_ux() {
    # Avoid creating `.DS_Store` files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # Hide battery percentage from menubar
    defaults write com.apple.menuextra.battery ShowPercent -string "NO"

    # Disable 'Are you sure you want to open this application?' dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true

    # Always show scrollbars
    defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

    # Disable automatic termination of inactive apps
    defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    
    # Set sidebar icon size to medium
    defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

    # Disable the over-the-top focus ring animation
    defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

    # Disable resume system-wide
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

    # Restart automatically if the computer freezes
    sudo systemsetup -setrestartfreeze on

    # Show language menu in the top right corner of the boot screen
    sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool true

    # Save screenshots to the Desktop
    defaults write com.apple.screencapture location -string '$HOME/Desktop'

    # Save screenshots in PNG
    defaults write com.apple.screencapture type -string 'png'

    # Require password immediately after sleep or screen saver begins
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    # Enable subpixel font rendering on non-Apple LCDs
    defaults write NSGlobalDomain AppleFontSmoothing -int 1

    killall "SystemUIServer" &> /dev/null

    print_success "UI & UX"
}

dashboard
dock
finder
keyboard
safari
terminal
trackpad
ui_and_ux
