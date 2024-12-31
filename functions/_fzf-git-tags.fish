function _fzf-git-tags --description "Search for git tags"
    git rev-parse HEAD &>/dev/null; or return
    set -f lines (git tag \
        | fzf --reverse --tac --multi --preview-window 66% \
        --preview='git log --oneline --date=short --color=always {1}')

    if test $status -eq 0
        for line in $lines
            set -f tag (string split --field 1 ' ' $line)
            set -f --append tags $tag
        end
        commandline --current-token --replace (string join ' ' $tags)
    end

    commandline --function repaint
end
