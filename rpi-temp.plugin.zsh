# Load Zsh colors
autoload -U colors && colors

RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
RESET=$reset_color

rpi-temp() {
  if ! command -v vcgencmd &> /dev/null; then
    echo "${RED}[ERROR]${RESET} This only works on Raspberry Pi!"
    return 1
  fi
  
  temp_raw=$(vcgencmd measure_temp | grep -o '[0-9]*\.[0-9]*')

  if (( $(echo "$temp_raw > 75") )); then
    color=$RED
  elif (( $(echo "$temp_raw > 60") )); then
    color=$YELLOW
  else
    color=$GREEN
  fi
  
  echo "🌡️  Raspberry Pi Temp: ${color}${temp_raw}°C${RESET}"
}
