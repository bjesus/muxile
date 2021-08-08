#!/usr/bin/env bash
pane_content=$(tmux capture-pane -p | base64 -w 0)
echo "{\"message\": \"${pane_content}\"}" | socat UNIX-CONNECT:/tmp/muxile.socket - 