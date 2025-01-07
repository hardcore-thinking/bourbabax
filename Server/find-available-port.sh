ports=$(netstat -lntu | grep tcp | awk '{ print $4 }' | cut -d: -f2 | sort -V | sed '/^$/d')

for (i = 1025; i < 65536; i++ )
do
    unavailable=false
    for port in $ports
    do
        #port is reserve
        if [ $i -le 1024]
        then
            continue
        fi

        # port is unavailable
        if [ $1=$port ]
        then
            unavailable=true
        break
    done

    # port is available
    if [ $unavailable == false ]
    then
        echo $port
        break
    fi
done