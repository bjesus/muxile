#!/usr/bin/env bash

echo $$ > listener.pid
sleep 1
echo '{"name": "tmux"}' | socat UNIX-CONNECT:/tmp/muxile.socket -
pane_content=$(tmux capture-pane -p | base64 -w 0)
echo "{\"message\": \"${pane_content}\"}" | socat UNIX-CONNECT:/tmp/muxile.socket - 

while true
do 
    sleep 1
    new_pane_content=$(tmux capture-pane -p | base64 -w 0)
    if [ "$pane_content" != "$new_pane_content" ]; then
        pane_content=$new_pane_content
        echo "{\"message\": \"${pane_content}\"}" | socat UNIX-CONNECT:/tmp/muxile.socket -
    fi
done

