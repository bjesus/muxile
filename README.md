# Muxile

## Putting tmux on your mobile

Muxile is a tmux plugin that uses WebSockets to connect your currently running tmux session with a webpage loaded on your phone, allowing your to view your terminal and control it remotely.

### How to use

1. Use `tmux`
1. Install the tmux plugin or load it by running `./muxile.tmux`
1. Use `prefix`+T (Shift+T)
1. Muxile will load and will give you a link and QR code
1. Scan the QR code with your phone and open the link
1. Magic! It's tmux on your phone
1. Type in the input at the bottom to send commands back to tmux

### Requirements

-   [qrencode](https://fukuchi.org/works/qrencode/)
-   [uuid](http://www.ossp.org/pkg/lib/uuid/)
-   [websocat](https://github.com/vi/websocat/)
