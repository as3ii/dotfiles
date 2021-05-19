#!/usr/bin/sh

# set jackd scheduler
#chrt -apf 80 "$(pidof jackd)"

#chrt -f 20 alsa_in -d hw:Loopback,1 -j "loopout" -p256 -n3 -c2 -r48000 >/dev/null&
#chrt -f 20 alsa_out -d hw:PCH -j "PCH" -p256 -n3 -c2 -r48000 >/dev/null&
while pgrep "jackdbus" >/dev/null; do
    pgrep -x "non-mixer" >/dev/null || \
        chrt -f 70 non-mixer /home/as3ii/.config/ntk/mixer
    sleep 2
done &
