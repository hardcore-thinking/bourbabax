#!/bin/bash

HOST=""
USER=""
API_REGISTER_ENDPOINT=""
MAC=""

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


## Fonction d'envoi du ping
heartbeat(){
    setup "heartbeat"
    while true
    do
        response=$(curl --request PUT --data "{\"mac\": \"$MAC\"}" --write-out '%{http_code}' --output /dev/null --user-agent "AirNet/1.0" $API_REGISTER_ENDPOINT)
        echo $response
        if [ $? -ne '0' ] || [ $response -ne '200' ]; then
            sleep 5s
            register
        fi
        sleep 5m
    done
}

register(){
    setup "register"

    # create an array of ports
    IFS=',' read -ra ssh_key <<< "$ssh_key"

    # Get ports from API with the user agent and the mac address
    REMOTE_PORTS=$(curl --request POST --verbose \
                        --data \
                        "{ \
                            \"mac\": \"$MAC\", \
                            \"sshKey\": \"$ssh_key\", \
                            \"ports\": [15] \
                        }" \
                        --user-agent "AirNet/1.0" \
                        --location $API_REGISTER_ENDPOINT --trace-ascii /dev/stdout)
    echo "####################################################################################################################### $? $REMOTE_PORTS"
    if [ $? -ne '0' ] || [ [ $REMOTE_PORTS != "201" ] && [ $REMOTE_PORTS != "304" ] ]; then
        sleep 5m
        register
    fi
    echo "Getting ports from API: $API_REGISTER_ENDPOINT, mac=$MAC, ports=$LOCAL_PORTS"
    # REMOTE_PORTS=8022,8080,8443,18327
    echo "Remote ports: $REMOTE_PORTS"
    # create an array of ports
    IFS=',' read -ra REMOTE_PORTS <<< "$REMOTE_PORTS"

    # Loop over each port and create a reverse SSH tunnel from the raspberry to the server
    for i in "${!LOCAL_PORTS[@]}"; do
        LOCAL_PORT=${LOCAL_PORTS[$i]}
        REMOTE_PORT=${REMOTE_PORTS[$i]}
        echo "Checking if port $LOCAL_PORT is used"
        if lsof -Pi :$LOCAL_PORT -sTCP:LISTEN -t >/dev/null ; then
            echo "Local port $LOCAL_PORT is used"
            echo "Creating reverse SSH tunnel for port $LOCAL_PORT to $REMOTE_PORT"
            autossh -M 0 -f -N -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -R $REMOTE_PORT:localhost:$LOCAL_PORT $USER@$HOST
            systemctl start mosquitto.service
        fi
    done

    heartbeat
}

main(){
    echo "Launching main" > /tmp/main.log

    # find available local ports
    # read locals ports from config file
    LOCAL_PORTS=2222
    # read ssh key from file
    if [ -f /root/.ssh/id_rsa.pub ]; then
        ssh_key=$(cat /root/.ssh/id_rsa.pub)
    else
        echo "SSH key not found, generating a new one."
        generate_ssh_key
        ssh_key=$(cat /root/.ssh/id_rsa.pub)
    fi

    # Parse options
    while getopts ":dq" opt; do
    case $opt in
        d)
            loggingMode="DEBUG"
            ;;
        q)
            loggingMode="QUIET"
            ;;
        *)
            echo "Usage: $0 [-d] [-q]"
            exit 1
            ;;
    esac
    done
    
    echo "Local ports: $ssh_key"

    register

    #while [ 1 ]; do
    #    mosquitto_sub -L "mqtt://test:test@212.83.155.128:1883/test_topic/#" \
    #                  -i $MAC
    #    sleep 5
    #done
}

main
