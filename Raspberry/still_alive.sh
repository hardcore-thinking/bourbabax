HOST="hub.bzctoons.net"
USER="register"
API_REGISTER_ENDPOINT="http://$HOST/api/ping"
MAC=$(cat /sys/class/net/eth0/address)

echo "test"
# curl -X POST -d "mac=$MAC&ssh_key=$ssh_key" -A "AirNet/1.0" $API_REGISTER_ENDPOINT

