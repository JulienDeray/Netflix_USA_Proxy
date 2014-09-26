#!/bin/bash

function box() { t="$1xxxx";c=${2:-=}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; }

function spinner()
{
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

function waiting_spinner()
{
    local delay=1
    local spinstr='|/-\'
    local i=0
    until [ $i -ge $1 ]
    do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
        i=$[$i+1]
    done
    printf "    \b\b\b\b"
}

box "Creating instance"
(gcloud compute instances create netflix --zone us-central1-b)&
spinner $!

box "Connection"
waiting_spinner 10
n=0
maxattempt=5
until [ $n -ge $maxattempt ]
do
  gcloud compute ssh netflix --zone us-central1-b --ssh-flag="-D 1080"
  [ $? -eq 0 ] && break
  n=$[$n+1]
  waiting_spinner 5
done

box "Deleting instance"
gcloud compute instances delete netflix --zone us-central1-b
exit