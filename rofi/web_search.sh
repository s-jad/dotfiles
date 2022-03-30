#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      web-search.sh
#   created:   24.02.2017.-08:59:54
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   rofi
# Description:
#   Use rofi to search the web.
# Usage:
#   web-search.sh
# -----------------------------------------------------------------------------
# Script:

declare -A URLS

URLS=(
  ["google"]="https://www.google.com/search?q="
  ["bing"]="https://www.bing.com/search?q="
  ["duckduckgo"]="https://www.duckduckgo.com/?q="
  ["yandex"]="https://yandex.ru/yandsearch?text="
  ["github"]="https://github.com/search?q="
  ["stackoverflow"]="https://stackoverflow.com/search?q="
  ["searchcode"]="https://searchcode.com/?q="
  ["openhub"]="https://www.openhub.net/p?ref=homepage&query="
  ["superuser"]="https://superuser.com/search?q="
  ["askubuntu"]="https://askubuntu.com/search?q="
  ["arch package"]="https://archlinux.org/packages/?sort=&q="
  ["archwiki"]="https://wiki.archlinux.org/title/"
  ["amazon.de"]="https://www.amazon.de/s?k="
  ["youtube"]="https://www.youtube.com/results?search_query="
  ["vimawesome"]="https://vimawesome.com/?q="
  ["libgen"]="https://libgen.rs/search.php?req="
  ["sci-hub"]="https://sci-hub.se/search.php?req="
  ["cyberchef"]="https://gchq.github.io/CyberChef/#recipe=Magic(3,true,false,'')&input="
  ["moodle"]="https://moodle.univie.ac.at/theme/university_boost/login/index.php"
)

# List for rofi
gen_list() {
    for i in "${!URLS[@]}"
    do
      echo "$i"
    done
}

main() {
  # Pass the list to rofi
  platform=$( (gen_list) | rofi -dmenu -matching fuzzy -no-custom -location 0 -p "Search > " )

  if [[ -n "$platform" ]]; then
    query=$( (echo ) | rofi  -dmenu -matching fuzzy -location 0 -p "Query > " )

    if [[ -n "$query" ]]; then
      url=${URLS[$platform]}$query
      xdg-open "$url"
    else
      url=${URLS[$platform]}
      xdg-open "$url"
    fi

  else
    exit
  fi
}

main

exit 0
