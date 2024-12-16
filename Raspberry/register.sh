#!/bin/bash

generate_ssh_key(){
    if [ loggingMode == "NORMAL" -o loggingMode == "DEBUG" ]; then
        echo "Generating SSH key"
    fi
    ssh-keygen -t rsa  -f /root/.ssh/id_rsa -N ""
}

setup(){
    HOST="212.83.155.128"
    USER="root"
    API_REGISTER_ENDPOINT="http://$HOST:3000/api/$1"
    MAC=$(cat /sys/class/net/eth0/address)
    # generate_ssh_key
}

ineedport(){
    setup "manageport"
    while true
    do
        response=$(curl --write-out '%{http_code}' --silent --output nul -X POST -d "mac=$MAC" -A "AirNet/1.0" $API_REGISTER_ENDPOINT)
        if [ $? -eq 0 -a $response -eq 200 ]; then
            echo "the co is backkkkk"
            ping
        fi
        sleep 1m
    done

}

## Fonction d'envoi du ping
ping(){
    setup "heartbeat"
    while true
    do
        response=$(curl --write-out '%{http_code}' --silent --output nul -X POST -d "mac=$MAC" -A "AirNet/1.0" $API_REGISTER_ENDPOINT)
        if [ $? -ne 0 -o $response -ne 200 ]; then
            ineedport
        fi
        sleep 1m
    done
}

main(){
    ping
    # read locals ports from config file
    # LOCAL_PORTS=$(cat /etc/airnet/ports)
    # read ssh key from file
    # if [ -f /root/.ssh/id_rsa.pub ]; then
    #     ssh_key=$(cat /root/.ssh/id_rsa.pub)
    # else
    #     echo "SSH key not found, generating a new one."
    #     generate_ssh_key
    #     ssh_key=$(cat /root/.ssh/id_rsa.pub)
    # fi

    # # Parse options
    # while getopts ":dq" opt; do
    # case $opt in
    #     d)
    #         loggingMode="DEBUG"
    #         ;;
    #     q)
    #         loggingMode="QUIET"
    #         ;;
    #     *)
    #         echo "Usage: $0 [-d] [-q]"
    #         exit 1
    #         ;;
    # esac
    # done
    
    # setup "register"


    # echo "Local ports: $ssh_key"
    # # create an array of ports
    # IFS=',' read -ra ssh_key <<< "$ssh_key"

    # # Get ports from API with the user agent and the mac address
    # REMOTE_PORTS=$(curl -X POST -d "mac=$MAC&ssh_key=$ssh_key" -A "AirNet/1.0" $API_REGISTER_ENDPOINT)

    # echo "Getting ports from API: $API_REGISTER_ENDPOINT, mac=$MAC, ports=$LOCAL_PORTS"
    # # REMOTE_PORTS=8022,8080,8443,18327
    # echo "Remote ports: $REMOTE_PORTS"
    # # create an array of ports
    # IFS=',' read -ra REMOTE_PORTS <<< "$REMOTE_PORTS"

    # Loop over each port and create a reverse SSH tunnel from the raspberry to the server
    # for i in "${!LOCAL_PORTS[@]}"; do
    #     LOCAL_PORT=${LOCAL_PORTS[$i]}
    #     REMOTE_PORT=${REMOTE_PORTS[$i]}
    #     echo "Checking if port $LOCAL_PORT is used"
    #     if lsof -Pi :$LOCAL_PORT -sTCP:LISTEN -t >/dev/null ; then
    #         echo "Local port $LOCAL_PORT is used"
    #         echo "Creating reverse SSH tunnel for port $LOCAL_PORT to $REMOTE_PORT"
    #         autossh -M 0 -f -N -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -R $REMOTE_PORT:localhost:$LOCAL_PORT $USER@$HOST
    #     fi
    # done
    
}

main