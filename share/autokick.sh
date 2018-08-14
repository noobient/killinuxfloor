#!/bin/sh

set -Eeu

function errorexit ()
{
    case $? in
        1)
            echo "Usage: $0 {start|stop|restart|status|log"
            ;;

        2)
            echo 'error!'
            ;;

    esac
}

trap errorexit EXIT

if [ "$#" -ne 1 ]
then
    exit 1
fi

case $1 in
    start)
        sudo /bin/systemctl start kf2autokick.service
        ;;

    stop)
        sudo /bin/systemctl stop kf2autokick.service
        ;;

    restart)
        sudo /bin/systemctl restart kf2autokick.service
        ;;

    status)
        sudo /bin/systemctl status kf2autokick.service
        ;;

    log)
        sudo /bin/journalctl --system --unit=kf2autokick.service --follow
        ;;

    *)
        exit 1

esac
