#!/bin/env bash
echo "dump_iohigh & dump_iolow started at '$(date)'" > ionice.log

ionice_high() {
   ionice -c 1 -n 0 dd if=/dev/urandom of=test_high bs=100M count=50 oflag=direct
   echo "dump_iohigh stoped at '$(date)'" >> ionice.log
}

ionice_low() {
   ionice -c 3 dd if=/dev/urandom of=test_low bs=100M count=50 oflag=direct
   echo "dump_iolow stoped at '$(date)'" >> ionice.log
}

ionice_high & 
ionice_low &
