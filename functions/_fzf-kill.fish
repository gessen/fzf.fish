function _fzf-kill --description "Search and kill selected processes"
    set -f uid (id -u)
    set -f pids (ps -F -u $uid \
        | fzf --multi --layout=reverse \
        --bind="ctrl-r:reload(ps -F -u $uid)" \
        --header="Press CTRL-R to reload" \
        --header-lines=1 \
        | awk '{print $2}')

    if test "x$pids" != "x"
        echo $pids | xargs kill -9
    end
    commandline --function repaint
end
