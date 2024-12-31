function _fzf-jj-revs --description "Search for jujutsu revision ids"
    jj root --quiet &>/dev/null; or return
    set -f lines (jj log --ignore-working-copy --no-graph --color always \
        --revisions 'ancestors(@)' \
        --template 'author.timestamp().format("%F") ++ " " ++change_id.shortest(7) ++ " " ++ description.first_line() ++ " " ++ bookmarks ++ "\n"' \
        | fzf --ansi --layout=reverse --multi \
        --preview='jj show --color=always --git --stat {2}')

    if test $status -eq 0
        for line in $lines
            set -f rev (string split --field 2 " " $line)
            set -f --append revs $rev
        end
        commandline --current-token --replace (string join " " $revs)
    end

    commandline --function repaint
end
