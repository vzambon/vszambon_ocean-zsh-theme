# Zsh Theme: vszambon-ocean
![vszambon_ocean example](https://raw.githubusercontent.com/vzambon/vszambon_ocean-zsh-theme/main/Screenshot%20from%202024-08-16%2002-29-36.png)

## Description
This Zsh theme provides a visually appealing and functional command prompt with the features:

- **Docker Indicator**: Displays a whale emoji `🐳` if running inside Docker, indicated by the global variable `RUNNING_IN_DOCKER` set to `"true"`.
- **Git Indicator**: Displays the prefix `🐙` to indicate the presence of a Git repository, with the emoji changing based on repository status.
- **Git Status**: Shows Git repository status with custom icons and colors. 
	- **Clean**: ✔ (Green)
	- **Added**: ✚ (Green)
	- **Modified**: ✹ (Blue)
	- **Deleted**: ✖ (Red)
	 - **Renamed**: ➜ (Magenta)
	 - **Unmerged**: ═ (Yellow)
	 - **Untracked**: ? (Cyan)
- **Day/Night Icon**: Displays different moon phases based on the current hour:
	 - **🌑** New Moon: 00:00 - 03:00
	- **🌒** Waxing Crescent: 03:00 - 06:00
	- **🌓** First Quarter: 06:00 - 09:00
	- **🌔** Waxing Gibbous: 09:00 - 12:00
	- **🌕** Full Moon: 12:00 - 15:00
	- **🌖** Waning Gibbous: 15:00 - 18:00
	- **🌗** Last Quarter: 18:00 - 21:00
	- **🌘** Waning Crescent: 21:00 - 00:00
- **Weekday and Date Format**: Displays the current weekday, month, and day in `Weekday,Month-Day` format.

## Installation

- **Save the Theme**: 
```
curl https://raw.githubusercontent.com/vzambon/vszambon_ocean-zsh-theme/main/vszambon_ocean.zsh-theme -o $ZSH_CUSTOM/themes/vszambon_ocean.zsh-theme
```
- **Set the Theme**:
Edit your .zshrc file
```
ZSH_THEME="vszambon_ocean"
```
