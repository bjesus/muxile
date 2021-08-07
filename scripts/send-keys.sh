#!/bin/bash

code=$@
if echo $code | jq .name | grep phone > /dev/null; then
	key=$(echo "$@" | jq -r .message)
	tmux send-keys $key
	tmux send-keys Enter
fi
