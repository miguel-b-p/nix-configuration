$env.config = ($env.config | upsert keybindings (
    ($env.config | get -i keybindings | default [])
    | append {
        name: fzf_history
        modifier: control
        keycode: char_r
        mode: [emacs, vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "commandline (history | each { |it| $it.command } | uniq | reverse | str join (char -i 0) | fzf --read0 --layout=reverse --height=40% -q (commandline) | decode utf-8 | str trim)"
        }
    }
    | append {
        name: fzf_files
        modifier: control
        keycode: char_t
        mode: [emacs, vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "commandline (fzf --layout=reverse --height=40% -q (commandline) | decode utf-8 | str trim)"
        }
    }
))
