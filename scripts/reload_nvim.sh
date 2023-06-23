#!/bin/bash

is_integer() {
    case "${1#[+-]}" in
    *[!0123456789]*)
        printf ""
        ;;
    '')
        printf ""
        ;;
    0)
        printf "0"
        ;;
    [0]*)
        printf ""
        ;;
    *)
        printf "0"
        ;;
    esac
}

# closes neovim, reopens neovim at original monitor with original files opened.
# requires neovim-remote (nvr), hyprland, kitty terminal emulator
# potentially change nvim launch script for simpler script => dont close terminal emulator simply quit and reopen neovim

serverlist="$(nvr --serverlist | head -n 1)"

[ -z "$serverlist" ] && {
    echo "no neovim instance found" >&2
    exit
}

# get window files
files="$(nvr --servername "$serverlist" --nostart --remote-expr 'join(map(range(1, tabpagenr("$")), "v:val . \" \" . join(map(tabpagebuflist(v:val), \"fnamemodify(bufname(v:val), \\\":p\\\")\"), \"\n\")"), "\n")')"
# get first file and remove it from the files variable
first_file=""
while { [ ! -f "$first_file" ] && [ -n "$files" ]; }; do
    first_file=$(echo "$files" | awk '{print $2}' | head -n 1)
    files=$(echo "$files" | sed '1d')
done

nvim_info=$(hyprctl -j clients | jq '.[] | select(.title | test(".*NVIM$")) | {address: .address, monitor: .monitor}')
nvim_window_address=$(echo "$nvim_info" | jq -r '.address')
nvim_window_monitor=$(echo "$nvim_info" | jq -r '.monitor')

# close neovim windows
[ "$nvim_window_address" = "" ] || {
    while read -r line; do
        line=${line#?}
        line=${line%?}
        hyprctl dispatch closewindow address:"$line"
    done <<<"$nvim_window_address"
}

# kill problematic nvim processess
killall nvim
killall --signal KILL nvim

# open kitty and execute nvim with first file
setsid -f kitty --class "nvim" -e sh -c 'exec nvim "'"$first_file"'"'

# wait a bit and get new window address and serverlist
nvim_window_address=""
serverlist=""
timeout=500
elapsed=0
while { [ "$nvim_window_address" = "" ] || [ "$serverlist" = "" ]; } && [ "$elapsed" -lt "$timeout" ]; do
    serverlist="$(nvr --serverlist | head -n 1)"
    nvim_window_address=$(hyprctl -j clients | jq '.[] | select(.title | test(".*NVIM$")) | .address')
    sleep 0.01
    elapsed=$((elapsed + 1))
done

[ "$elapsed" -lt "$timeout" ] || {
    echo "trying to get a new window address and neovim server caused a timed out." >&2
    exit
}

# move window to original monitor
hyprctl dispatch focuswindow address:"$nvim_window_address"
hyprctl dispatch movewindow mon:"$nvim_window_monitor"

# open files
skipped_tab=0
[ "$files" = "" ] || {
    while read -r line; do
        id=$(echo "$line" | awk '{print $1}')
        if { [ "$(is_integer "$id")" ] || [ "$skipped_tab" = 1 ]; }; then
            path=$(echo "$line" | cut -d ' ' -f 2-)
            cmd=tabnew
            skipped_tab=0
        else
            cmd=vsplit
            path=$line
        fi
        [ -z "$path" ] && continue
        echo "$path" | grep -q "\[Command Line\]\|/$" && {
            if [ "$(is_integer "$id")" ]; then
                skipped_tab=1
            fi
            continue
        }
        nvr --servername "$serverlist" -c "$cmd | e $path"
    done <<<"$files"
}

# call the = hotkey for equalizing splits
nvr --servername "$serverlist" --nostart --remote-send "="
