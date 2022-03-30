if status is-interactive
    # Commands to run in interactive sessions can go here
end

########################### ALIASES #################################

# Get around and see the filesystem better

alias ls="exa -al --color=always --group-directories-first --icons"
alias lt="exa -aT --color=always --group-directories-first --icons"
alias l.="exa -a | egrep "^.""

alias lsd="lsd -la"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias lf="lfub"

# Manage Pacman

alias pacsyu="sudo pacman -Syu && sudo rkhunter --update --propupd"
alias pacsyyu="sudo pacman -Syyu && sudo rkhunter --update --propupd"
alias paclean="sudo pacman -Rns (pacman -Qtdq)"
alias pamirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

# Check AwesomeWM not broken after reconfiguring

alias awcheck="awesome -k && Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome"
alias dwcheck="dwm -k && Xephyr :5 & sleep 1 ; DISPLAY=:5 dwm"

# Doom Emacs Functions

alias emacs="emacsclient -c -a 'emacs'"
alias ebug="emacs --debug-init"
alias dcfg="emacs ~/.doom.d/config.el"
alias dpfg="emacs ~/.doom.d/packages.el"
alias difg="emacs ~/.doom.d/init.el"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"

# MISC

alias v="lvim"
alias rkhunter="sudo rkhunter --versioncheck --update --rwo --sk --check"
alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# System Info

alias df="df -h"
alias free="free -m"
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem="ps auxf | sort -nr -k 4"
alias pscpu="ps auxf | sort -nr -k 3"
alias prcpu="procs --sortd cpu --theme dark"
alias jctl="journalctl -p 3 -xb"

# GPG Encryption

alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
alias gpg-get="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

####################### CONFIG FILE ACCESS #########################

alias kcfg="lvim ~/.config/kitty/kitty.conf"
alias fcfg="lvim ~/.config/fish/config.fish"
alias acfg="lvim ~/.config/awesome/rc.lua"
alias atcfg="lvim ~/.config/awesome/themes/powerarrow-dark/theme.lua"
alias pcfg="sudo lvim /etc/pacman.conf"
alias rccfg="lvim ~/.config/rofi/config.rasi"
alias rtcfg="lvim ~/.config/rofi/arthur.rasi"
alias vcfg="lvim ~/.config/lvim/config.lua"
alias alacfg="lvim ~/.config/alacritty/alacritty.yml"
alias ccfg="lvim ~/.config/picom/picom.conf"
alias lffg="lvim ~/.config/lf/lfrc"

######################### CALENDAR ################################

alias day="calcurse -a"
alias week="calcurse -a -d 7 | bat"
alias month="calcurse -a -d 31 | bat"

#################### SET BAT AS MANPAGER ##########################

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

########################## MISC ###################################

set -gx EDITOR lvim
alias obsidian="firejail --net=none obsidian"

# Stop Redshift from needing geoclue
# (why do I need to get tracked to control
# the RGB levels of my screen?)

alias redshift="redshift -P -O"

alias brave="firejail --profile=/etc/firejail/brave-browser.profile brave"

####################### FUNCTIONS #################################

# Access cheat.sh online manpages

function cheat --argument target
  curl cheat.sh/$target
end

# Ensure you use the python installer from you venv, not system-wide

function pynstall --argument package
  /home/sam/Programming/Python/automation-env/bin/python -m pip install $package
end

# Quickly create a backup

function backup --argument filename
  cp $filename ~/Backups/$filename.BACKUP
end

# Allow btop to run

function btop --description 'alias btop=btop --utf-force'
    command btop --utf-force $argv
end

# Full rookit hunter checks, updates and scans

function rkit --wraps='sudo rkhunter --update --versioncheck -c --rwo --sk' --description 'alias rkit=sudo rkhunter --update --versioncheck -c --rwo --sk'
    sudo rkhunter --update --versioncheck -c --rwo --sk $argv
end

function fish_update_completions --description 'Update man-page based completions'
  # Don't write .pyc files, use the manpath, clean up old completions
  # display progress.
  set -l update_args -B $__fish_data_dir/tools/create_manpage_completions.py --manpath --cleanup-in ~/.config/fish/generated_completions --progress $argv
    if set -l python (__fish_anypython)
        $python $update_args
    else
        printf "%s\n" (_ "python executable not found")
        return 1
    end
end

########################### PROMPT ####################################

#starship init fish | source

function fish_right_prompt -d "Write out the right prompt"
  set -l exit_code $status
  set -l is_git_repository (git rev-parse --is-inside-work-tree 1> /dev/null)
  set -l max_shlvl 0; and test "$TERM" = "screen"; and set -l max_shlvl 2

  # Print a fork symbol when in a subshell
  if test $SHLVL -gt $max_shlvl
    set_color yellow
    echo -n "⑂ "
    set_color normal
  end

  # Print a red dot for failed commands.
  if test $exit_code -ne -1
    set_color red
    echo -n "• "
    set_color normal
  end

  # Print the username when the user has been changed.
  if test $USER != $LOGNAME
    set_color black
    echo -n "$USER@"
    set_color normal
  end

  set_color normal
end

########################## VIM-FISH ####################################

fish_vi_key_bindings
#fish_default_key_bindings

