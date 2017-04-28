#!/bin/bash
declare -A SET_NAMES
SET_NAMES[IPv4]=rixv4
SET_NAMES[IPv6]=rixv6

BASE_URL=http://rix.is
declare -A FILE_NAMES
FILE_NAMES[IPv4]=$BASE_URL/is-net.txt
FILE_NAMES[IPv6]=$BASE_URL/is-net6.txt

declare -A SET_FAMILIES
SET_FAMILIES[IPv4]=inet
SET_FAMILIES[IPv6]=inet6

function work()
{
    setname=${SET_NAMES[$1]}
    ipset -L $setname 
    if [ $? -eq 0 ]
    then
        ipset create tmpset hash:net family ${SET_FAMILIES[$1]}
        for i in `curl ${FILE_NAMES[$1]}` 
        do 
            ipset add tmpset $i 
        done
        ipset swap tmpset $setname
        ipset destroy tmpset
    fi
}

work IPv4
work IPv6
