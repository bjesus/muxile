#!/usr/bin/env bash

echo '📺 Muxile'
cd "$( dirname "${BASH_SOURCE[0]}" )"
if test -S "/tmp/muxile.socket"; then
    echo 'Disconnecting...'
    echo $(pwd)
    listener=$(cat listener.pid)
    kill $listener
    echo '- listener stopped (PID '$listener' )'
    websocat_pid=-$(cat websocat.pid)
    kill -TERM -- $websocat_pid
    echo '- WebSocket connection stopped (PID '$websocat_pid' )'
    rm /tmp/muxile.socket
    echo 'Done.'
else
    echo 'Starting up...'
    uuid=$(uuid)
    setsid websocat --exec-sighup-on-stdin-close -tE unix-l:/tmp/muxile.socket reuse-raw:sh-c:'websocat -t - wss://muxile.zaraz.workers.dev/api/room/'"$uuid"'/websocket | xargs -n1 -d"\n" ./keys-forwarder.sh' &>/dev/null & disown;
    echo $! > websocat.pid
    ./tmux_listener.sh &>/dev/null & disown;
    qrencode -m 2 -t utf8 <<< "https://muxile.zaraz.workers.dev/join/"$uuid
    echo "https://muxile.zaraz.workers.dev/join/"$uuid
fi