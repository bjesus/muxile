#!/usr/bin/env bash

SCRIPTS="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd "$SCRIPTS"

if [ -f "firstmessage" ] ; then
    rm "firstmessage"
    echo "{\"name\": \"tmux\"}" | socat UNIX-CONNECT:/tmp/muxile.socket - 
fi

pane_content=$(tmux capture-pane -p | base64 -w 0)
echo "{\"message\": \"${pane_content}\"}" | socat UNIX-CONNECT:/tmp/muxile.socket - 