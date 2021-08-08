#!/bin/bash

code=$@
if echo $code | jq .name | grep phone > /dev/null; then
	key=$(echo "$@" | jq -r .message)
	for word in $key
	do
	    tmux send-keys $word
	done
	tmux send-keys Enter
fi
