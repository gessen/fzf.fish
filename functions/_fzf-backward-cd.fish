function _fzf-backward-cd --description "Change directory backwards"
    set -f dir (pwd \
        | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' \
        | fzf --layout=reverse --tac --select-1 --exit-0 \
        --preview='tree -C {} | head -200')

    if test -n "$dir"
        cd -- $dir
    end
    commandline --function repaint
end
