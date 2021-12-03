#!/usr/bin/env bash

echo "backuping system configuration files..."

root=$(dirname "${BASH_SOURCE[0]}")

# loop through all files in folders except .git folders
while IFS= read -r -d '' inner_fpath
do
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
        # copy files from system to git repo if they are different
        if [[ $(cmp "$out_fpath" "$inner_fpath") ]]; then
            if [ "$(stat -c '%U' "$out_fpath")" != "$USER" ]; then
                # if file owned not by currect user, copy it with sudo
                sudo cp "$out_fpath" "$inner_fpath"
            else
                cp "$out_fpath" "$inner_fpath"
            fi
        fi
    fi
done<   <(find "$root" -mindepth 2 -type f -not -path "*.git/*" -print0)

# commit and push changes (if any) and if not dry run
if [[ -z "$BACKUP_DRY_RUN" ]]; then
    # check if something was changed
    CHANGED=$(git -C "$root" diff-index --name-only HEAD --)
    if [ -n "$CHANGED" ]; then
        # Allow user to review changes and discard them
        git -C "$root" status
        git -C "$root" --no-pager diff
        read -rp "Accept changes? [Y/n]: " save_chages

        if [[ "$save_chages" != "n" ]]; then
            # Allow to choose commit message
            read -rp "Write custom commit message (or enter to skip): " commit_message
            if [[ "$commit_message" == "" ]]; then
                commit_message="Someting changed"
            fi

            git -C "$root" add .
            git -C "$root" commit -m "$commit_message"
            git -C "$root" push
        fi
    fi
fi

echo "backup completed"
