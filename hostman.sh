#!/bin/bash

ENABLE=0
DISABLE=0

for i in "$@"
do
    case $i in 
        -e=*|--enable=*)
        HOST="${i#*=}"
        shift
        ENABLE=1
        host=value 
    ;;
        -d=*|--disable=*)
        HOST="${i#*=}"
        shift
        DISABLE=1
    esac
done

if [ $ENABLE -eq 1 ]; then
    echo "Enable $HOST as localhost"
    echo "127.0.0.1 $HOST" >> /etc/hosts
fi
if [ $DISABLE -eq 1 ]; then
    echo "Disable $HOST as localhost"
    DOMAIN=`echo "$HOST" | sed 's/\./\\\\./g'`
    echo "DOMAIN $DOMAIN"
    sed -i ~bak -e "/$DOMAIN/d" /etc/hosts 
fi
