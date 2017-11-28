#!/usr/bin/env sh

worktree-switch() {
    if [ "$#" = "0" ]; then
        git worktree list
        return
    fi

    branch=`git worktree list | grep "$1" | head -n 1 | cut -f1 -d' '`

    if [ -n "$branch" ]; then
        echo "Switching to [$1] $branch"
        cd $branch
    else
        read -e -p "Worktree for branch $1 does not exist, create? [y/N] " yn
        case ${yn:0:1} in
            y|Y)
                root=`git rev-parse --show-toplevel`
                proj=`basename $root`
                dest=`realpath ${root}/../$proj-$1`
                read -e -p "Create worktree at $dest for [$1]? [y/N] " yn
                case ${yn:0:1} in
                    y|Y)
                        git worktree add $dest $1
                        ;;
                    *) ;;
		esac
		;;
            *) ;;
        esac
    fi
}


