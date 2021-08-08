# 📺 Muxile

## Putting tmux on your mobile

Muxile is a tmux plugin that lets you move your running tmux session to your phone, without needing any app. Use it to keep watching a long-running process, to re-run it if it fails, or to just control your terminal remotely. You can also be used to quickly share your session with someone.

https://user-images.githubusercontent.com/55081/128633692-59978412-d319-4059-b935-779072446d93.mp4

### How to use

1. Install the plugin using [TPM](https://github.com/tmux-plugins/tpm) or load it by running `./muxile.tmux`
1. Open a `tmux` session
1. Use `prefix`+T (Shift+T) to share your tmux session
1. Muxile will load and will give you a link and QR code (go back to your terminal with `Ctrl+C`)
1. Scan the QR code with your phone and open the link
1. Magic! It's tmux on your phone
1. Use the input at the bottom to send commands back to tmux
1. Use `prefix`+T (Shift+T) to stop the session sharing

### Requirements

-   [qrencode](https://fukuchi.org/works/qrencode/) (`pacman -S qrencode`, `apt install qrencode`)
-   [jq](https://github.com/stedolan/jq) (`pacman -S jq`, `apt install jq`)
-   [websocat](https://github.com/vi/websocat/) (`pacman -S websocat`)

### How it works

Muxile uses a Cloudflare Worker that serves as WebSocket server and allows the communication between tmux and the remote viewer. It uses `websocat` to send data from and to tmux over UNIX sockets. The backend code is [here](https://github.com/bjesus/muxile-worker) and you're free to run your own if you want.

### See also

-   [tmate.io](tmate.io)
