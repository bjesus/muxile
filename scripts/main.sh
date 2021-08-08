#!/usr/bin/env bash

echo '📺 Muxile'

SCRIPTS="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd "$SCRIPTS"

if test -S "/tmp/muxile.socket"; then
    echo 'Stopping Muxile...'
    websocat_pid=-$(cat websocat.pid)
    kill -TERM -- $websocat_pid
    echo '- WebSocket connection stopped (PID '$websocat_pid')'
    bash restore-defaults.sh
    rm restore-defaults.sh
    tmux set-hook -gu 'alert-activity'
    echo '- Tmux hooks unset'
    rm /tmp/muxile.socket
    echo '- Socket file removed'
    echo 'Muxile is off.'
else
    # Generate an ID for the session
    uuid=$(uuid)
    # Open WebSocket connection, UNIX socket and key forwarder
    setsid websocat --exec-sighup-on-stdin-close -tE unix-l:/tmp/muxile.socket reuse-raw:sh-c:'websocat -t - wss://muxile.zaraz.workers.dev/api/room/'"$uuid"'/websocket | xargs -n1 -d"\n" ./keys-forwarder.sh' &>/dev/null & disown;
    echo $! > websocat.pid
    # Save current config so we can revert later
    echo "tmux set "$(tmux show-option -g visual-activity) >> restore-defaults.sh
    echo "tmux set "$(tmux show-option -g activity-action) >> restore-defaults.sh
    echo "tmux set "$(tmux show-option -g monitor-activity) >> restore-defaults.sh
    # Set tmux hook
    tmux set visual-activity on
    tmux set activity-action any
    tmux set monitor-activity on
    tmux set-hook -g 'alert-activity' "run 'sh "${SCRIPTS}"/emitter.sh'"
    # Show QR code and link
    qrencode -m 2 -t utf8 <<< "https://muxile.zaraz.workers.dev/join/"$uuid
    echo "https://muxile.zaraz.workers.dev/join/"$uuid
fi
