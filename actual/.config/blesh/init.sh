function blerc/vim-mode-hook {
    bleopt keymap_vi_mode_show=
    bleopt keymap_vi_mode_string_nmap=
    ble-import vim-surround
}
blehook/eval-after-load keymap_vi blerc/vim-mode-hook

ble-bind -m vi_imap -f 'C-c' discard-line
ble-bind -m vi_nmap -f 'C-c' discard-line
