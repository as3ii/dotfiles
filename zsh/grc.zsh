if [[ "$TERM" != dumb ]] && (( $+commands[grc] )) ; then

  # Supported commands
  cmds=(
    as \
    blkid \
    cat \
    cc \
    configure \
    cvs \
    df \
    diff \
    docker \
    docker-machine \
    du \
    dig \
    env \
    free \
    fdisk \
    findmnt \
    gcc \
    g++ \
    gmake \
    gas \
    getfacl \
    head \
    ifconfig \
    id \
    ip \
    iostat \
    iptables \
    last \
    ldap \
    lsof \
    lsblk \
    lspci \
    lsattr \
    lsmod \
    make \
    mount \
    mtr \
    netstat \
    nmap \
    ping \
    ping6 \
    ps \
    ss \
    sysctl \
    systemctl \
    stat \
    showmount \
    tail \
    traceroute \
    traceroute6 \
    tcpdump \
    tune2fs
    ulimit \
    uptime \
    vmstat \
    who \
    wdiff \
    whois \
    iwconfig \
  );

  # Set alias for available commands.
  for cmd in $cmds ; do
    if (( $+commands[$cmd] )) ; then
      alias $cmd="grc --colour=auto $(whence $cmd)"
    fi
  done

  # Clean up variables
  unset cmds cmd
fi
