#!/usr/bin/env bash

echo "backuping system configuration files..."

root=$(dirname "${BASH_SOURCE[0]}")

# loop through all files in folders except .git folders
for inner_fpath in $(find "$root" -mindepth 2 -type f -not -path "*.git/*"); do
    # strip absolute path to make it relative to script directory
    out_fpath=$(realpath --relative-to="$root" "$inner_fpath");

    # ading leading / to path to make it system compatible
    out_fpath="/$out_fpath"

    # replace home/ folder with $HOME variable
    out_fpath=$(echo "$out_fpath" | sed -e "s|^/home/|$HOME/|g")

    # if file is missing, remove it from git repo and continue
    # if [ ! -f "$out_fpath" ]; then
    #     rm "$inner_fpath"
    #     continue
    # fi

    if [[ -f "$out_fpath" ]]; then
    	# copy files from system to git repo
    	if [ "$(stat -c '%U' "$out_fpath")" != "$USER" ]; then
    	    # if file owned not by currect user, copy it with sudo
    	    sudo cp "$out_fpath" "$inner_fpath"
    	else
    	    cp "$out_fpath" "$inner_fpath"
    	fi
    fi
done

# commit and push changes (if any) and if not dry run
if [[ -z "$BACKUP_DRY_RUN" ]]; then
    git -C "$root" add .
    git -C "$root" commit -m "Someting changed" 
    git -C "$root" push
fi

echo "backup completed"
