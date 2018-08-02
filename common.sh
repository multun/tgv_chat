check_root () {
    if [[ $UID != 0 ]]; then
        echo >&2 "Must run as root"
        exit 1
    fi
}

escape_filter () {
     sed 's/[\x01-\x1F\x7F]//g'
}

prompt_username () {
    while true; do
        read -p 'Enter your username: ' username
        if [[ -n "$username" ]]; then
            break
        fi
    done
}

client_prompt () {
    while IFS='', read msg; do
        echo "<$username> $msg"
    done
}
