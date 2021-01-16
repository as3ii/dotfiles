#!/usr/bin/sh

alsa_in -d hw:Loopback,1 -j "loopout" -p256 -n3 -c2 -r48000 >/dev/null&
alsa_out -d hw:PCH -j "PCH" -p256 -n3 -c2 -r48000 >/dev/null&
while pgrep "jackd" >/dev/null; do
    pgrep -x "non-mixer" >/dev/null || non-mixer /home/as3ii/.config/ntk/mixer
    sleep 2
done &
