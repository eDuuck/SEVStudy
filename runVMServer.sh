#!/bin/dash

des_freq=1900000

sudo cpufreq-set -r -c 10 -g performance -u $des_freq -d $des_freq
freq=$(cat /sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq)
if [ "$freq" -eq "$des_freq" ]; then
  echo "Cpu frequency is pinned to 1900000".
  sev-step-userland/post-startup-script.sh 10 $des_freq
else
  echo "Cpu frequency is not pinned."
  sev-step-userland/post-startup-script.sh 10 NULL
fi

USER="user" # Replace with your username
HOST="localhost"
PORT="2222"
COMMAND="./vm-server" # List files in a directory
PASSWORD="pass"
# Send the command over SSH

expect <<EOF
spawn ssh -p $PORT $USER@$HOST "$COMMAND"
expect "password:"
send "$PASSWORD\r"
expect eof
EOF
